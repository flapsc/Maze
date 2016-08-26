package org.games.core.services.log 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class TraceLogger implements ILogger
	{
		
		public function TraceLogger() 
		{
			
		}
		
		protected function log( ...args ):void
		{
			trace(args);
		}
		public final function logError(...args):void
		{
			log("[Error]:", args);
		}
		public final function logWarning(...args):void
		{
			log("[Warning]:", args);
		}
		public final function logInfo(...args):void
		{
			log("[Info]:", args);
		}
		
		
	}

}