package org.games.core.services.view.api 
{
	import org.games.core.IGameContext;
	
	/**
	 * Base mediator interface.
	 * @author Mihaylenko A.L.
	 */
	public interface IBaseMediator 
	{
		/**
		 * Initielize current mediator.
		 * @param	id 
		 * @param	view - Current view.
		 * @param	gameContext - Current app game context
		 */
		function init( id:uint, view:Object, gameContext:IGameContext ):void;
		
		/**
		 * Show target view.
		 * @param	displayList - Current display list, for add view.
		 */
		function show( displayList:Object ):void;
		
		/**
		 * Hide current view, 
		 * @param hideComplete - callback, executes when hide complete.
		 */
		function hide( hideComplete:Function ):void;
		
		/**
		 * Destroy allocated data.
		 */
		function destroy():void;
		
		function stop():void;
		
		function resume():void;
		
		function get id():uint;
	}
	
}