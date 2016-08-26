package org.games.core.services.view.api 
{
	import flash.geom.Rectangle;
	import starling.utils.AssetManager;
	
	/**
	 * Base view interface
	 * @author Mihaylenko A.L.
	 */
	public interface IBaseView
	{
		/**
		 * Draw current vuew.
		 * @param	viewPort - Current app view port.
		 */
		function draw( viewPort:Rectangle,assetManager:AssetManager ):void
		
		/**
		 * Disposes all resources of the view object. 
		 */
		function dispose ():void;
		
	}
	
}