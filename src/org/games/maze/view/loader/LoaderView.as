package org.games.maze.view.loader 
{
	import feathers.controls.ProgressBar;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.games.core.services.fonts.StaticFontService;
	import org.games.core.services.view.impl.starling.BaseStarlingView;
	import starling.animation.IAnimatable;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	/**
	 * BaseStarlingView extension, 
	 * the loader view ext.
	 * @author Mihaylenko A.L.
	 */
	public final class LoaderView extends BaseStarlingView
	{
		//Current progress bar height.
		static private const BAR_HEIGHT_VIEWPORT_PERCENT:Number = .03;
		
		static private const BAR_WIDTH_VIEWPORT_PERCENT:Number = .5;
		
		//Current progress text field label.
		private var _tfLoaderLabel:TextField;
		
		private var _progressBar:ProgressBar;
		
		/**
		 * Constructor
		 */
		public function LoaderView(){}
		
		public override function draw(viewPort:Rectangle, assetManager:AssetManager):void
		{
			touchable = false;
			var width:Number = viewPort.width * BAR_WIDTH_VIEWPORT_PERCENT;
			var height:Number = viewPort.height * BAR_HEIGHT_VIEWPORT_PERCENT;
			var textHeight:Number = 25;
			
			_progressBar = new ProgressBar();
			_progressBar.width = width;
			_progressBar.minimum = 0;
			_progressBar.maximum = 1;
			_progressBar.value = 0;
			
			addChild(_progressBar);
			
			var textFieldFormat:TextFormat = new TextFormat(StaticFontService.globalAppFontName, 16, 0xFFFFFF);
			
			_tfLoaderLabel = new TextField(width, textHeight, "", textFieldFormat);
			_tfLoaderLabel.y = height * 1.1;
			addChild( _tfLoaderLabel );
		}
		
		public function generateWaitTweenObject(time:Number):IAnimatable
		{
			var tween:Tween = new Tween( _progressBar, time );
			tween.animate("value", 1);
			tween.repeatCount = int.MAX_VALUE;
			
			return tween;
		}
		
		/**
		 * Update current view progress fill.
		 * @param	progress - Current progress to fill( valid value 0...1 )
		 */
		public function updateProgress( progress:Number ):void
		{
			_progressBar.value = progress;
		}
		
		public function set label( value:String ):void
		{
			_tfLoaderLabel.text  = value;
		}
		/**
		 * @inheritDoc
		 */
		public final override  function dispose():void 
		{
			
			removeChild( _progressBar, true );
			removeChild(_tfLoaderLabel, true);
			
			_progressBar = null;
			_tfLoaderLabel = null;
			
			super.dispose();
		}
		
	}
}