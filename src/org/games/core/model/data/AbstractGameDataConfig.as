package org.games.core.model.data 
{
	import flash.events.EventDispatcher;
	/**
	 * Abstract data config.
	 * @author Mihaylenko A.L.
	 */
	public class AbstractGameDataConfig extends EventDispatcher implements IGameConfig
	{
		//
		static private const SERIALIZE_PREFIX:String = "serialize_";
		
		protected var _keyVOIgnorSerialize:Vector.<String> = Vector.<String>([]);
		
		/**
		 * Constructor.
		 */
		public function AbstractGameDataConfig(){}
		
		/**
		 * Serialize current data config.
		 * @param	data - Object
		 */
		public final function serialize( data:Object ):void
		{
			
			var paramKey:String;
			var serializeMethodName:String;
			for ( paramKey in data )
			{
				if ( _keyVOIgnorSerialize.indexOf( paramKey ) >= 0 )
					continue;
					
				serializeMethodName = SERIALIZE_PREFIX + paramKey;
				if ( this.hasOwnProperty(serializeMethodName) )
					this[serializeMethodName](data[paramKey]);
				else if ( this.hasOwnProperty( paramKey ) )
					this[paramKey] = data[paramKey];
			}
		}
		
		/**
		 * Validate current serialized data.
		 * @return validation result.
		 */
		public function validateData():Boolean{ return true; }
		
		
		/**
		 * Clean up instance.
		 */
		public function destroy():void{}
		
		protected final function addKeyForIgnoreSerialize( key:String ):void
		{
			if ( _keyVOIgnorSerialize.indexOf(key) ==-1 )
				_keyVOIgnorSerialize[_keyVOIgnorSerialize.length] = key;
		}
		
	}
}