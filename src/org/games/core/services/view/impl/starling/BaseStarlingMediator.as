package org.games.core.services.view.impl.starling 
{
	import org.games.core.IGameContext;
	import org.games.core.services.view.api.IBaseMediator;
	import flash.geom.Rectangle;
	import starling.animation.Transitions;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public class BaseStarlingMediator implements IBaseMediator
	{
		/**
		 * TODO
		 * need move to UIConfig.
		 */
		static private const TWEEN_SHOW_TIME:Number = 1;
		static private const TWEEN_HIDE_TIME:Number = .4;
		static private const SHOW_TRAMSITION:String = Transitions.EASE_OUT_ELASTIC;
		static private const SHOW_DELAY:Number = 1;//delay before show( check create, construct view instance ).
		static private const HIDE_TRAMSITION:String = Transitions.EASE_IN_BOUNCE;
		//////////////////////////////
		
		protected var _baseView:BaseStarlingView;
		protected var _gameContext:IGameContext;
		
		private var _hideComplete:Function;
		private var _id:uint;
		/**
		 * Constructor.
		 */
		public function BaseStarlingMediator(){}
		
		/**
		 * Initielize current mediator.
		 * @param	id 
		 * @param	view - Current view.
		 * @param	gameContext - Current app game context
		 */
		public function init( id:uint, view:Object, gameContext:IGameContext ):void
		{
			_id = id;
			_baseView = view as BaseStarlingView;
			_gameContext = gameContext;
			drawView();
		}
		
		/**
		 * Show target view.
		 * @param	displayList - Current display list, for add view.
		 */
		public function show( displayList:Object ):void
		{
			const viewPort:Rectangle = _gameContext.viewManager.viewPort;
			_baseView.x = viewPort.x + (viewPort.width - _baseView.width) * .5;
			_baseView.y = viewPort.y - _baseView.height * 1.2;
			
			displayList.addChild(_baseView);
			
			const tweenToY:int = viewPort.y + (viewPort.height - _baseView.height) * .5;
			
			_gameContext.viewManager.tween
			(
				_baseView,
				TWEEN_SHOW_TIME,
				{y:tweenToY, transition:SHOW_TRAMSITION, onComplete:showComplete, delay:SHOW_DELAY}
			);
			
		}
		
		/**
		 * Hide current view, 
		 */
		public function hide( hideComplete:Function ):void
		{
			_hideComplete = hideComplete;
			
			const viewPort:Rectangle = _gameContext.viewManager.viewPort;
			const tweenToY:int = viewPort.y - _baseView.height * 1.2;
			
			_gameContext.viewManager.tween
			(
				_baseView,
				TWEEN_HIDE_TIME,
				{y:tweenToY, transition:SHOW_TRAMSITION, onComplete:this.hideComplete, delay:TWEEN_HIDE_TIME}
			);			
			
			
		}
		
		/**
		 * Destroy allocated data.
		 */
		public function destroy():void
		{
			_baseView.removeFromParent(true);
			_hideComplete = null;
			_baseView = null;
			_gameContext = null;
		}
		
		public function get id():uint{ return _id; }
		
		public function stop():void{}
		
		public function resume():void{}
		
		/**
		 * Ovveride for extend draw view.
		 */
		protected function drawView():void
		{
			_baseView.draw(_gameContext.viewManager.viewPort, _gameContext.assetManager);
		}
		
		/**
		 * Ovveride, and start mediate here
		 */
		protected function showComplete():void{}
		
		/**
		 * Stop mediate
		 */
		protected function hideComplete():void
		{
			if (_hideComplete != null)
			{
				_hideComplete.apply(this, [this]);
			}
		}
		
	}

}