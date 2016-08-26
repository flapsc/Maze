package org.games.maze.controller.game 
{
	import org.games.core.IGameContext;
	import org.games.core.controller.ICommand;
	import org.games.core.controller.view.events.ViewEvent;
	import org.games.maze.controller.game.events.GameStateEvent;
	import org.games.maze.view.GameViewEnums;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class SwitchGameScreensCommand implements ICommand
	{
		/**
		 * Constructor.
		 */
		public function SwitchGameScreensCommand(){}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			var viewId:uint// = eventModel.type == 
			switch( eventModel.type )
			{
				case GameStateEvent.PREPARE_GAME_START :
					viewId = GameViewEnums.GAME_PREPARE_STATE;
					break;
				case GameStateEvent.START_GAME:
					viewId = GameViewEnums.GAME_STATE;
					break;
				case GameStateEvent.END_GAME:
					viewId = GameViewEnums.GAME_END;
					break;
				default:
					viewId = GameViewEnums.INTRO;
					break;
				
			}
			context.dispatchEvent( new ViewEvent(ViewEvent.SHOW_VIEW, viewId) );
			
			return true;
		}
		
	}

}