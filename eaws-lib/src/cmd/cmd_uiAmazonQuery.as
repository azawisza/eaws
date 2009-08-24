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
package cmd
{
	import mx.logging.ILogger;
	import mx.logging.Log;
	/**Processing main system query
	 * Search starts with quering amazon with keyword. 
	 * Then for each result CNEt data re retrived and ebay alternatives
	 * At the end comparision for each result is made. 
	 * */
	public class cmd_uiAmazonQuery implements Command
	{	
		private var query:String= "";
		private var logger:ILogger = Log.getLogger("cmd.cmd_uiAmazonQuery");
		public function cmd_uiAmazonQuery(query:String)
		{
			logger.info("Instance of cmd_uiAmazonQuery created.");
			trace("Paramters: "+query);
			this.query=query;
		}
		public function execute():void {
			trace("Started execution of query");
			trace("End of query execution ");
		}

	}
}