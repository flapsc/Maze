package org.games.maze.controller.assets 
{
	import org.games.core.IGameContext;
	import org.games.core.controller.ICommand;
	import org.games.core.controller.view.events.ViewEvent;
	import org.games.core.model.data.IGameConfig;
	import org.games.maze.model.data.MazeGameDataConfig;
	import org.games.maze.view.GameViewEnums;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class ExternalAssetsLoadedCommand implements ICommand
	{
		/**
		 * Constructor.
		 */
		public function ExternalAssetsLoadedCommand(){}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			var dataConfig:MazeGameDataConfig = new MazeGameDataConfig();
			dataConfig.serialize(context.assetManager.getObject("game-config"));
			context.dispatchEvent( new ViewEvent(ViewEvent.HIDE_VIEW, GameViewEnums.LOADER) );
			context.gameModel.init(dataConfig, context.logger);
			context.saveService.init(dataConfig.pathToLocalSave, context.logger);
			context.viewManager.delayCall
			(
				function():void
				{
					context.dispatchEvent(new ViewEvent(ViewEvent.SHOW_VIEW, GameViewEnums.INTRO));
				},.5
			)
			return true;
		}
		
		
	}
}