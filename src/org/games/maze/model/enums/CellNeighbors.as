package org.games.maze.model.enums 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class CellNeighbors 
	{
		
		//All neighbors length.
		public static const NEIGHBORS_LENGTH:uint = 4;
		
		/**
		 * Current left neighbor at target cell- 
		 * 0 0 0
		 * 1 X 0
		 * 0 0 0
		 */
		public static const LEFT:uint = 0;
		
		/**
		 * Current bottom neighbor at target cell- 
		 * 0 0 0
		 * 0 X 0
		 * 0 1 0
		 */
		public static const BOTTOM:uint = 1;
		
		/**
		 * Current right neighbor at target cell- 
		 * 0 0 0
		 * 0 X 1
		 * 0 0 0
		 */
		public static const RIGHT:uint = 2;


		/**
		 * Current top neighbor at target cell- 
		 * 0 1 0
		 * 0 X 0
		 * 0 0 0
		 */
		public static const TOP:uint = 3;
		
		public static const UNKNOW:uint = 404;
	}
}