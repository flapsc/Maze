package org.games.maze.model.data 
{
	import flash.geom.Point;
	import org.games.core.model.data.AbstractGameDataConfig;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class MazeGameDataConfig extends AbstractGameDataConfig
	{
		/**
		 * Constructor.
		 */
		public function MazeGameDataConfig(){}
		
		/**
		 * Ext serialize methods.
		 */
		public function serialize_startPointPercent( data:Object ):void
		{
			_startPointPercent = new Point( data.x, data.y );
		}

		
		/**
		 * @inheritDoc
		 */
		public override  function validateData():Boolean 
		{
			if ( 
					_minMazeSize < 2
					||	
					_minMazeSize > _maxMazeSize 
					||
					_startPointPercent == null
					||
					_minViewCellSize<5
				)
				return false;
				
			return true;
		}
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			super.destroy();
			_startPointPercent = null;
		}
		/**
		 * Setters and getters
		 */
		private var _startPointPercent:Point;
		public function get startPointPercent():Point{ return _startPointPercent; }
		
		/**
		 * The minimum maze size value.
		 */
		private var _minMazeSize:uint;		
		public function get minMazeSize():uint{return _minMazeSize; }
		public function set minMazeSize(value:uint):void{_minMazeSize = value; }
		
		/**
		 * The maximum maze size value.
		 */
		private var _maxMazeSize:uint;
		public function get maxMazeSize():uint{return _maxMazeSize; }
		public function set maxMazeSize(value:uint):void{_maxMazeSize = value; }1
		
		/**
		 * Current path to local save.
		 */
		private var _pathToLocalSave:String;		
		public function get pathToLocalSave():String{return _pathToLocalSave;}
		public function set pathToLocalSave(value:String):void{_pathToLocalSave = value; }
		
		/**
		 * Current minumum view cell size value.
		 */
		private var _minViewCellSize:uint;		
		public function get minViewCellSize():uint{return _minViewCellSize;}
		public function set minViewCellSize(value:uint):void{_minViewCellSize = value; }
		
		private var _wallColor:uint;
		public function set wallColor( value:uint ):void{ _wallColor = value; }
		public function get wallColor():uint{ return _wallColor; }
		
		private var _characterColor:uint;
		public function set characterColor( value:uint ):void{ _characterColor = value; }
		public function get characterColor():uint{ return _characterColor; }		
	}

}