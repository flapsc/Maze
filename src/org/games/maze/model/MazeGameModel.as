package org.games.maze.model 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import org.games.core.model.BaseGameModel;
	import org.games.maze.model.data.MazeGameDataConfig;
	import org.games.maze.model.enums.CellNeighbors;
	import org.games.maze.model.enums.CellState;
	import starling.core.Starling;
	import starling.textures.Texture;
	
	/**
	 * The extension of base game model,
	 * implement model of maze game.
	 * @author Mihaylenko A.L.
	 */
	public final class MazeGameModel extends BaseGameModel
	{
		
		private var _width:uint;
		private var _height:uint;
		private var _cellsLength:uint;
		private var _startPoint:Point = new Point();
		private var _startPosition:ICell;
		private var _currentPlayerPosition:ICell;
		private var _mazeConfig:MazeGameDataConfig;
		private var _viewCellSize:uint;
		private var _numExit:uint;
		private var _currentPlayedTimeSec:uint;
		private var _characterScreenPosition:Point;
		private var _currentPlayerSteps:uint;
		/** Variables in game  */
		private var _field:Vector.<Vector.<ICell>>;
		private var _cells:Vector.<ICell>;
		private var _currentCellPrepareDrawIdx:int;
		private var _fillRect:Rectangle;
		private var _isRestart:Boolean;
		private var _waysNotGenerated:Vector.<ICell>;
		private var _lastSteps:Vector.<ICell>;
		private var _waysGenerated:Dictionary;
		
		private var _mazeGenerationBitmapData:BitmapData;
		private var _mazeGeneratedView:Texture;
		private var _characterTexture:Texture;
		private var _characterBmd:BitmapData;
		
		
		/**
		 * Constructor.
		 */
		public function MazeGameModel(){}
		
		public override function validateData():Boolean 
		{

				
			if (!_mazeConfig)
			{
				_mazeConfig = _dataConfig as MazeGameDataConfig;
			}
			_startPoint.setTo( uint(_width * _mazeConfig.startPointPercent.x), uint(_height * _mazeConfig.startPointPercent.y) );
			if (
					!_dataConfig
					||
					!_width
					||
					!_viewCellSize
				)
				return false;			
			return true;
		}		
		protected override function extStartGame(...args):void
		{
			
			if (!_mazeConfig)
			{
				_mazeConfig = _dataConfig as MazeGameDataConfig;
			}			
			_isRestart = false;
			_lastSteps ||= Vector.<ICell>([]);
			_characterScreenPosition ||= new Point();
			_currentPlayedTimeSec = 0;
			_currentPlayerSteps = 0;
			_lastSteps.length = 0;
			_waysGenerated = new Dictionary();
			_mazeGenerationBitmapData = new BitmapData( _width * _viewCellSize, _height * _viewCellSize, true, 0x000000);
			_fillRect = new Rectangle(0, 0, _viewCellSize, _viewCellSize);
			_startPoint.setTo( uint(_width*_mazeConfig.startPointPercent.x), uint(_height*_mazeConfig.startPointPercent.y) );
			initMazeFieldCells();
		}
		protected override  function initializeComplete():void 
		{
			super.initializeComplete();
			addKeyForIgnoreSerialize("startPoint");
			addKeyForIgnoreSerialize("mazeGeneratedView");
		}
		
		/**
		 * 
		 * @return
		 */
		public function updateGenerationMazeField( iterations:uint = 5000 ):Boolean
		{
			if (_numExit)//genarete exits
			{
				var potentialExits:Vector.<ICell> = _cells.filter
				(
					function( item:ICell, index:uint, vec:Vector.<ICell> ):Boolean
					{
						return item.state == CellState.WALL	&&
								!
								(
									(
										!item.getNeighbor(CellNeighbors.BOTTOM) ||
										!item.getNeighbor(CellNeighbors.TOP)
									)&&
									(
										!item.getNeighbor(CellNeighbors.LEFT) ||
										!item.getNeighbor(CellNeighbors.RIGHT)
									)
								)
					},
					this
				);
				
				var rndExit:uint;
				while (_numExit--)
				{
					rndExit = potentialExits.length * Math.random();
					potentialExits.splice(rndExit, 1)[0].state = CellState.POTENTIAL_EXIT;
				}
				_numExit = 0;
				_waysNotGenerated = _cells.filter
				(
					function( item:ICell, index:uint, vec:Vector.<ICell> ):Boolean
					{
						return item.state == CellState.POTENTIAL_EXIT;
					},
					this
				);
				_startPosition = _field[uint(_startPoint.x)][uint(_startPoint.y)];
				_currentPlayerPosition = _startPosition;
				_currentPlayerPosition.state = CellState.FREE_TO_MOVE;
				return false;
			}
			else if( _waysNotGenerated.length )//generate ways
			{
				var candidatesStep:Vector.<ICell>;
				var nextCheckWay:ICell;
				while ( iterations--  )
				{
					//When is potential extit then way is calculated, set cell is exit and try get ned potential exit
					if ( _currentPlayerPosition.state == CellState.POTENTIAL_EXIT )
					{
						_currentPlayerPosition.state = CellState.EXIT;
						//_waysNotGenerated.splice(_waysNotGenerated.indexOf(_currentPlayerPosition), 1);
						_waysGenerated[_waysNotGenerated.splice(_waysNotGenerated.indexOf(_currentPlayerPosition), 1)[0]] = _lastSteps.concat();
						while ( _lastSteps.length )
							_lastSteps.pop().state = CellState.POTENTIAL_WALL;
							
						_currentPlayerPosition = _startPosition;
						return false;
					}
					else
					{
						candidatesStep = _currentPlayerPosition.getCandidatesToGenerateWay();
						if ( candidatesStep.length )
						{
								
							_currentPlayerPosition.state = CellState.FREE_TO_MOVE;
							_lastSteps[_lastSteps.length] = _currentPlayerPosition;
							
							_currentPlayerPosition = getExitCellOrBestWay();
							function getExitCellOrBestWay():ICell
							{

								var tmpVec:Vector.<ICell> =
									candidatesStep.filter
									( 
										function(cell:ICell, index:uint, cells:Vector.<ICell>):Boolean 
										{
											return cell.state == CellState.POTENTIAL_EXIT;
										}
									);
								if ( tmpVec.length )
								{
									return tmpVec[0];
								}
								
								if ( _currentPlayerPosition.x % 2 == 0 )
								{
									if
									( 
										_currentPlayerPosition.getNeighbor(CellNeighbors.LEFT)
										&&
										_currentPlayerPosition.getNeighbor(CellNeighbors.LEFT).state == CellState.POTENTIAL_WALL
									)
									{
										return _currentPlayerPosition.getNeighbor(CellNeighbors.LEFT);
									}
									else if
									(
										_currentPlayerPosition.getNeighbor(CellNeighbors.RIGHT)
										&&
										_currentPlayerPosition.getNeighbor(CellNeighbors.RIGHT).state == CellState.POTENTIAL_WALL										
									)
									{
										return _currentPlayerPosition.getNeighbor(CellNeighbors.RIGHT);
									}
								}
								else if ( _currentPlayerPosition.y % 2 == 0 )
								{
									if
									( 
										_currentPlayerPosition.getNeighbor(CellNeighbors.TOP)
										&&
										_currentPlayerPosition.getNeighbor(CellNeighbors.TOP).state == CellState.POTENTIAL_WALL
									)
									{
										return _currentPlayerPosition.getNeighbor(CellNeighbors.TOP);
									}
									else if
									(
										_currentPlayerPosition.getNeighbor(CellNeighbors.BOTTOM)
										&&
										_currentPlayerPosition.getNeighbor(CellNeighbors.BOTTOM).state == CellState.POTENTIAL_WALL
									)
									{
										return _currentPlayerPosition.getNeighbor(CellNeighbors.BOTTOM);
									}									
								}								
								
								
								tmpVec = candidatesStep.filter
								(
									function( cell:ICell, index:uint, cells:Vector.<ICell> ):Boolean
									{
										return Boolean
										( 
											_lastSteps.indexOf(cell) ==-1
											&&
											(
												(
													cell.getNeighbor(CellNeighbors.LEFT) &&
													cell.getNeighbor(CellNeighbors.RIGHT) &&
													cell.getNeighbor(CellNeighbors.LEFT).state != CellState.FREE_TO_MOVE &&
													cell.getNeighbor(CellNeighbors.RIGHT).state !== CellState.FREE_TO_MOVE
												)
												||
												(
													cell.getNeighbor(CellNeighbors.TOP) &&
													cell.getNeighbor(CellNeighbors.BOTTOM) &&
													cell.getNeighbor(CellNeighbors.TOP).state != CellState.FREE_TO_MOVE &&
													cell.getNeighbor(CellNeighbors.BOTTOM).state !== CellState.FREE_TO_MOVE
												)
												||
												(
													cell.getNeighbor(CellNeighbors.TOP) &&
													cell.getNeighbor(CellNeighbors.LEFT) &&
													cell.getNeighbor(CellNeighbors.TOP).state != CellState.FREE_TO_MOVE &&
													cell.getNeighbor(CellNeighbors.LEFT).state !== CellState.FREE_TO_MOVE
												)
												||
												(
													cell.getNeighbor(CellNeighbors.TOP) &&
													cell.getNeighbor(CellNeighbors.RIGHT) &&
													cell.getNeighbor(CellNeighbors.TOP).state != CellState.FREE_TO_MOVE &&
													cell.getNeighbor(CellNeighbors.RIGHT).state !== CellState.FREE_TO_MOVE
												)											
												||
												(
													cell.getNeighbor(CellNeighbors.BOTTOM) &&
													cell.getNeighbor(CellNeighbors.LEFT) &&
													cell.getNeighbor(CellNeighbors.BOTTOM).state != CellState.FREE_TO_MOVE &&
													cell.getNeighbor(CellNeighbors.LEFT).state !== CellState.FREE_TO_MOVE
												)
												||
												(
													cell.getNeighbor(CellNeighbors.BOTTOM) &&
													cell.getNeighbor(CellNeighbors.RIGHT) &&
													cell.getNeighbor(CellNeighbors.BOTTOM).state != CellState.FREE_TO_MOVE &&
													cell.getNeighbor(CellNeighbors.RIGHT).state !== CellState.FREE_TO_MOVE
												)
											)
											
										)
									}
								);
								//if (tmpVec)
									//return tmpVec[0];
								candidatesStep = tmpVec.length?tmpVec:candidatesStep;
								
								return candidatesStep[Math.floor(Math.random() * candidatesStep.length)];
							}
							
						}
						else if ( _lastSteps.length )
						{
							_currentPlayerPosition = _lastSteps.pop();
						}
						else
						{
							_currentPlayerPosition = _startPosition;
						}
					}
				}
				return false;
			}
			else if( _waysGenerated )
			{
				var itemGeneratedWays:Vector.<ICell>;
				for (var key:ICell in _waysGenerated)
				{
					itemGeneratedWays = _waysGenerated[key];
					while (itemGeneratedWays.length)
					{
						itemGeneratedWays.pop().state = CellState.FREE_TO_MOVE;
					}
					delete _waysGenerated[key];
				}
				_waysGenerated = null;
				//set potential wall to wall state
				_cells.forEach
				(
					function(item:ICell, index:uint, vec:Vector.<ICell>):void
					{
						if ( item.state == CellState.POTENTIAL_WALL )
							item.state = CellState.WALL;
					},
					this
				)
				_currentPlayerPosition = _startPosition;
				syncCharacterModelAndViewPos();
				return true;
			}
			return true;
		}
		
		private function syncCharacterModelAndViewPos():void
		{
			_characterScreenPosition.setTo(_currentPlayerPosition.x * _viewCellSize, _currentPlayerPosition.y * _viewCellSize);
		}
		
		public function get characterScreenPorision():Point
		{
			return _characterScreenPosition;
		}
		
		public function updateDrawGenerationView( numCellsToDraw:uint = 400 ):Boolean
		{
			var curCellModelToDraw:ICell;
			while (_currentCellPrepareDrawIdx--)
			{

					
				curCellModelToDraw = _cells[_currentCellPrepareDrawIdx];
				if ( curCellModelToDraw.state == CellState.WALL )
				{
					_fillRect.x = curCellModelToDraw.x * _viewCellSize;
					_fillRect.y = curCellModelToDraw.y * _viewCellSize;
					_mazeGenerationBitmapData.fillRect(_fillRect, _mazeConfig.wallColor);
					
				}		
				
				if (!--numCellsToDraw)
					break;
			}
			if (_currentCellPrepareDrawIdx < 0)
			{
				_mazeGeneratedView = Texture.fromBitmapData(_mazeGenerationBitmapData);
				_mazeGeneratedView.root.onRestore =
				function():void
				{
					_mazeGeneratedView.root.uploadBitmapData(_mazeGenerationBitmapData);
				}
				
				_fillRect.x = 0;
				_fillRect.y = 0;
				_characterBmd = new BitmapData(_viewCellSize, _viewCellSize);
				_characterBmd.fillRect(_fillRect, _mazeConfig.characterColor);
				
				_characterTexture = Texture.fromBitmapData(_characterBmd);
				_characterTexture.root.onRestore = 
				function():void
				{
					_characterTexture.root.uploadBitmapData( _characterBmd );
				}
				return true;
			}
			return false;
		}

		
		public function getCellByScreenPosition( screenX:uint, screenY:uint ):ICell
		{
			return null
		}
		
		
		public function moveToNeighbor( neighbor:uint ):Boolean
		{
			if 
			(
				_currentPlayerPosition.getNeighbor(neighbor ) &&
				(
					_currentPlayerPosition.getNeighbor(neighbor).state == CellState.FREE_TO_MOVE
					||
					_currentPlayerPosition.getNeighbor(neighbor).state == CellState.EXIT
				)
			)
			{
				_currentPlayerPosition = _currentPlayerPosition.getNeighbor(neighbor);
				syncCharacterModelAndViewPos();
				_currentPlayerSteps++;
				return true;
			}
			return false;
		}

		
		private function initMazeFieldCells():void
		{
			var cell:ICell;
			var column:Vector.<ICell>;
			var cellsLn:uint = 0;
			var x:uint;
			var y:uint;
			
			_cells = Vector.<ICell>([]);
			_cellsLength =
			_currentCellPrepareDrawIdx =
			_cells.length = _width * _height;
			_cells.fixed = true;
			
			_field = Vector.<Vector.<ICell>>(([]));
			_field.length = _width;
			_field.fixed = true;
			
			
			//Fill cells and grid.
			for ( x=0; x < _width; x++ )
			{
				column = Vector.<ICell>([]);
				column.length = _height;
				column.fixed = true;
				
				for ( y = 0; y < _height; y++ )
				{
					cell = new CellModel();
					cell.init(x, y);
					
					_cells[cellsLn++]=
					column[y] = cell;
				}
				_field[x] = column;
			}
			
			//Update cells neighbors
			for ( x = 0; x < _cellsLength; x++ )
				_cells[x].updateNeighborsAndCheckWallState(_field);
			
		}
		protected override  function extGameEnd():Boolean 
		{
			if ( _isRestart )
				return true;
				
			return super.extGameEnd();
		}
		public function reset():void
		{
			if (!_cells)
				return;
			_isRestart = true;
			_field.fixed = false;
			_field.length = 0;
			_field = null;
			
			_cells.fixed = false;
			while (_cells.length)
				_cells.pop().destroy();
				
			_cells = null;
			
			_mazeGeneratedView.dispose();
			_mazeGeneratedView = null;
				
			_characterTexture.dispose();
			_characterTexture = null;
			
			_characterBmd.dispose();
			_characterBmd = null;
			
			_mazeGenerationBitmapData.dispose();
			_mazeGenerationBitmapData = null;
		}
		
		public function get width():uint{return _width;}
		public function set width(value:uint):void{_width = value;}
		
		public function get height():uint{return _height;}
		public function set height(value:uint):void{_height = value; }
		
		public function get startPoint():Point{return _startPoint; }
		
		public function get viewCellSize():uint{return _viewCellSize;}
		public function set viewCellSize(value:uint):void{_viewCellSize = value; }
		
		public function get currentPlayerPosition():ICell{ return _currentPlayerPosition; }
		
		public function set numExit( value:uint ):void{ _numExit = value; }
		public function get numExit():uint{ return _numExit; }
		public function get mazeGeneratedView():Texture{return _mazeGeneratedView; }
		
		public function get currentPlayedTimeSec():uint{return _currentPlayedTimeSec; }
		public function set currentPlayedTimeSec(value:uint):void{_currentPlayedTimeSec = value; }
		
		public function get currentPlayerSteps():uint{return _currentPlayerSteps; }
		public function set currentPlayerSteps(value:uint):void{_currentPlayerSteps = value; }
		public function get characterTexture():Texture{return _characterTexture;}		
	}
}