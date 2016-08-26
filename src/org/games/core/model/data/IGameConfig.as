package org.games.core.model.data 
{
	import flash.events.IEventDispatcher;
	import org.games.core.gc.IDestroyable;
	
	/**
	 * Base interface of game data config.
	 * @author Mihaylenko A.L.
	 */
	public interface IGameConfig extends IEventDispatcher, IDestroyable
	{
		/**
		 * Serialize current data config.
		 * @param	data - Object
		 */
		function serialize( data:Object ):void;
		
		/**
		 * Validate current serialized data.
		 * @return validation result.
		 */
		function validateData():Boolean;
	}
	
}