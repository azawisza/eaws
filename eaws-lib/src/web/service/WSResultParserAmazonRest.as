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
package web.service
{
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import web.WebServiceListener;
	import web.WebServiceResultReceiver;
	import web.WebServiceSubject;
	import web.data.AmazonSearchResults;
	import web.data.DataObjectAmazon;

	public class WSResultParserAmazonRest implements WebServiceSubject, WebServiceResultReceiver
	{
		private static var logger:ILogger = Log.getLogger("web.service.WebServiceAmazon");
		private var nsAmazon: Namespace= new Namespace("http://webservices.amazon.com/AWSECommerceService/2005-10-05");
		//
		private var listeners:ArrayCollection = new ArrayCollection();
		private var data:XMLListCollection = new XMLListCollection();
		private static var  instance:WSResultParserAmazonRest;
		public static  function getInstance():WSResultParserAmazonRest{
			logger.info("Obtaining instance of invoker");
			trace("Obtaining instance of invoker"); 
			if(instance==null){
				instance= new WSResultParserAmazonRest(new SingletonEnforcer());
			}
				return instance;
		}
		
		public function WSResultParserAmazonRest(blocker:SingletonEnforcer) {
			//this class cannot be instantied from outside - 
			//AS do not suport private constructors
		}
		

		public function regsiterWebServiceListener(listener:WebServiceListener):void
		{	
			trace("Registering a new  listener");
			listeners.addItem(listener);
			trace("Number of listners: "+listeners.length);
		}
		
		public function removeWebServiceListener(listener:WebServiceListener):void
		{
			trace("Removing listener");
			var index: int = listeners.getItemIndex(listener);
			listeners.removeItemAt(index);
			trace("Number of listners: "+listeners.length);
		}
		
		public function resultHandler(event:ResultEvent):void{

			
			
			logger.info("got amazon item");
			default xml namespace=nsAmazon;
			logger.info("Available namespaces: "+(event.result as XML).namespaceDeclarations().toString());
			trace("Item numb="+event.result..Item);
			var amazonSearch:AmazonSearchResults = new AmazonSearchResults();
			var itemList:XMLList= event.result..Item as XMLList;
			var itemsListXML:XML = event.result as XML;
			var itemsList:XMLList = itemsListXML..Items as XMLList;
			
			trace(event.result as XML);
			
			trace(itemsList.TotalResults);
			trace(event.result..Items.TotalResults );
			trace((itemsList)..TotalResults );
			
			
			//first general settings fro whole results from amazon
			
			amazonSearch.ItemCount = itemsListXML..Item.length();
			amazonSearch.TotalPages = itemsListXML..Items.TotalPages;
			amazonSearch.TotalResults = itemsListXML..Items.TotalResults;
			amazonSearch.ItemPage= itemsListXML..Items.Request.ItemSearchRequest.ItemPage;
			
			var lista:XMLList= itemsListXML..Item as XMLList;
			
			trace("NEW: "+lista.length());
			
			
			
			
			trace(amazonSearch.toString());
			//now items from amazon.
			for(var i:int=0;i<lista.length();i++){
				trace("Iteration (amazon item) --------"+i);
				var data: DataObjectAmazon= new DataObjectAmazon();
				
				data.DetailPageURL=lista[i].DetailPageURL;
				data.SmallImage_URL=lista[i].SmallImage.URL;
				
				data.SmallImage_Height =lista[i].SmallImage.Height ;
				data.SmallImage_Width=lista[i].SmallImage.Width;
				data.BigImage_URL=lista[i].LargeImage.URL;
				data.BigImage_Height=lista[i].LargeImage.Height;
				data.BigImage_Width=lista[i].LargeImage.Width;
				data.Brand=lista[i]..Brand;
				data.ListPrice_Amount=lista[i]..ListPrice.Amount;
				data.LowestNewPrice_Amount=lista[i]..LowestNewPrice.Amount;
				data.Manufacturer=lista[i]..Manufacturer;
				data.Model= lista[i]..Model;
				data.Title=lista[i]..Title;
				data.LowestUsedPrice_Amount=lista[i]..LowestUsedPrice.Amount;
				trace(data.toString());
			}
			
			
			var totalResults:String = event.result..TotalResults;
			var totalPages:String = event.result..TotalResults;
			
			
			/*<TotalResults>1</TotalResults>
<TotalPages>1</TotalPages>*/
		
	    }
	
		public function faultHandler(faul:FaultEvent):void{
			logger.warn("Fault connection or retrival");
			Alert.show("Error: "+faul.message,"Error");
		}
		public function getState():Object{
			trace("State of the WebServiceCNET acquired");
			return  data;
		}
		public function notifyListeners():void {
	    }
		
	}
}


class SingletonEnforcer {}