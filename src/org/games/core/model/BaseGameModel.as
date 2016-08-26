package org.games.core.model 
{
	import flash.events.EventDispatcher;
	import org.games.core.model.data.AbstractGameDataConfig;
	import org.games.core.services.log.ILogger;
	import org.games.core.model.data.IGameConfig;
	/**
	 * Base implementation of IGameModel
	 * @author Mihaylenko A.L.
	 */
	public class BaseGameModel extends AbstractGameDataConfig implements IGameModel
	{
		//
		protected var _logger:ILogger;
		
		//
		protected var _dataConfig:IGameConfig;
		
		//
		private var _isGameStarted:Boolean;
		
		/**
		 * Constructor.
		 */
		public function BaseGameModel(){}
		/**
		 * Initialize game model.
		 * @param	dataConfig - Current data config( IGameConfig implementation ).
		 * @param	logger - Current ILogger interface implementation instance.
		 */
		public final function init( dataConfig:IGameConfig, logger:ILogger ):void
		{
			
			addKeyForIgnoreSerialize("dataConfig");
			addKeyForIgnoreSerialize("isGameEnd");
			
			_dataConfig = dataConfig;
			_logger = logger;
			
			initializeComplete();
		}
		
		/**
		 * Start current game.
		 * @param	...args - Current application game arguments
		 */
		public final function startGame( ...args):void
		{
			if ( _isGameStarted )
			{
				_logger.logError("BaseGameModel->startGame execute when game is started ");
				return;
			}
			
			_isGameStarted = true;
			extStartGame( args );
		}
		

		
		/**
		 * Hard game end.
		 * Hard reset to start state,
		 * clean up allocated data.
		 */
		public final function gameEnd():void
		{
			if ( _isGameStarted )
			{
				_isGameStarted = !extGameEnd();
				
			}
			else
			{
				_logger.logError( "Execute game end when game is not started." );
			}
		}
		
		/**
		 * Public property( read only ).
		 * Check current game model
		 * state for the end.
		 */
		public final function get isGameEnd():Boolean{ return !_isGameStarted; }
		
		/**
		 * Current game data config.
		 */
		public final function get dataConfig():IGameConfig{ return _dataConfig; }
		
		/**
		 * Ovveride this method for initialize.
		 */
		protected function initializeComplete():void{}
		
		/**
		 * Ovveride in extension for start game.
		 * @param	...args - Current game arguments for start.
		 */
		protected function extStartGame( ...args ):void{}
		
		/**
		 * Ovveride in extension for check game end.
		 * @return result of operation, true - game is end.
		 */
		protected function extGameEnd():Boolean{ return false; }
	}

}