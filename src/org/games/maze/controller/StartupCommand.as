package org.games.maze.controller 
{
	import feathers.themes.AeonDesktopTheme;
	import org.games.core.IGameContext;
	import org.games.core.controller.ICommand;
	import org.games.core.services.view.api.IViewManager;
	import org.games.maze.controller.assets.ExternalAssetsLoadedCommand;
	import org.games.maze.controller.assets.LoadExternalAssetsCommand;
	import org.games.maze.controller.assets.events.AssetsEvent;
	import org.games.maze.controller.game.SwitchGameScreensCommand;
	import org.games.maze.controller.game.events.GameStateEvent;
	import org.games.core.controller.view.HideViewCommand;
	import org.games.core.controller.view.ShowViewCommand;
	import org.games.core.controller.view.events.ViewEvent;
	import org.games.core.services.fonts.StaticFontService;
	import flash.events.Event;
	import org.games.maze.view.GameViewEnums;
	import org.games.maze.view.gameend.GameEndMediator;
	import org.games.maze.view.gameend.GameEndView;
	import org.games.maze.view.gameprepare.GamePrepareStateMediator;
	import org.games.maze.view.gamestate.GameStateMediator;
	import org.games.maze.view.gamestate.GameStateView;
	import org.games.maze.view.intro.IntroMediator;
	import org.games.maze.view.intro.IntroView;
	import org.games.maze.view.loader.LoaderMediator;
	import org.games.maze.view.loader.LoaderView;
	/**
	 * Startup game command, executes when game context are ready.
	 * @author Mihaylenko A.L.
	 */
	public final class StartupCommand implements ICommand 
	{
		/**
		 * Constructor.
		 */
		public function StartupCommand(){}
		
		/**
		 * Execute command.
		 * @param	context - current game context.
		 * @param	eventModel - current event model initiator.
		 */
		public function execute( context:IGameContext, eventModel:Event ):Boolean
		{
			/**
			 * Entry point,
			 * start application here.
			 */
			
			/**
			 * TODO need create bitmap font manager for starling TextFields
			 * and localization services.
			 */
			StaticFontService.registerAppFonts();
			registerCommands( context );
			registerViews( context.viewManager );
			startGameApp( context );
			
			return true;
			
		}
		
		/**
		 * Register game commands.
		 * @param	context - Current game app context.
		 */
		private function registerCommands( context:IGameContext ):void
		{
			//register view manager commands
			context.registrerCommand(ViewEvent.SHOW_VIEW, ShowViewCommand);
			context.registrerCommand(ViewEvent.HIDE_VIEW, HideViewCommand);
			
			//register assets commands
			context.registrerCommand(AssetsEvent.LOAD_EXTERNAL_ASSETS, LoadExternalAssetsCommand, true );
			context.registrerCommand(AssetsEvent.EXTERNAL_ASSETS_LOADED, ExternalAssetsLoadedCommand, true );
			
			//register game state commands
			context.registrerCommand( GameStateEvent.INTRO_GAME, SwitchGameScreensCommand );
			context.registrerCommand( GameStateEvent.START_GAME, SwitchGameScreensCommand );
			context.registrerCommand( GameStateEvent.PREPARE_GAME_START, SwitchGameScreensCommand );
			context.registrerCommand( GameStateEvent.END_GAME, SwitchGameScreensCommand );
		}
		
		private function registerViews( viewManager:IViewManager ):void
		{
			
			//If use Feathers ui components
			new AeonDesktopTheme();
			//
			viewManager.registerView(GameViewEnums.LOADER, LoaderView, LoaderMediator);
			viewManager.registerView(GameViewEnums.INTRO, IntroView, IntroMediator);
			viewManager.registerView(GameViewEnums.GAME_PREPARE_STATE, LoaderView, GamePrepareStateMediator);
			viewManager.registerView(GameViewEnums.GAME_STATE, GameStateView, GameStateMediator);
			viewManager.registerView(GameViewEnums.GAME_END, GameEndView, GameEndMediator);
		}
		
		
		private function startGameApp( context:IGameContext ):void
		{
			context.dispatchEvent( new AssetsEvent(AssetsEvent.LOAD_EXTERNAL_ASSETS) );
		}
		
	}

}