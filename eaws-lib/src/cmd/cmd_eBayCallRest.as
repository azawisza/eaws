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
	
	import engine.StateMachine;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import web.WebServiceResultReceiver;
	import web.data.DataObjectAmazon;
	import web.service.WSResultParsereBay;
	
	public class cmd_eBayCallRest implements Command
	{	
		
		private var man:String = "";
		private var model:String="";
		private var itemsCount:int= 0;
		private var restCall:String="" ;
		private var logger:ILogger = Log.getLogger("cmd.eBayCallRest");
		private var itemAdInit:ArrayCollection;
		private var doa:DataObjectAmazon;
		
		public function cmd_eBayCallRest(man:String,model:String,itemsCount:int,itemAdInit:ArrayCollection,doa:DataObjectAmazon)
		{
			
			this.man= man ;
			this.model = model ;
			this.itemsCount = itemsCount;
			this.doa = doa;
			this.itemAdInit=itemAdInit;
			this.itemsCount=itemsCount;
			// REST call generation
				restCall =Conf.getInstance().geteBayRestURL();
				restCall+= "version=517&"
				restCall+= "appid="+Conf.getInstance().geteBayKey()+"&";
				restCall+= "callname=" +"FindItemsAdvanced"+"&"; 
				restCall+="QueryKeywords="+man+" "+model+"&"
				restCall+="ItemSort=BestMatch"+"&"; 
				restCall+="MaxEntries="+itemsCount+"&"
				if(StateMachine.getInstance().sdata.ebayBuyNow)restCall+="&ItemTypeFilter=2"; 
				restCall+="Currency=USD";
				logger.info("ebay RESt call created: "+restCall);
		}

		public function execute():void
		{
			//itemAdInit:ArrayCollection,doa:DataObjectAmazon
			var receiver:WebServiceResultReceiver = new WSResultParsereBay(itemAdInit,doa);
			var service : HTTPService = new HTTPService();
			service.url=restCall;
			trace("Call to "+restCall);
			
			service.resultFormat="e4x";
			service.addEventListener(FaultEvent.FAULT,receiver.faultHandler);
			service.addEventListener(ResultEvent.RESULT,receiver.resultHandler);
			service.send();
			trace("call sent");
			
		}
		
	}
}