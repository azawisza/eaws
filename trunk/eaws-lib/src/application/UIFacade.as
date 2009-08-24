/*
 This file is part of Eaws


    Eaws is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.


    Eaws is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.


    You should have received a copy of the GNU General Public License
    along with Eaws.  If not, see <http://www.gnu.org/licenses/>.
        author: azbest.pro (azbest.pro@gmail.com)
*/
package application
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class UIFacade
	{
		
		private static var logger:ILogger=Log.getLogger("application.UIFacade");
		private static var instance:UIFacade;

		private static var searchBox:PortalSearchSettingsUpdate= null;

		
		public static  function getInstance():UIFacade{
		
			if(instance==null){
				instance= new UIFacade(new SingletonEnforcer());
			}
				return instance;
		}
		
		public function UIFacade(blocker:SingletonEnforcer) {
			//this class cannot be instantied from outside - 
			//AS do not suport private constructors
		}
		public function registerSearchBoxUI(widget:PortalSearchSettingsUpdate):void {
			searchBox= widget;
		}
		public function enableUISearchOptions():void {
			logger.info("Applying SOA test results to UI")
			if(searchBox!=null)searchBox.updateSearchSettings();
			else logger.error("Cannot update search settings as component not registerd in Facade.");
		}

	}
}
class SingletonEnforcer {}