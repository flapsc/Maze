package org.games.core.controller.view 
{
	import avmplus.getQualifiedClassName;
	import org.games.core.controller.view.events.ViewEvent;
	import flash.events.Event;
	import org.games.core.IGameContext;
	import org.games.core.controller.ICommand;
	import flash.system.Capabilities;
	
	/**
	 * Base view event
	 * @author Mihaylenko A.L.
	 */
	public class BaseViewCommand implements ICommand
	{
		protected var _context:IGameContext;
		
		protected var _eventView:ViewEvent;
		
		public function BaseViewCommand() 
		{
			
            if (Capabilities.isDebugger && 
                getQualifiedClassName(this) == "com.renatus.games.reversi.controller.view.BaseViewCommand")
            {
				throw new RangeError("BaseViewCommand$ class cannot be instantiated", 2012);
            }			
		}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */		
		public final function execute(context:IGameContext, eventModel:Event):Boolean 
		{
			if ( eventModel is ViewEvent )
			{
				_context = context;
				_eventView = eventModel as ViewEvent;
				const res:Boolean = internalExecute();
				
				_context = null;
				_eventView = null;
				
				return res;
			}
			else
			{
				return false;
			}
			
		}
		
		/**
		 * Execute extension.
		 */
		internal function internalExecute():Boolean{ throw new RangeError("Ovveride internalExecute in extention"); }
		
	}

}