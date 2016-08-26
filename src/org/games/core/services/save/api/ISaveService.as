package org.games.core.services.save.api 
{
	import flash.events.IEventDispatcher;
	import org.games.core.gc.IDestroyable;
	import org.games.core.services.log.ILogger;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface ISaveService extends IEventDispatcher, IDestroyable
	{
		
		/**
		 * 
		 * @param	pathName
		 */
		function init( pathName:String, logger:ILogger ):void
		
		/**
		 * Save current data.
		 * @param	key - current key of data.
		 * @param	data- current data to save.
		 */
		function save(key:String, data:Object):void;
		
		/**
		 * Load data
		 */
		function load():void;
		
		/**
		 * Current loaded data.
		 */
		function get loadedData():Object;
	}
	
}