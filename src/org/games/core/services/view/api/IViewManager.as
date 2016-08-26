package org.games.core.services.view.api
{
	import org.games.core.IGameContext;
	import org.games.core.services.log.ILogger;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import starling.animation.IAnimatable;
	
	/**
	 * Base interface of view manager.
	 * @author Mihaylenko A.L.
	 */
	public interface IViewManager
	{
		
		/**
		 * Initialize view manager.
		 * @param	stage - flash.display.Stage instance.
		 * @param	logger - ILogger interface implementation, for log view manager errors.
		 * @param	onComplete - callback executes when view manager ready to use.
		 */
		function init( stage:Stage, logger:ILogger, onComplete:Function ):void;
		
		/**
		 * Register view.
		 * @param	id - Current unique view id.
		 * @param	viewImpl - Class implementation of view.
		 * @param	mediator - Class implementation of mediation view.
		 */
		function registerView( id:uint, viewImpl:Class, mediator:Class):void;
		
		/**
		 * Hide all view, by registered view id.
		 * @param	viewId - Current registered view id.
		 */
		function hideAllViewById( viewId:uint ):void;
		
		/**
		 * Show view.
		 * @param	viewId - registered view id.
		 * @param	gameContext - current game app context.
		 */
		function showView(viewId:uint, gameContext:IGameContext):void;
		
		/**
		 * Check registered view.
		 * @param	id - Current unique view id.
		 * @return result.
		 */
		function isViewRegistered( id:uint ):Boolean;
		
		/**
		 * Delays the execution of a function until delay seconds have passed.
		 * This method provides a convenient alternative for creating and adding a DelayedCall
		 * manually.
		 * @return	Unique numeric identifier for the delayed call. This identifier may be used
		 *   to remove the object via removeByID().
		 */
		function delayCall(call:Function, delay:Number, ...rest):uint;
		
		function tween(target:Object, time:Number, properties:Object) : uint;
		
		/**
		 * Adds an object to the juggler.
		 * @return	Unique numeric identifier for the animation. This identifier may be used
		 *   to remove the object via removeByID().
		 */
		function addTween(object:IAnimatable) : uint;
		
		
		function removeTween(id:uint):void;
		
		function get viewPort():Rectangle;
		
		/**
		 * Stop rendering.
		 */
		function stop():void;
		
		/**
		 * Start rendering.
		 */
		function resume():void;
	}
	
}