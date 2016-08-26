package org.games.maze.view.loader 
{
	import org.games.core.services.view.impl.starling.BaseStarlingMediator;
	import org.games.maze.controller.assets.events.AssetsEvent;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class LoaderMediator extends BaseStarlingMediator
	{
		/**
		 * TODO need implement localization service.
		 */
		static private const LOADER_LABEL:String = "Loading game assets";
		
		//Current mediation view.
		private var _loaderView:LoaderView;
		
		//Current app context asset manager instance.
		private var _assetManager:AssetManager;
		
		public function LoaderMediator(){}
		
		
		protected override  function drawView():void 
		{
			super.drawView();
			_loaderView = _baseView as LoaderView;
			_loaderView.label = LOADER_LABEL;
		}
		/**
		 * @inheritDoc
		 */
		protected override function showComplete():void 
		{
			_assetManager = _gameContext.assetManager;
			_assetManager.loadQueue(assetManager_onProgress);
		}
		
		private function assetManager_onProgress( progress:Number ):void
		{
			_loaderView.updateProgress( progress );
			if ( progress == 1 )
			{
				_gameContext.dispatchEvent( new AssetsEvent(AssetsEvent.EXTERNAL_ASSETS_LOADED) );
			}
			else
			{
				_loaderView.updateProgress( progress );
			}
		}
		public override  function destroy():void 
		{
			_loaderView = null;
			super.destroy();
		}
	}
}