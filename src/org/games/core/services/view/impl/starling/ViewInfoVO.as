package org.games.core.services.view.impl.starling 
{
	/**
	 * ...
	 * @author Mihaylenko A.L.
	 */
	public final class ViewInfoVO 
	{
		private var _id:uint;
		private var _mediatorClass:Class;
		private var _viewClass:Class;
		
		public function ViewInfoVO(id:uint, mediatorClass:Class, viewClass:Class) 
		{
			_id = id;
			_mediatorClass = mediatorClass;
			_viewClass = viewClass;
		}
		public function get id():uint{ return _id; }
		public function get mediatorClass():Class{ return _mediatorClass; }
		public function get viewClass():Class{ return _viewClass; }
		
	}

}