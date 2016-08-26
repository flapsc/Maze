package org.games.maze.view.gameend 
{
	import org.games.core.IGameContext;
	import org.games.core.controller.view.events.ViewEvent;
	import org.games.core.services.view.impl.starling.BaseStarlingMediator;
	import org.games.maze.controller.game.events.GameStateEvent;
	import org.games.maze.model.MazeGameModel;
	import org.games.maze.view.GameViewEnums;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class GameEndMediator extends BaseStarlingMediator 
	{
		static private const YOU_WIN_TEXT:String = "You win!!!";
		static private const RESULT_TEXT:String = "You result:"
		static private const TIME_LABEL_PREFIX:String = "Game time:";
		static private const STEP_LABEL_PREFIX:String = "Distance traveled:"
		
		private var _gameEndView:GameEndView;
		private var _gameModel:MazeGameModel;
		
		/**
		 * Constructor.
		 */
		public function GameEndMediator(){}
		
		/**
		 * @inheritDoc
		 */
		public override function init(id:uint, view:Object, gameContext:IGameContext):void 
		{
			_gameEndView = view as GameEndView;
			_gameModel = gameContext.gameModel as MazeGameModel;
			
			super.init(id, view, gameContext);
		}
		
		/**
		 * @inheritDoc
		 */
		protected override  function drawView():void 
		{
			super.drawView();
			_gameEndView.tfScreenTitleLabel.text = YOU_WIN_TEXT;
			_gameEndView.tfResultLabel.text = RESULT_TEXT;
			_gameEndView.tfDistanceTraveledLabel.text = STEP_LABEL_PREFIX + _gameModel.currentPlayerSteps;
			_gameEndView.tfGameTimeLabel.text = TIME_LABEL_PREFIX + _gameModel.currentPlayedTimeSec;
		}
		protected override  function showComplete():void
		{
			super.showComplete();
			_gameEndView.btnPlay.addEventListener(Event.TRIGGERED, btnPlay_TRIGGERED_Handler);
		}
		private function btnPlay_TRIGGERED_Handler(e:Event):void 
		{
			_gameEndView.btnPlay.removeEventListener(Event.TRIGGERED, btnPlay_TRIGGERED_Handler);
			_gameContext.dispatchEvent( new ViewEvent( ViewEvent.HIDE_VIEW, GameViewEnums.GAME_END ) );
			_gameContext.dispatchEvent( new GameStateEvent( GameStateEvent.INTRO_GAME ) );
		}
		
		public override function destroy():void 
		{
			_gameEndView = null;
			_gameModel = null;
			super.destroy();
		}
	}
}