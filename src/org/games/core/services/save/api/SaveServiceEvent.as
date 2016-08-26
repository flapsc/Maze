package org.games.core.services.save.api 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class SaveServiceEvent extends Event 
	{
		static public const SAVE_COMPLETE:String = "SaveServiceEvent.SAVE_COMPLETE";
		static public const LOAD_COMPLETE:String = "SaveServiceEvent.LOAD_COMPLETE";
		
		public function SaveServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new SaveServiceEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("SaveServiceEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}