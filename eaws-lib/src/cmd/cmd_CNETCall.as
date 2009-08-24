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
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import web.WebServiceResultReceiver;
	import web.data.DataObjectAmazon;
	import web.service.WSResultParserCNET;
	
	public class cmd_CNETCall implements Command
	{
		private var logger:ILogger = Log.getLogger("cmd.cmd_RetriveXMLData");
		private var model:String= "";
		private var manufactuer:String="";
		private var xmlUrl:String="";
		private var doa:DataObjectAmazon=null;
		private var itemAdInit:ArrayCollection=null;
		
		public function cmd_CNETCall(manufacturer:String,model:String,itemAdInit:ArrayCollection,doa:DataObjectAmazon)
		{
		this.itemAdInit=itemAdInit;
		this.doa=doa;
		this.manufactuer=manufacturer;
		this.model=model;
		// generate cnetURL
		http://api.cnet.com/rest/v1.0/techProductSearch?partKey=22569241417921932475142053432913&query=Samsung 920NW&iod=Cbreadcrumb&start=0&limit=3&
		xmlUrl+=Conf.getInstance().getCnetRestUrl();
		xmlUrl+="partKey="+Conf.getInstance().getCnetKey();
		xmlUrl+="&query="+manufacturer+" "+model;
		xmlUrl+="&iod=Cbreadcrumb&start=0&limit=3&";
		
		}
	    public function execute():void
		{
			var result:WebServiceResultReceiver = null;
			var service:HTTPService = new HTTPService();
			logger.info("CNET command");
			result=new WSResultParserCNET(itemAdInit,doa);
			service.url=xmlUrl;
			logger.info("Retriving XML data from: "+xmlUrl);
			service.resultFormat="e4x";
			service.requestTimeout=30;
			service.addEventListener(ResultEvent.RESULT,result.resultHandler);
			service.addEventListener(FaultEvent.FAULT,result.faultHandler);
			trace(""+service.toString());
			service.send();
			trace("Call sent of type=CNET");		
			
		}
	}
}