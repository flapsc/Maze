package org.games.maze.model 
{
	import org.games.maze.model.enums.CellNeighbors;
	import org.games.maze.model.enums.CellState;
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class CellModel implements ICell 
	{
		
		//
		private var _x:uint;
		
		//
		private var _y:uint;
		
		//
		private var _state:uint;
		
		//
		private var _neighbors:Vector.<ICell>;		
		
		/**
		 * Constructor.
		 */
		public function CellModel() 
		{
			
		}
		
		/**
		 * Initialize current cell
		 * @param	x field cell x.
		 * @param	y field cell y.
		 */
		public function init(x:uint, y:uint):void
		{
			_x = x;
			_y = y;
		}
		/**
		 * Update current cell neighbors,
		 * save naighbor indexes and link on field.
		 * @param	field - Current game field.
		 */
		public function updateNeighborsAndCheckWallState( grid:Vector.<Vector.<ICell>> ):void
		{
			const width:uint = grid.length - 1;
			const height:uint = grid[0].length - 1;
			
			_neighbors = Vector.<ICell>([]);
			_neighbors.length = CellNeighbors.NEIGHBORS_LENGTH;
			_neighbors.fixed = true;
			
			_neighbors[CellNeighbors.LEFT] = _x > 0?grid[_x - 1][_y]:null;
			_neighbors[CellNeighbors.BOTTOM] = _y < height?grid[_x][_y + 1]:null;
			_neighbors[CellNeighbors.RIGHT] = _x < width?grid[_x + 1][_y]:null;
			_neighbors[CellNeighbors.TOP] = _y > 0?grid[_x][_y - 1]:null;
			
			_state =
				(
					_x == 0 || _x == width ||
					_y == 0 || _y == height
				)
				?
					CellState.WALL
					:
					CellState.POTENTIAL_WALL;
		}
		
		/**
		 * Public property( read/write ).
		 * Current cell state @see enums.CellState.
		 */
		public function get state():uint{ return _state; }
		public function set state( value:uint ):void{ _state = value; }
		
		/**
		 * Cell x.
		 */
		public function get x():uint{ return _x; }
		
		/**
		 * Cell y.
		 */
		public function get y():uint{ return _y; }
		
		/**
		 * Destroy allocated data.
		 */
		public function destroy():void
		{
			_neighbors.fixed = false;
			_neighbors.length = 0;
			_neighbors = null;
		}
		
		/**
		 * Get current neighbor at this cell.
		 * @param	value - neighbor predefine index( @see enums.CellNeighbors )
		 * @return cell neighbor.
		 */
		public function getNeighbor( value:uint ):ICell
		{
			return _neighbors[value];
		}
		
		public function getNeighbors( notEmpty:Boolean = false ):Vector.<ICell>	
		{
			return notEmpty?_neighbors.filter(filterNotEmpty, this):_neighbors;
			
		}
		
			
		public function getCandidatesToGenerateWay():Vector.<ICell>
		{
			return _neighbors.filter( filterPotentials );
		}
		[Inline]
		static private function filterPotentials( item:ICell, index:int, vec:Vector.<ICell> ):Boolean
		{
			return 	item && item.state != CellState.WALL && item.state != CellState.EXIT;
		}
		
		[Inline]
		static private function filterNotEmpty( item:ICell, index:int, vec:Vector.<ICell> ):Boolean
		{
			return item != null;
		}
	}

}