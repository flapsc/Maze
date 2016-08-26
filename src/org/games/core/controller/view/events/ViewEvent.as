package org.games.core.controller.view.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class ViewEvent extends Event 
	{
		
		static public const SHOW_VIEW:String = "view.events.SHOW_VIEW";
		static public const HIDE_VIEW:String = "view.events.HIDE_VIEW";
		
		/* Current View id */
		private var _viewId:uint;
		
		public function ViewEvent(type:String, id:uint=0, bubbles:Boolean=false, cancelable:Boolean=false)
		{ 
			super(type, bubbles, cancelable);
			_viewId = id;
		} 
		
		public final override function clone():Event 
		{ 
			return new ViewEvent(type, _viewId, bubbles, cancelable);
			
		} 
		
		public final override function toString():String 
		{ 
			return formatToString("ViewEvent", "type", "viewId", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/* Current View id */
		public final function get viewId():uint{ return _viewId; }
		
	}
	
}