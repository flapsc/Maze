package org.games.maze.view.intro 
{
	import org.games.core.IGameContext;
	import org.games.core.controller.view.events.ViewEvent;
	import org.games.core.services.view.impl.starling.BaseStarlingMediator;
	import org.games.maze.controller.game.events.GameStateEvent;
	import org.games.maze.model.MazeGameModel;
	import org.games.maze.model.data.MazeGameDataConfig;
	import org.games.maze.view.GameViewEnums;
	import starling.events.Event;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class IntroMediator extends BaseStarlingMediator
	{
		
		static private const LOCAL_SAVE_KEY:String = "MazeGameModel";
		
		/**
		 * TODO need create and move texts to localization service
		 */
		static private const INTRO_TEXT:String = "Test task, mini maze game. Generation of the maze is based on an algorithm using wandering point method.";
		static private const MAZE_HEIGHT_TEXT:String = "Select the height of the maze:";
		static private const MAZE_WIDTH_TEXT:String = "Select the width of the maze:";
		static private const MAZE_CELL_VIEW_SIZE_TEXT:String = "Select the cell view size of the maze:";
		static private const MAZE_NUM_EXIT_TEXT:String = "Select the number of exits from the maze:";
		
		/**
		 * Current intro view.
		 */
		private var _introView:IntroView;
		private var _gameModel:MazeGameModel;
		private var _gameDataConfig:MazeGameDataConfig;
		private var _maxTextureSize:uint;
		
		public override function init(id:uint, view:Object, gameContext:IGameContext):void 
		{
			_maxTextureSize = Texture.maxSize;
			_introView = view as IntroView;
			_gameModel = gameContext.gameModel as MazeGameModel;
			_gameDataConfig = _gameModel.dataConfig as MazeGameDataConfig;
			initializeGameModel(gameContext);
			
			super.init(id, view, gameContext);
		}
		
		protected override  function drawView():void 
		{
			super.drawView();
			setInitialComponentValues();
		}
		/**
		 * @inheritDoc
		 */
		protected override  function showComplete():void 
		{
			addEventListeners();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function destroy():void 
		{
			_introView = null;
			super.destroy();
		}
		protected override  function hideComplete():void 
		{
			//_gameContext.dispatchEvent( new GameStateEvent(GameStateEvent.PREPARE_GAME_START) );
			super.hideComplete();
		}
		private function initializeGameModel( gameContext:IGameContext ):void
		{
			_gameModel.serialize(gameContext.saveService.loadedData[LOCAL_SAVE_KEY]);
			if ( !_gameModel.validateData() )
			{
				_gameModel.width	=
				_gameModel.height 	= _gameDataConfig.maxMazeSize;
				_gameModel.numExit	= 1;
				_gameModel.viewCellSize = _gameDataConfig.minMazeSize;
			}
		}
		
		private function setInitialComponentValues():void
		{
			_introView.tfInfo.text = INTRO_TEXT;
			_introView.mazeHeightSizeLabel.text = MAZE_HEIGHT_TEXT;
			_introView.mazeWidthtSizeLabel.text = MAZE_WIDTH_TEXT;
			_introView.mazeNumExitLabel.text = MAZE_NUM_EXIT_TEXT;
			_introView.mazeCellViewSizeLabel.text = MAZE_CELL_VIEW_SIZE_TEXT;
			
			_introView.nsMazeHeightSize.minimum = 
			_introView.slMazeHeightSize.minimum = 
			_introView.nsMazeWidthSize.minimum =
			_introView.slMazeWidthtSize.minimum = _gameDataConfig.minMazeSize;
			
			_introView.nsMazeHeightSize.maximum = 
			_introView.slMazeHeightSize.maximum = 
			_introView.nsMazeWidthSize.maximum =
			_introView.slMazeWidthtSize.maximum = _gameDataConfig.maxMazeSize;
			
			_introView.nsMazeHeightSize.step = 
			_introView.slMazeHeightSize.step = 
			_introView.nsMazeWidthSize.step =
			_introView.slNumExit.step =
			_introView.nsNumExit.step =
			_introView.slCellViewSize.step =
			_introView.nsCellViewSize.step =
			_introView.slMazeWidthtSize.step = 1;
			
			_introView.nsMazeHeightSize.value = 
			_introView.slMazeHeightSize.value = _gameModel.height;
			_introView.nsMazeWidthSize.value =
			_introView.slMazeWidthtSize.value = _gameModel.width;
			
			_introView.slCellViewSize.minimum = 
			_introView.nsCellViewSize.minimum =	_gameDataConfig.minViewCellSize;

			_introView.slCellViewSize.maximum = 
			_introView.nsCellViewSize.maximum =	15;
			
			_introView.slCellViewSize.value = 
			_introView.nsCellViewSize.value =  _gameModel.viewCellSize;
			
			var maxNumExit:uint = (_gameModel.width + _gameModel.height -4) * 2;

			_introView.slNumExit.minimum =
			_introView.nsNumExit.minimum = 1;

			_introView.slNumExit.maximum =
			_introView.nsNumExit.maximum = maxNumExit;		
			
			
			_introView.slNumExit.value =
			_introView.nsNumExit.value = _gameModel.numExit?_gameModel.numExit:1;
			
			updateViewSize(Math.max(_gameModel.width, _gameModel.height));
			
		}
		
		/**
		 * Add view event listeners.
		 */
		private function addEventListeners():void
		{
			_introView.btnPlay.addEventListener(Event.TRIGGERED, btnPlay_TRIGGERED_Handler);
			_introView.slMazeWidthtSize.addEventListener(Event.CHANGE, mazeWidthtSize_CHANHE_Handler);
			_introView.slMazeHeightSize.addEventListener(Event.CHANGE, mazeHeightSize_CHANHE_Handler);
			_introView.slNumExit.addEventListener(Event.CHANGE, numExit_CHANHE_Handler);
			_introView.slCellViewSize.addEventListener(Event.CHANGE, cellViewSize_CHANHE_Handler);
		}
		

		
		/**
		 * Remove view event listeners.
		 */
		private function removeEventListeners():void
		{
			_introView.btnPlay.removeEventListener(Event.TRIGGERED, btnPlay_TRIGGERED_Handler);
			_introView.slMazeWidthtSize.removeEventListener(Event.CHANGE, mazeWidthtSize_CHANHE_Handler);
			_introView.slMazeHeightSize.removeEventListener(Event.CHANGE, mazeHeightSize_CHANHE_Handler);
			_introView.slNumExit.removeEventListener(Event.CHANGE, numExit_CHANHE_Handler);
			_introView.slCellViewSize.removeEventListener(Event.CHANGE, cellViewSize_CHANHE_Handler);
		}
		private function cellViewSize_CHANHE_Handler(e:Event):void 
		{
			_gameModel.viewCellSize = (e.currentTarget as Object).value;
		}
		
		private function numExit_CHANHE_Handler(e:Event):void 
		{
			_gameModel.numExit = (e.currentTarget as Object).value;
		}
		
		private function mazeHeightSize_CHANHE_Handler(e:Event):void 
		{
			var toVal:uint = (e.currentTarget as Object).value;
			if ( toVal == _gameModel.height)
			{
				e.stopImmediatePropagation();
				return;
			}
			if (updateViewSize(toVal) )
			{
				_gameModel.height = toVal;
				updateNumExit();
			}
			else
			{
				_introView.nsMazeHeightSize.value =
				_introView.slMazeHeightSize.value = _gameModel.height;
			}
		}
		
		private function mazeWidthtSize_CHANHE_Handler(e:Event):void 
		{
			var toVal:uint = (e.currentTarget as Object).value;
			if ( toVal == _gameModel.width)
			{
				e.stopImmediatePropagation();
				return;
			}
			if (updateViewSize(toVal) )
			{
				_gameModel.width = toVal;
				updateNumExit();
			}
			else
			{
				_introView.nsMazeWidthSize.value =
				_introView.slMazeWidthtSize.value = _gameModel.width;
			}
		}
		
		private function updateNumExit():void
		{
			var maxNumExit:uint = (_gameModel.width + _gameModel.height -4) * 2;
			if (_gameModel.numExit > maxNumExit)
			{
				_gameModel.numExit = 
				_introView.slNumExit.value= maxNumExit;
			}
			
			_introView.slNumExit.maximum =
			_introView.nsNumExit.maximum = maxNumExit;
		}
		
		
		private function updateViewSize(value:uint):Boolean
		{
			var maximumCellView:uint = _maxTextureSize / Math.max(_gameModel.width, _gameModel.height, value);
			if ( maximumCellView < _gameDataConfig.minViewCellSize )
			{
				return false;
			}
			if ( _introView.slCellViewSize.value > maximumCellView )
			{
				_introView.slCellViewSize.value =
				_introView.nsCellViewSize.value = maximumCellView;
			}
				
			_introView.slCellViewSize.maximum = 
			_introView.nsCellViewSize.maximum = maximumCellView;
			return true;
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function btnPlay_TRIGGERED_Handler(e:Event):void 
		{
			e.stopImmediatePropagation();
			removeEventListeners();
			
			_gameContext.saveService.save(LOCAL_SAVE_KEY, _gameModel);
			_gameContext.dispatchEvent( new ViewEvent( ViewEvent.HIDE_VIEW, GameViewEnums.INTRO ) );
			_gameContext.dispatchEvent( new GameStateEvent(GameStateEvent.PREPARE_GAME_START) );
		}
	}
}