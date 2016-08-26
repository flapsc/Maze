package org.games.maze.view.gamestate 
{
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	import flash.ui.Keyboard;
	import org.games.core.controller.view.events.ViewEvent;
	import org.games.core.services.view.impl.starling.BaseStarlingMediator;
	import org.games.maze.controller.game.events.GameStateEvent;
	import org.games.maze.model.MazeGameModel;
	import org.games.maze.model.enums.CellNeighbors;
	import org.games.maze.model.enums.CellState;
	import org.games.maze.view.GameViewEnums;
	import starling.animation.DelayedCall;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	/**
	 * Game state mediator, extend BaseStarlingMediator
	 * @author Mihaylenko A.L.
	 */
	public final class GameStateMediator extends BaseStarlingMediator 
	{
		static private const TIME_LABEL_PREFIX:String = "  Game time:";
		static private const STEP_LABEL_PREFIX:String = "  Distance traveled:"
		
		private var _gameStateView:GameStateView;
		private var _gameModel:MazeGameModel;
		private var _isRestart:Boolean = false;
		
		private var _gameTimer:DelayedCall;
		private var _gameTimeTweenId:uint;
		
		private var _gamePaused:Boolean = false;
		private var _waitToRestart:Boolean = false;
		
		private var _currCharacterMoveTweenId:uint;
		/**
		 * Constructor.
		 */
		public function GameStateMediator(){}
		
		protected override function drawView():void 
		{
			_gameStateView = _baseView as GameStateView;
			_gameModel = _gameContext.gameModel as MazeGameModel;
			_gameStateView.setMazeViewTextureAndTileSize( _gameModel.mazeGeneratedView, _gameModel.viewCellSize );
			_gameStateView.setCharacterTexture( _gameModel.characterTexture );
			super.drawView();
			updateDistanceTraveledLabel();
			updateGameTime();
			


		}
		
		protected override function showComplete():void 
		{
			super.showComplete();
			_gameStateView.updateCharacterPosition
			(
				_gameModel.characterScreenPorision.x, 
				_gameModel.characterScreenPorision.y,
				false
			);
			addEventListeners();
			_gameTimer = new DelayedCall(updateGameTime, 1);
			_gameTimer.repeatCount = int.MAX_VALUE;
			startGameTimer();
		}
		
		protected override function hideComplete():void 
		{
			_gameModel.reset();
			_gameModel.gameEnd();
			
			if ( _isRestart )
			{
				_gameContext.dispatchEvent( new GameStateEvent(GameStateEvent.INTRO_GAME) );
			}
			else
			{
				_gameContext.dispatchEvent( new GameStateEvent(GameStateEvent.END_GAME) );
			}
			super.hideComplete();
		}
		
		private function syncCharacterPosition():void
		{
			_gameContext.viewManager.removeTween(_currCharacterMoveTweenId);
			
			_currCharacterMoveTweenId =
			_gameContext.viewManager.addTween(
				_gameStateView.updateCharacterPosition
				(
				_gameModel.characterScreenPorision.x, _gameModel.characterScreenPorision.y 
				)
			);
		}
		
		
		private function restartBtn_TRIGGERED_Handler(e:Event):void 
		{
			_waitToRestart = true;
			stopGameTimer();
			Alert.show
			(
				"Are you sure you want to quit?",
				"Quit", new ListCollection(
				[
					{ label: "OK" },
					{ label: "Cancel" }
				])).addEventListener(Event.CLOSE,
				function(event:Event, data:Object):void
				{
					event.currentTarget.removeEventListener(Event.CLOSE, arguments.callee);
					if ( data && data.label == "OK" )
					{
						removeEventListeners();
						_isRestart = true;
						_gameContext.dispatchEvent( new ViewEvent( ViewEvent.HIDE_VIEW, GameViewEnums.GAME_STATE ) );
					}
					else
					{
						startGameTimer();
					}
					_waitToRestart = false;
				});
		}
		
		public override function stop():void 
		{
			if (_waitToRestart)
				return;
				
			super.stop();
			stopGameTimer();
		}
		
		public override function resume():void 
		{
			if ( _gamePaused || _waitToRestart)
				return;
				
			_gamePaused = true;
			Alert.show
			(
				"Click to continue the game",
				"Pause", new ListCollection(
				[
					{ label: "Continue" }
				])).addEventListener(Event.CLOSE,
				function(event:Event, data:Object):void
				{
					_gamePaused = false;
					event.currentTarget.removeEventListener(Event.CLOSE, arguments.callee);
					startGameTimer();
				});
		}
		private function stopGameTimer():void
		{
			if (_gameTimeTweenId)
			{
				_gameContext.viewManager.removeTween(_gameTimeTweenId);
				_gameTimeTweenId = 0;
			}
		}
		private function startGameTimer():void
		{
			if (!_gameTimeTweenId && _gameTimer)
			{
				_gameTimeTweenId = _gameContext.viewManager.addTween(_gameTimer);
			}
		}
		
		private function updateGameTime():void
		{
			_gameModel.currentPlayedTimeSec++;
			updateTimeLabel();
		}
		
		private function updateTimeLabel():void
		{
			_gameStateView.timerLabel.text = TIME_LABEL_PREFIX + _gameModel.currentPlayedTimeSec;
		}
		
		private function updateDistanceTraveledLabel():void
		{
			_gameStateView.currentStepLabel.text = STEP_LABEL_PREFIX + _gameModel.currentPlayerSteps;
		}
		

		private function gameStateView_KEY_DOWN_Handler(e:KeyboardEvent):void 
		{
			var currNeighbor:uint = CellNeighbors.UNKNOW;
			
			switch( e.keyCode )
			{
				case( Keyboard.LEFT ):
					currNeighbor = CellNeighbors.LEFT;
					break;
					
				case( Keyboard.RIGHT ):
					currNeighbor = CellNeighbors.RIGHT;
					break;
				case( Keyboard.DOWN ):
					currNeighbor = CellNeighbors.BOTTOM;
					break;
				case( Keyboard.UP ):
					currNeighbor = CellNeighbors.TOP;
					break;
			}
			
			if 
			(
				currNeighbor != CellNeighbors.UNKNOW
				&&
				_gameModel.moveToNeighbor(currNeighbor)
			)
			{
				if ( _gameModel.currentPlayerPosition.state == CellState.EXIT )
				{
					removeEventListeners();
					stopGameTimer();
					_gameContext.viewManager.addTween
					(
						new DelayedCall
						(
							function():void
							{
								_gameModel
								_gameContext.dispatchEvent( new ViewEvent( ViewEvent.HIDE_VIEW, GameViewEnums.GAME_STATE ) );
							},
							GameStateView.CHARACTER_MOVE_TWEEN_TIME
						)
					)
				}
				syncCharacterPosition();
				updateDistanceTraveledLabel();
				
			}
		}
		private function addEventListeners():void
		{
			_gameStateView.restartBtn.addEventListener(Event.TRIGGERED, restartBtn_TRIGGERED_Handler);
			_gameStateView.stage.addEventListener(KeyboardEvent.KEY_DOWN, gameStateView_KEY_DOWN_Handler);
		}
				
		private function removeEventListeners():void
		{
			_gameStateView.restartBtn.removeEventListener(Event.TRIGGERED, restartBtn_TRIGGERED_Handler);
			_gameStateView.stage.removeEventListener(KeyboardEvent.KEY_DOWN, gameStateView_KEY_DOWN_Handler);
		}
		
		override public function destroy():void 
		{
			_gameStateView = null;
			_gameModel = null;
			super.destroy();
		}
	}

}