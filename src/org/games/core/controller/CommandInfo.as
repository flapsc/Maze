package org.games.core.controller 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class CommandInfo implements ICommandInfo
	{
		
		
		
		public function CommandInfo(eventType:String, commandImpl:Class, mapIndex:uint, isSingleExecutable:Boolean = false ) 
		{
			_isSingleExecutable = isSingleExecutable;
			_eventType = eventType;
			_commandImpl = commandImpl;
			_mapIndex = mapIndex;
		}
		
		private var _eventType:String;
		public function get eventType():String{return _eventType; }
		
		private var _isSingleExecutable:Boolean;
		public function get isSingleExecutable():Boolean{ return _isSingleExecutable; }
		
		
		private var _commandImpl:Class;
		public function get commandImpl():Class{ return _commandImpl; }
		
		private var _mapIndex:uint;
		public function get mapIndex():uint{ return _mapIndex; }
		
		public function destroy():void
		{
			_commandImpl = null;
			_eventType = null;
		}
	}

}