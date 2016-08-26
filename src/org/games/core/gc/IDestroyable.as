package org.games.core.gc 
{
	import flash.system.System;
	
	/**
	 * Help interface for garbage collection process.
	 * @author Mihaylenko A.L.
	 */
	public interface IDestroyable 
	{
		/**
		 * Clean up instance.
		 */
		function destroy():void;
	}
}