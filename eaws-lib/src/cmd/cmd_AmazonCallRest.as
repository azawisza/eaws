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
	import application.Conf;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import web.WebServiceResultReceiver;
	import web.service.WSResultParserAmazonRest;
	
	
	/**Rtriing data from WebSrvice
	 * Using rest and XMLrequest objects
	 * Typically invoked by REST creators 
	 * */
	public class cmd_AmazonCallRest implements Command
	{
	
		private var xmlUrl:String= "";
		private var logger:ILogger = Log.getLogger("cmd.cmd_RetriveXMLDataAmazon");
		public function cmd_AmazonCallRest(query:String,category:String,page:int)
		{
			var url:String=Conf.getInstance().getAmazonRestUrl();
			url+="";
			
				url+="&AWSAccessKeyId="+Conf.getInstance().getAmazonKey();
				url+="&Operation="+"ItemSearch";
				url+="&SearchIndex="+category;
				url+="&Keywords="+query;
				url+="&ResponseGroup="+"ItemAttributes,Images,OfferSummary";
				url+="&ItemPage="+page;
				
				//rQuery+="&Sort="+rgSort.text;
			this.xmlUrl=url;
			
			
			
			//this.xmlUrl=xmlUrl;
		}

		public function execute():void
		{
			trace("Executing command - retriving Amazon REST data");
			var service:HTTPService = new HTTPService();
			var result:WebServiceResultReceiver = WSResultParserAmazonRest.getInstance();
			service.url=xmlUrl;
			
			logger.info("Retriving XML data from: "+xmlUrl);
			service.resultFormat="e4x";
			service.requestTimeout=30;
			service.addEventListener(ResultEvent.RESULT,result.resultHandler);
			service.addEventListener(FaultEvent.FAULT,result.faultHandler);
			trace(""+service.toString());
			service.send();
			trace("Call sent.");
			

			
			
		}
		
		
	}
}
