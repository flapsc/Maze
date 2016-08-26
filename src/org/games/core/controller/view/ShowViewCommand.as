package org.games.core.controller.view 
{
	import org.games.core.services.view.api.IViewManager;
	/**
	 * View manager command, show registered view.
	 * @author Mihaylenko A.L.
	 */
	public class ShowViewCommand extends BaseViewCommand
	{
		internal final override function internalExecute():Boolean
		{
			const viewManager:IViewManager = _context.viewManager;
			
			if ( viewManager.isViewRegistered(_eventView.viewId) )
			{
				viewManager.showView(_eventView.viewId, _context);
				return true;
			}
			else
			{
				return false;
			}
		}
	}

}