package org.games.maze.controller.game.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class GameStateEvent extends Event 
	{
		static public const INTRO_GAME:String = "GameEvent.INTRO_GAME";
		static public const PREPARE_GAME_START:String = "GameEvent.PREPARE_GAME_START";
		static public const START_GAME:String = "GameEvent.START_GAME";
		
		static public const END_GAME:String = "GameEvent.END_GAME";
		
		public function GameStateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new GameStateEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}