package org.games.core.services.save.impl 
{
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.sampler.getSize;
	import org.games.core.services.log.ILogger;
	import org.games.core.services.save.api.ISaveService;
	import org.games.core.services.save.api.SaveServiceEvent;
	
	/**
	 * @author Mihaylenko A.L.
	 */
	public final class LocalSharedObjectSaveService extends EventDispatcher implements ISaveService 
	{
		static private const DEFAULT_PATH_NAME:String = "GameDefaultPathName";
		
		private var _sharedObject:SharedObject;
		private var _logger:ILogger;
		private var _pathName:String;
		private var _saveCompleteEvent:SaveServiceEvent;
		private var _loadCompleteEvent:SaveServiceEvent;
		/**
		 * Constructor.
		 */
		public function LocalSharedObjectSaveService() 
		{
		}
		
		/**
		 * 
		 * @param	pathName
		 */
		public function init( pathName:String, logger:ILogger ):void
		{
			_logger = logger;
			_pathName = pathName;
		}
		/**
		 * Save current data.
		 * @param	data- current data to save.
		 */
		public function save(key:String, data:Object):void
		{
			_logger.logInfo("[SharedObjectSaveService] save local data, size:", getSize(data));
			_sharedObject = SharedObject.getLocal(_pathName?_pathName:DEFAULT_PATH_NAME);
			_sharedObject.data[key] = data;
			_sharedObject.flush();
			if (!_saveCompleteEvent)
				_saveCompleteEvent = new SaveServiceEvent(SaveServiceEvent.SAVE_COMPLETE);
				
			dispatchEvent( _saveCompleteEvent );
			_sharedObject = null;
		}
		
		/**
		 * Load data
		 */
		public function load():void
		{
			if (!_loadCompleteEvent)
				_loadCompleteEvent = new SaveServiceEvent(SaveServiceEvent.LOAD_COMPLETE);
				
			dispatchEvent(_loadCompleteEvent);
		}
		
		/**
		 * Current loaded data.
		 */
		public function get loadedData():Object
		{		_sharedObject = SharedObject.getLocal(_pathName?_pathName:DEFAULT_PATH_NAME);
			return _sharedObject?_sharedObject.data:null; 
		}
		
		/**
		 * Clean up instance.
		 */
		public function destroy():void
		{
			_sharedObject = null;
			_logger = null;
		}
		
	}

}