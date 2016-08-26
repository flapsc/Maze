package org.games.core.services.view.impl.starling 
{
	
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.animation.IAnimatable;
	
	import org.games.core.IGameContext;
	import org.games.core.services.log.ILogger;
	import org.games.core.services.view.api.IBaseMediator;
	import org.games.core.services.view.api.IViewManager;
	

	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.events.Event;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class StarlingViewManager implements IViewManager 
	{
		private var _viewPort:Rectangle;
		
		private var _starling:Starling;
		
		private var _viewDisplayList:BaseStarlingView;
		
		//Current starling instance juggler, for animate view's.
		private var _currJugler:Juggler;
		//
		private var _initComplete:Function;
		//
		private var _activeViewMediator:Vector.<IBaseMediator>;
		//
		private var _registeredView:Vector.<ViewInfoVO>;
		
		private var _logger:ILogger;
		
		/**
		 * Constructor.
		 */
		public function StarlingViewManager(){}
		
		/**
		 * Initialize view manager.
		 * @param	stage - flash.display.Stage instance.
		 * @param	logger - ILogger interface implementation, for log view manager errors.
		 * @param	onComplete - callback executes when view manager ready to use.
		 */
		public function init( stage:Stage, logger:ILogger, onComplete:Function ):void
		{
			_initComplete = onComplete;
			_logger = logger;
			_registeredView = Vector.<ViewInfoVO>([]);
			_activeViewMediator = Vector.<IBaseMediator>([]);
			
			_viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            Starling.multitouchEnabled = false; // for Multitouch Scene
            _starling = new Starling(BaseStarlingView, stage, _viewPort);
			//_starling.touchProcessor
            _starling.simulateMultitouch = false;
            _starling.skipUnchangedFrames = true;
            _starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.addEventListener(Event.ROOT_CREATED, starling_ROOT_CREATERD_Handler);
			_starling.start();
		}
		

		
		/**
		 * Register view.
		 * @param	id - Current unique view id.
		 * @param	viewImpl - Class implementation of view.
		 * @param	mediator - Class implementation of mediation view.
		 */
		public function registerView( id:uint, viewImpl:Class, mediator:Class):void
		{
			if ( isViewRegistered(id) )
			{
				_logger.logError("[StarlingViewManager]::registerView error, view with id:", id, "already registered");
				return;
			}
			_registeredView.fixed = false;
			_registeredView[_registeredView.length] = new ViewInfoVO(id, mediator, viewImpl);
			_registeredView.fixed = true;
		}
		
		/**
		 * Hide all view, by registered view id.
		 * @param	viewId - Current registered view id.
		 */
		public function hideAllViewById( viewId:uint ):void
		{
			_filterId = viewId;
			const toHide:Vector.<IBaseMediator> = _activeViewMediator.filter( filterActiveViewsById, this );
			
			while ( toHide.length )
				toHide.pop().hide(viewHideComplete);
		}
		
		/**
		 * Show view.
		 * @param	viewId - registered view id.
		 * @param	gameContext - current game app context.
		 */
		public function showView(viewId:uint, gameContext:IGameContext):void
		{
			_filterId = viewId;
			const filterRes:Vector.<ViewInfoVO> = _registeredView.filter(filterRegisteredViewsById, this);
			if ( filterRes.length > 0 )
			{
				const info:ViewInfoVO = filterRes[0];
				const mediator:IBaseMediator = new info.mediatorClass();
				mediator.init(info.id, new info.viewClass(), gameContext);
				
				_activeViewMediator.fixed = false;
				_activeViewMediator[_activeViewMediator.length] = mediator;
				_activeViewMediator.fixed = true;
				
				mediator.show(_viewDisplayList);
				
			}
			else
			{
				_logger.logError("[StarlingViewManager]::showView(", viewId, "), error view not registered");
			}
		}
		
		/**
		 * Check registered view.
		 * @param	id - Current unique view id.
		 * @return result.
		 */
		public function isViewRegistered( id:uint ):Boolean
		{
			_filterId = id;
			return _registeredView.filter(filterRegisteredViewsById, this).length > 0;
		}
		
		/**
		 * Delays the execution of a function until delay seconds have passed.
		 * This method provides a convenient alternative for creating and adding a DelayedCall
		 * manually.
		 * @return	Unique numeric identifier for the delayed call. This identifier may be used
		 *   to remove the object via removeByID().
		 */
		public function delayCall(call:Function, delay:Number, ...rest):uint
		{
			return _currJugler.delayCall(call, delay, rest);
		}
		
		public function tween(target:Object, time:Number, properties:Object) : uint
		{
			return _currJugler.tween(target, time, properties);
		}
		
		/**
		 * Stop rendering.
		 */
		public function stop():void
		{
			const ln:uint = _activeViewMediator.length;
			for (var i:uint; i < ln; i++ )
				_activeViewMediator[i].stop();
				
			_starling.stop();
		}
		
		/**
		 * Start rendering.
		 */
		public function resume():void
		{
			const ln:uint = _activeViewMediator.length;
			for (var i:uint; i < ln; i++ )
				_activeViewMediator[i].resume();
				
			_starling.start();
		}
		
		/**
		 * Adds an object to the juggler.
		 * @return	Unique numeric identifier for the animation. This identifier may be used
		 *   to remove the object via removeByID().
		 */
		public function addTween(object:IAnimatable):uint
		{
			return _currJugler.add( object );
		}
		
		public function removeTween(id:uint):void
		{
			_currJugler.removeByID(id);
		}
		
		public function get viewPort():Rectangle{ return _viewPort; }
		
	////////////////////////////////////////////////////////////////////
	//						PRIVATE INSTANCE METHODS
	////////////////////////////////////////////////////////////////////
		private function starling_ROOT_CREATERD_Handler(e:Event):void 
		{
			_starling.removeEventListener(Event.ROOT_CREATED, starling_ROOT_CREATERD_Handler);
			_viewDisplayList = _starling.root as BaseStarlingView;
			_currJugler = _starling.juggler;
			_initComplete.apply(this);
			_initComplete = null;
		}
		
		private function viewHideComplete( mediator:IBaseMediator ):void
		{
			_activeViewMediator.splice(_activeViewMediator.indexOf(mediator), 1)[0].destroy();
		}
		
	////////////////////////////////////////////////////////////////////
	//						Vector filter methods
	////////////////////////////////////////////////////////////////////
		private var _filterId:uint;
		private function filterRegisteredViewsById( item:ViewInfoVO, index:int, vec:Vector.<ViewInfoVO> ):Boolean
		{
			return item.id == _filterId;
		}
		
		private function filterActiveViewsById( item:IBaseMediator, index:int, vec:Vector.<IBaseMediator> ):Boolean
		{
			return item.id == _filterId;
		}
		
		
		
	}
}