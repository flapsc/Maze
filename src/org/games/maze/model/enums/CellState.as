package org.games.maze.model.enums 
{
	/**
	 * Enums for field cell state.
	 * @author Mihaylenko A.L.
	 */
	public class CellState 
	{
		/* Empty state type */
		static public const WALL:uint = 0;
		
		/** Potential wall cell state, for maze generation*/
		static public const POTENTIAL_WALL:uint = 1;
		
		/* Free to move cell state */
		static public const FREE_TO_MOVE:uint = 2;
		
		/* Exit cell state */
		static public const POTENTIAL_EXIT:uint = 3;		
		
		/* Exit cell state */
		static public const EXIT:uint = 4;
		
	}
}