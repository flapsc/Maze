package org.games.core.services.fonts 
{
	import flash.text.Font;
	/**
	 * TODO, need implement fonts 
	 * and localization service.
	 * 
	 * @author Mihaylenko A.L.
	 */
	public class StaticFontService 
	{
		[Embed(source = "../../../../../../assets/AveriaSansLibre-Bold.ttf", fontName = "AveriaSansLibre-Bold", embedAsCFF = "false")]
		static private const GLOBAL_FONT_CLASS:Class;
		static private const GLOBAL_APP_FONT_NAME:String = "AveriaSansLibre-Bold";
		
		/**
		 * 
		 */
		public static function registerAppFonts():void
		{
			Font.registerFont(GLOBAL_FONT_CLASS);
		}
		
		public static function get globalAppFontName():String{ return GLOBAL_APP_FONT_NAME; }
	}

}