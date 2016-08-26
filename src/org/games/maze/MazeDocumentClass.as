package org.games.maze 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.games.core.GameContext;
	import org.games.core.IGameContext;
	import org.games.core.services.log.TraceLogger;
	import org.games.core.services.save.impl.LocalSharedObjectSaveService;
	import org.games.core.services.view.impl.starling.StarlingViewManager;
	import org.games.maze.controller.StartupCommand;
	import org.games.maze.model.MazeGameModel;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class MazeDocumentClass extends Sprite 
	{
		
		private var _gameContext:IGameContext;
		
		/**
		 * Constructor.
		 */
		public function MazeDocumentClass() 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init );
			
		}
		private function init( event:Event=null ):void
		{
			if ( event )
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			
			_gameContext = new GameContext();
			_gameContext.registrerCommand(Event.COMPLETE, StartupCommand, true);
			_gameContext.init(stage, StarlingViewManager, LocalSharedObjectSaveService, MazeGameModel, TraceLogger);
		}
	}
}