package org.games.core.services.log 
{
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface ILogger 
	{
		function logError(...args):void;
		function logWarning(...args):void;
		function logInfo(...args):void;
	}
	
}