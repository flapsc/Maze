package org.games.maze.view.gamestate 
{
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.HorizontalLayoutData;
	import starling.animation.IAnimatable;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import flash.geom.Rectangle;
	import org.games.core.services.view.impl.starling.BaseStarlingView;
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class GameStateView extends BaseStarlingView
	{
		static public const CHARACTER_MOVE_TWEEN_TIME:Number = .2;
		
		static private const TOP_UI_HEIGHT:uint = 50;
		private var _viewLayout:LayoutGroup;
		private var _scroll:ScrollContainer;
		private var _topUIView:LayoutGroup;
		private var _mazeView:ImageLoader;
		private var _character:Image;
		private var _restartBtn:Button;
		private var _currentStepLabel:Label;
		private var _timerLabel:Label;
		private var _tileSize:uint;
		private var _characterSyncPosition:Tween;
		public function GameStateView() 
		{
			super();
			
		}
		
		/**
		 * @inheritDoc
		 */
		public override function draw(viewPort:Rectangle, assetManager:AssetManager):void 
		{
			super.draw(viewPort, assetManager);
			
			_viewLayout = new LayoutGroup();
			_topUIView = new LayoutGroup();

			
			
			_topUIView.layout = new HorizontalLayout();
			_topUIView.layoutData = new AnchorLayoutData(10, 0, TOP_UI_HEIGHT, 0);
			
			_restartBtn = new Button();
			_restartBtn.label = "Restart";
			
			_currentStepLabel = new Label();
			_timerLabel = new Label();
			
			_currentStepLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			_timerLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			
			_topUIView.addChild(_restartBtn);
			_topUIView.addChild(_currentStepLabel);
			_topUIView.addChild(_timerLabel);
			
			_viewLayout.layout = new AnchorLayout();
			_viewLayout.width = viewPort.width;
			_viewLayout.height = viewPort.height;
			
			
			
			
			_scroll = new ScrollContainer();
			_scroll.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FLOAT;
			_scroll.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_AUTO;
			_scroll.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_AUTO;
			_scroll.horizontalScrollStep =
			_scroll.verticalScrollStep	= _tileSize;
			
			_scroll.layout = new AnchorLayout();
			_scroll.layoutData = new AnchorLayoutData(TOP_UI_HEIGHT, 0, 0, 0, 0);
			
			_mazeView.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
			
			_scroll.addChild(_mazeView);
			_scroll.addChild(_character);
			
			_viewLayout.addChild(_scroll);
			_viewLayout.addChild(_topUIView);
			addChild(_viewLayout);
			_viewLayout.invalidate();
			
		}
		public function updateCharacterPosition( x:uint, y:uint, tween:Boolean=true ):IAnimatable
		{
			if ( tween )
			{
				var tw:Tween = new Tween(_character, CHARACTER_MOVE_TWEEN_TIME);
				tw.moveTo(_mazeView.x + x, _mazeView.y + y);
				return tw;
			}
			else
			{
				_character.x = _mazeView.x + x;
				_character.y = _mazeView.y + y;
				_character.visible = true;
				return null;
			}
		}
		/**
		 * Set the generated maze texture, from model
		 * @param	texture - Current prepared maze texture.
		 */
		public function setMazeViewTextureAndTileSize( texture:Texture, tileSize:uint ):void
		{
			_mazeView = new ImageLoader();
			_mazeView.source = texture;
			_tileSize = tileSize;
		}
		public function setCharacterTexture( texture:Texture ):void
		{
			_character = new Image(texture);
			_character.visible = false;
		}
		
		/**
		 * Current restart button
		 */
		public function get restartBtn():Button{ return _restartBtn; }
		
		public function get currentStepLabel():Label 
		{
			return _currentStepLabel;
		}
		
		public function get timerLabel():Label 
		{
			return _timerLabel;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void 
		{
			_mazeView.removeFromParent( true )
			_mazeView = null;
			
			_scroll.removeFromParent( true );
			_scroll = null;
			
			_restartBtn.removeFromParent( true );
			_restartBtn = null;
			
			_topUIView.removeFromParent( true );
			_topUIView = null;
			
			_viewLayout.removeFromParent( true );
			_viewLayout = null;
			super.dispose();
		}
	}

}