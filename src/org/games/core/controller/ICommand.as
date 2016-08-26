package org.games.core.controller 
{
	import org.games.core.IGameContext;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface ICommand 
	{
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		function execute( context:IGameContext, eventModel:Event ):Boolean;
	}
	
}