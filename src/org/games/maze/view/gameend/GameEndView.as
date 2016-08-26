package org.games.maze.view.gameend 
{
	import org.games.core.services.fonts.StaticFontService;
	import starling.display.Button;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.AssetManager;
	import flash.geom.Rectangle;
	import org.games.core.services.view.impl.starling.BaseStarlingView;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class GameEndView extends BaseStarlingView 
	{
		static private const PLAY_BTN_TEXTNAME:String = "intro_btn_play";
		static private const BG_TEXTNAME:String = "intro_background";
		
		//
		private var _background:Image;
		
		//
		private var _btnPlay:Button;
		
		//
		private var _tfScreenTitleLabel:TextField;
		
		//
		private var _tfGameTimeLabel:TextField;
		
		//
		private var _tfDistanceTraveledLabel:TextField;
		
		private var _tfResultLabel:TextField;
		
		/**
		 * Constructor.
		 */
		public function GameEndView(){}
		
		override public function draw(viewPort:Rectangle, assetManager:AssetManager):void 
		{
			super.draw(viewPort, assetManager);
			var textHeight:uint = 25;
			
			_background = new Image( assetManager.getTexture(BG_TEXTNAME) );
			_background.touchable = false;
			var width:uint = _background.width;
			var height:uint = _background.height;
			
			_btnPlay = new Button(assetManager.getTexture( PLAY_BTN_TEXTNAME ));
			_btnPlay.x = (_background.width - _btnPlay.width) * .5;
			_btnPlay.y = _background.height - _btnPlay.height * .5;
			
			_btnPlay.scaleWhenDown = .9;
			_btnPlay.scaleWhenOver = 1.1;
			_btnPlay.useHandCursor = false;
			var textFieldFormat:TextFormat = new TextFormat(StaticFontService.globalAppFontName, 26, 0x000080);
			
			_tfScreenTitleLabel = new TextField(width, textHeight, "", textFieldFormat);
			_tfScreenTitleLabel.y = textHeight * 1.1;			
			
			textFieldFormat  = new TextFormat(StaticFontService.globalAppFontName, 20, 0x000080);
			
			_tfResultLabel = new TextField(width, textHeight, "", textFieldFormat);
			_tfResultLabel.y = textHeight * 5;
			
			_tfDistanceTraveledLabel = new TextField(width, textHeight, "", textFieldFormat);
			_tfDistanceTraveledLabel.y = textHeight * 6;
			
			_tfGameTimeLabel = new TextField(width, textHeight, "", textFieldFormat);
			_tfGameTimeLabel.y = textHeight * 7;			
			
			addChild(_background);
			addChild( _btnPlay );
			addChild( _tfScreenTitleLabel );
			addChild( _tfResultLabel );
			addChild( _tfGameTimeLabel );
			addChild( _tfDistanceTraveledLabel );
			
		}
		
		public function get tfScreenTitleLabel():TextField{return _tfScreenTitleLabel; }
		public function get tfGameTimeLabel():TextField{return _tfGameTimeLabel; }
		public function get tfDistanceTraveledLabel():TextField{return _tfDistanceTraveledLabel;}
		public function get btnPlay():Button{return _btnPlay; }
		public function get tfResultLabel():TextField{return _tfResultLabel;}
	
		public override function dispose():void 
		{
			removeChild( _background, true );
			_background = null;
			
			removeChild(_tfScreenTitleLabel, true);
			_tfScreenTitleLabel = null;
			
			removeChild( _btnPlay, true );
			_btnPlay = null;
			
			removeChild(_tfResultLabel, true);
			_tfResultLabel = null;
			
			removeChild( _tfDistanceTraveledLabel, true );
			_tfDistanceTraveledLabel = null;
			
			removeChild( _tfGameTimeLabel, true );
			_tfGameTimeLabel = null;
			
			super.dispose();
		}
	}
}