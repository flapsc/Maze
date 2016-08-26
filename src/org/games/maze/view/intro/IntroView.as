package org.games.maze.view.intro 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.NumericStepper;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.ILayoutData;
	import org.games.core.services.fonts.StaticFontService;
	import org.games.core.services.view.impl.starling.BaseStarlingView;
	import starling.display.Image;
	import starling.events.Event;
	import starling.filters.DropShadowFilter;
	import starling.text.TextFormat;
	import starling.utils.AssetManager;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	
	/**
	 * Base implementation of intro view.
	 * @author Mihaylenko A.L.
	 */
	public final class IntroView extends BaseStarlingView 
	{
		static private const PLAY_BTN_TEXTNAME:String = "intro_btn_play";
		static private const PLAY_BTN_DISABLE_TEXTNAME:String = "intro_btn_play_disable";
		static private const BG_TEXTNAME:String = "intro_background";
		
		// Current play button
		private var _btnPlay:Button;
		private var _background:Image;
		private var _layoutContainer:LayoutGroup;
		//
		private var _tfInfo:Label;
		
		private var _nsMazeHeightSize:NumericStepper;
		private var _slMazeHeightSize:Slider;
		private var _mazeHeightSizeLabel:Label;

		
		private var _nsMazeWidthSize:NumericStepper;
		private var _slMazeWidthtSize:Slider;
		private var _mazeWidthSizeLabel:Label;
		

		private var _nsCellViewSize:NumericStepper;
		private var _slCellViewSize:Slider;
		private var _mazeCellViewSizeLabel:Label;		
		
		private var _nsNumExit:NumericStepper;
		private var _slNumExit:Slider;
		private var _mazeNumExitLabel:Label;			
		
		private var _viewHorizontCenter:uint;
		private var _viewVerticalCenter:uint;
		
		private var _componentNsHeight:uint;
		private var _componentNsWidth:uint;
		
		/**
		 * Constructor.
		 */
		public function IntroView() {}
		
		
		/**
		 * @inheritDoc
		 */
		public override function draw(viewPort:Rectangle, assetManager:AssetManager):void 
		{
			super.draw(viewPort, assetManager);
			
			_background = new Image( assetManager.getTexture(BG_TEXTNAME) );
			_background.touchable = false;
			addChild(_background);
			
			_layoutContainer = new LayoutGroup();
			_layoutContainer.layout = new AnchorLayout();
			_layoutContainer.width = _background.width;
			_layoutContainer.height = _background.height;
			_viewHorizontCenter = _background.width * .5;
			_viewVerticalCenter = _background.height * .5;
			
			_componentNsHeight = 25;
			_componentNsWidth = _viewHorizontCenter - 25;
			
			addChild( _layoutContainer );
			
			_tfInfo = new Label();
			_tfInfo.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			_tfInfo.wordWrap = true;
			_tfInfo.layoutData = new AnchorLayoutData(20, 50, NaN, 50, 0, NaN);
			
			_layoutContainer.addChild(_tfInfo);
			
			
			const buttonForAllState:Image = new Image(assetManager.getTexture(PLAY_BTN_TEXTNAME));
			
			_btnPlay = new Button( );
			_btnPlay.setSkinForState(Button.STATE_UP, buttonForAllState);
			_btnPlay.setSkinForState(Button.STATE_HOVER, buttonForAllState);
			_btnPlay.setSkinForState(Button.STATE_DOWN, buttonForAllState);
			
			_btnPlay.scaleWhenDown = .9;
			_btnPlay.scaleWhenHovering = 1.1;
			_btnPlay.layoutData = new AnchorLayoutData(NaN, NaN, -buttonForAllState.height * .5, NaN, 0);
			_layoutContainer.addChild(_btnPlay);
			/**
			 * TODO need create base component for NamerStepper+Slider + Label,
			 * now it's bed - 
			 */
			const componentShift:uint = 35;
			_nsMazeHeightSize = new NumericStepper();
			_slMazeHeightSize = new Slider();
			_mazeHeightSizeLabel = new Label();
			prepareLayoutSelectSizeComponents(_nsMazeHeightSize, _mazeHeightSizeLabel, _slMazeHeightSize, - _componentNsHeight * 4 + componentShift);
			
			_nsMazeWidthSize = new NumericStepper();
			_slMazeWidthtSize = new Slider();
			_mazeWidthSizeLabel = new Label();
			prepareLayoutSelectSizeComponents(_nsMazeWidthSize, _mazeWidthSizeLabel, _slMazeWidthtSize, -_componentNsHeight * 2 + componentShift);
			
			_nsNumExit= new NumericStepper();
			_slNumExit = new Slider();
			_mazeNumExitLabel = new Label();
			prepareLayoutSelectSizeComponents(_nsNumExit, _mazeNumExitLabel, _slNumExit, componentShift);
			
			_nsCellViewSize= new NumericStepper();
			_slCellViewSize = new Slider();
			_mazeCellViewSizeLabel = new Label();
			prepareLayoutSelectSizeComponents(_nsCellViewSize, _mazeCellViewSizeLabel, _slCellViewSize,  _componentNsHeight * 2 +componentShift);
		}
		
		private function prepareLayoutSelectSizeComponents( ns:NumericStepper, label:Label, sl:Slider, verticalCenter:int ):void
		{
			sl.width =
			ns.width = _componentNsWidth;
			
			ns.layoutData = new AnchorLayoutData(NaN, NaN, NaN, _viewHorizontCenter, NaN, verticalCenter - _componentNsHeight * .5);
			sl.layoutData = new AnchorLayoutData(NaN, NaN, NaN, _viewHorizontCenter, NaN, verticalCenter + _componentNsHeight*.5);
			label.layoutData = new AnchorLayoutData(NaN, _viewHorizontCenter + 5, NaN, NaN, NaN, verticalCenter);
			
			label.isEnabled = false;
			
			_layoutContainer.addChild(ns);
			_layoutContainer.addChild(sl);
			_layoutContainer.addChild(label);
			
			ns.addEventListener(Event.CHANGE, communicationEvent);
			sl.addEventListener(Event.CHANGE, communicationEvent);
			
			function communicationEvent( event:Event ):void
			{
				var component:Object = event.currentTarget;
				if ( component is NumericStepper)
					sl.value = component.value;
				else
					ns.value = component.value;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public override  function dispose():void 
		{
			
			if (_btnPlay)
			{
				_btnPlay.removeFromParent(true);
				_btnPlay = null;
			}
			
			if ( _tfInfo )
			{
				_tfInfo.removeFromParent( true );
				_tfInfo = null;
			}
			
			if (_nsMazeWidthSize)
			{
				_nsMazeWidthSize.removeEventListeners(Event.CHANGE);
				_nsMazeWidthSize.removeFromParent(true);
				_nsMazeWidthSize = null;
			}
			if (_nsMazeHeightSize)
			{
				_nsMazeHeightSize.removeEventListeners(Event.CHANGE);
				_nsMazeHeightSize.removeFromParent(true);
				_nsMazeHeightSize = null;
			}
			
			if (_nsCellViewSize)
			{
				_nsCellViewSize.removeEventListeners(Event.CHANGE);
				_nsCellViewSize.removeFromParent(true);
				_nsCellViewSize = null;
			}
			
			if (_nsNumExit)
			{
				_nsNumExit.removeEventListeners(Event.CHANGE);
				_nsNumExit.removeFromParent(true);
				_nsNumExit = null;
			}
			
			if (_slMazeWidthtSize)
			{
				_slMazeWidthtSize.removeEventListeners(Event.CHANGE);
				_slMazeWidthtSize.removeFromParent(true);
				_slMazeWidthtSize = null;
			}				
			
			if (_slMazeHeightSize)
			{
				_slMazeHeightSize.removeEventListeners(Event.CHANGE);
				_slMazeHeightSize.removeFromParent(true);
				_slMazeHeightSize = null;
			}					

			if (_slCellViewSize)
			{
				_slCellViewSize.removeEventListeners(Event.CHANGE);
				_slCellViewSize.removeFromParent(true);
				_slCellViewSize = null;
			}
			
			if (_slNumExit)
			{
				_slNumExit.removeEventListeners(Event.CHANGE);
				_slNumExit.removeFromParent(true);
				_slNumExit = null;
			}	
			
			if ( _mazeCellViewSizeLabel )
			{
				_mazeCellViewSizeLabel.removeFromParent(true);
				_mazeCellViewSizeLabel = null;
			}

			if ( _mazeHeightSizeLabel )
			{
				_mazeHeightSizeLabel.removeFromParent(true);
				_mazeHeightSizeLabel = null;
			}
			
			if ( _mazeNumExitLabel )
			{
				_mazeNumExitLabel.removeFromParent(true);
				_mazeNumExitLabel = null;
			}			
			
			if ( _mazeWidthSizeLabel )
			{
				_mazeWidthSizeLabel.removeFromParent(true);
				_mazeWidthSizeLabel = null;
			}			
			
			if (_layoutContainer)
			{
				_layoutContainer.removeFromParent(true);
			}			
			
			super.dispose();
		}
		
		public function get btnPlay():Button{ return _btnPlay; }
		public function get tfInfo():Label{ return _tfInfo; }
		
		public function get nsMazeWidthSize():NumericStepper{return _nsMazeWidthSize;}
		public function get slMazeWidthtSize():Slider{return _slMazeWidthtSize; }
		public function get mazeWidthtSizeLabel():Label{return _mazeWidthSizeLabel; }
		
		public function get nsMazeHeightSize():NumericStepper{return _nsMazeHeightSize;}
		public function get slMazeHeightSize():Slider{return _slMazeHeightSize; }
		public function get mazeHeightSizeLabel():Label{return _mazeHeightSizeLabel; }
		
		public function get nsCellViewSize():NumericStepper{return _nsCellViewSize;}
		public function get slCellViewSize():Slider{return _slCellViewSize; }
		public function get mazeCellViewSizeLabel():Label{return _mazeCellViewSizeLabel; }		
		
		public function get nsNumExit():NumericStepper{return _nsNumExit;}
		public function get slNumExit():Slider{return _slNumExit;}
		public function get mazeNumExitLabel():Label{return _mazeNumExitLabel;}
		
	}
}