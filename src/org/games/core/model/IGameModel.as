package org.games.core.model 
{
	import flash.events.IEventDispatcher;
	import org.games.core.services.log.ILogger;
	import org.games.core.model.data.IGameConfig;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface IGameModel
	{
		/**
		 * Start current game.
		 * @param	...args - Current application game arguments
		 */
		function startGame( ...args):void;
		
		/**
		 * Initialize game model.
		 * @param	dataConfig - Current data config( IGameConfig implementation ).
		 * @param	logger - Current ILogger interface implementation instance.
		 */
		function init( dataConfig:IGameConfig, logger:ILogger ):void;
		
		/**
		 * Hard game end.
		 * Hard reset to start state,
		 * clean up allocated data.
		 */
		function gameEnd():void;
		
		/**
		 * Public property( read only ).
		 * Check current game model
		 * state for the end.
		 */
		function get isGameEnd():Boolean;
		
		/**
		 * Current game data config.
		 */
		function get dataConfig():IGameConfig;
	}
}