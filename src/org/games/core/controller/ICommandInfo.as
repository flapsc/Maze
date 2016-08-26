package org.games.core.controller 
{
	
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public interface ICommandInfo 
	{
		function get eventType():String;
		function get commandImpl():Class;
		function get isSingleExecutable():Boolean;
		function get mapIndex():uint;
		function destroy():void;
	}
	
}