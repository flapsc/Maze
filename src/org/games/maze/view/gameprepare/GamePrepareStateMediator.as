package org.games.maze.view.gameprepare 
{
	import org.games.core.IGameContext;
	import org.games.core.controller.view.events.ViewEvent;
	import org.games.core.services.view.impl.starling.BaseStarlingMediator;
	import org.games.maze.controller.game.events.GameStateEvent;
	import org.games.maze.model.MazeGameModel;
	import org.games.maze.view.GameViewEnums;
	import org.games.maze.view.loader.LoaderView;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class GamePrepareStateMediator extends BaseStarlingMediator 
	{
		/**
		 * TODO need implement localization service.
		 */
		static private const PREPARE_GAME_LABEL:String = "Prepare game elements...";
		
		private var _preloaderView:LoaderView;
		private var _animatePreloaderTweenId:uint;
		private var _gameModel:MazeGameModel;
		/**
		 * Constructor
		 */
		public function GamePrepareStateMediator(){}
		
		override public function init(id:uint, view:Object, gameContext:IGameContext):void 
		{
			super.init(id, view, gameContext);
			_gameModel = gameContext.gameModel as MazeGameModel;
		}
		
		/**
		 * @inheritDoc
		 */
		protected override function drawView():void 
		{
			super.drawView();
			_preloaderView = _baseView as LoaderView;
			_preloaderView.label = PREPARE_GAME_LABEL;
			_animatePreloaderTweenId = 
			_gameContext.viewManager.addTween
			(
				_preloaderView.generateWaitTweenObject(1.5)
			);
		}
		
		/**
		 * @inheritDoc
		 */
		protected override function showComplete():void 
		{
			_gameModel.startGame();
			_preloaderView.addEventListener(EnterFrameEvent.ENTER_FRAME, view_ENTER_FRAME_Handler);
		}
		
		private function view_ENTER_FRAME_Handler(e:EnterFrameEvent):void 
		{
			if ( 
					_gameModel.updateGenerationMazeField() 
					&&
					_gameModel.updateDrawGenerationView()
				)
				gamePrepareCompleteStartGame();
		}
		
		private function gamePrepareCompleteStartGame():void
		{
			_preloaderView.removeEventListener(EnterFrameEvent.ENTER_FRAME, view_ENTER_FRAME_Handler);
			_gameContext.dispatchEvent( new ViewEvent( ViewEvent.HIDE_VIEW, GameViewEnums.GAME_PREPARE_STATE ) );
			_gameContext.dispatchEvent( new GameStateEvent(GameStateEvent.START_GAME) );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function destroy():void 
		{
			_gameContext.viewManager.removeTween( _animatePreloaderTweenId );
			_preloaderView = null;
			_gameModel = null;
			super.destroy();
		}
	}

}