package org.games.maze.model 
{
	
	/**
	 * Base interface of cell model.
	 * @author Mihaylenko A.L.
	 */
	public interface ICell 
	{
		/**
		 * Initialize current cell
		 * @param	x field cell x.
		 * @param	y field cell y.
		 */
		function init(x:uint, y:uint):void;
		
		/**
		 * Update current cell neighbors,
		 * save naighbor indexes and link on field.
		 * @param	field - Current game field.
		 */
		function updateNeighborsAndCheckWallState( grid:Vector.<Vector.<ICell>> ):void;
		
		/**
		 * Public property( read/write ).
		 * Current cell state @see enums.CellState.
		 */
		function get state():uint;
		function set state( value:uint ):void;
		
		/**
		 * Cell x.
		 */
		function get x():uint;
		
		/**
		 * Cell y.
		 */
		function get y():uint;
		
		/**
		 * Destroy allocated data.
		 */
		function destroy():void;
		
		/**
		 * Get current neighbor at this cell.
		 * @param	value - neighbor predefine index( @see enums.CellNeighbors )
		 * @return cell neighbor.
		 */
		function getNeighbor( value:uint ):ICell;
		
		function getNeighbors( notEmpty:Boolean = false ):Vector.<ICell>;
		
		function getCandidatesToGenerateWay():Vector.<ICell>;
		
	}
}