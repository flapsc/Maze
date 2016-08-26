package org.games.maze.controller.assets 
{
	import org.games.core.IGameContext;
	import org.games.core.controller.ICommand;
	import org.games.core.controller.view.events.ViewEvent;
	import org.games.maze.view.GameViewEnums;
	import flash.events.Event;
	import starling.utils.AssetManager;
	
	/**
	 * Add external assets to starling asset manager queue.
	 * @author Mihaylenko A.L.
	 */
	public final class LoadExternalAssetsCommand implements ICommand
	{
		
		/**
		 * Constructor.
		 */
		public function LoadExternalAssetsCommand(){}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			/**
			 * Add to queue assets, 
			 * game config,
			 * game atlass
			 */
			context.assetManager.enqueue("content/game-config.json", "content/game-atlass.png", "content/game-atlass.xml");
			context.dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, GameViewEnums.LOADER ) );
			return true;
		}
	}
}