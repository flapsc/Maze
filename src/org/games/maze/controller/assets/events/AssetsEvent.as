package org.games.maze.controller.assets.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class AssetsEvent extends Event 
	{
		static public const LOAD_EXTERNAL_ASSETS:String = "AssetsEvent.LOAD_EXTERNAL_ASSETS";
		static public const EXTERNAL_ASSETS_LOADED:String = "AssetsEvent.EXTERNAL_ASSETS_LOADED";
		
		public function AssetsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new AssetsEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AssetsEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}