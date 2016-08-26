package org.games.core.services.view.impl.starling 
{
	import org.games.core.services.view.api.IBaseView;
	import flash.geom.Rectangle;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	/**
	 * Base starling view ( IBaseView ) interface implementation.
	 * @author Mihaylenko A.L.
	 */
	public class BaseStarlingView extends DisplayObjectContainer implements IBaseView
	{
		protected var _viewPort:Rectangle;
		
		protected var _assetManager:AssetManager;
		
		/**
		 * Constructor.
		 */
		public function BaseStarlingView(){}
		
		/**
		 * Draw current vuew.
		 */
		public function draw(viewPort:Rectangle, assetManager:AssetManager):void
		{
			_viewPort = viewPort;
			_assetManager = assetManager;
		}
	}
}