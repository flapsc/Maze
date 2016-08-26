package org.games.core 
{
	import org.games.core.services.log.ILogger;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import org.games.core.model.IGameModel;
	import org.games.core.model.data.IGameConfig;
	import org.games.core.services.save.api.ISaveService;
	import org.games.core.services.view.api.IViewManager;
	import starling.utils.AssetManager;
	
	/**
	 * Dispatched when game context are initialization ready
	 * @eventType	flash.events.Event.COMPLETE
	 */
	[Event(name = "complete", type = "flash.events.Event")] 	
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface IGameContext extends IEventDispatcher
	{
		
		/**
		 * Initialize game context
		 * @param	stage - current application flash.display.stage
		 * @param	viewManagerClassImpl IViewManager class implementation.
		 * @param	saveServiceClassImpl ISaveService class implementation.
		 * @param	gameModelClassImpl IGameModel class implementation
		 * @param	loggerClassImpl ILogger class implementation.
		 */
		function init
		( 
			stage:Stage, 
			viewManagerClassImpl:Class,
			saveServiceClassImpl:Class,
			gameModelClassImpl:Class,
			loggerClassImpl:Class
		):void;
		
		/**
		 * 
		 * @param	eventType - Current event type.
		 * @param	commandImpl - Command implementation
		 * @param	once - flag, for execute command one time, and after unregister it.
		 */
		function registrerCommand( eventType:String, commandImpl:Class, once:Boolean=false ):void;
		
		/**
		 * 
		 * @param	eventType
		 */
		function unregisterCommand( eventType:String ):void;
		
		function hasRegisteredCommand( eventType:String ):Boolean;
		
		/**
		 * Public property( read only ).
		 */
		function get viewManager():IViewManager;
		
		/**
		 * Public property( read only ).
		 */
		function get logger():ILogger;
		
		/**
		 * Public property( read only )
		 * Current starling asset manager instance.
		 */
		function get assetManager():AssetManager;
		
		/**
		 * Current game model
		 */
		function get gameModel():IGameModel;
		
		/**
		 * Current save service.
		 */
		function get saveService():ISaveService;
		
	}
}