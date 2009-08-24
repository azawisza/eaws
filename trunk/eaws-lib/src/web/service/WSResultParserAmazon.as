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
	import application.IStart;
	
	import engine.StateMachine;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.formatters.NumberBaseRoundType;
	import mx.formatters.NumberFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import web.WebServiceListener;
	import web.WebServiceResultReceiver;
	import web.WebServiceSubject;
	import web.data.AmazonSearchResults;
	import web.data.DataObjectAmazon;
	
	/***/
	public class WSResultParserAmazon implements WebServiceSubject, WebServiceResultReceiver
	{
		private static var logger:ILogger = Log.getLogger("web.service.WSResultParserAmazon");
		
		
		private var nsAmazon: Namespace= new Namespace("http://webservices.amazon.com/AWSECommerceService/2009-07-01");
		//
		private var listeners:ArrayCollection = new ArrayCollection();
		private var data:AmazonSearchResults = new AmazonSearchResults();
		private static var  instance:WSResultParserAmazon;
		public static  function getInstance():WSResultParserAmazon{
			logger.info("Obtaining instance of invoker");
			trace("Obtaining instance of invoker"); 
			if(instance==null){
				instance= new WSResultParserAmazon(new SingletonEnforcer());
			}
				return instance;
		}
		
		public function WSResultParserAmazon(blocker:SingletonEnforcer) {
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
			
			
			/*
			 *Aby skutecznie wyciagnac z result danetrzeba:
			 1. zrzucic do XMLList poziom ktory chcemy analizowac niemozna zrzucac calosci a potem szukac 
			 2. XMLList jest rozwiazaniem ostatniej mili ; )  
			  
			 */
			trace("got result from amz soap call ");
			//trace(event.result);
		
			var amazonSearchResults:AmazonSearchResults= new AmazonSearchResults();
			var doAmazonList:ArrayCollection= new ArrayCollection();
			
			
			
			default xml namespace=nsAmazon;
			trace("data: "+event.result);
			//trace("data: "+event.result..Item);
			//logger.debug("Data from amazon call in XML: "+event.result..Item);
			var listItem:XMLList= event.result..Item;
			trace("amazon length ITEM: "+listItem.length());
			amazonSearchResults.ItemCount=listItem.length();
	
			amazonSearchResults.TotalPages=event.result..TotalPages;
	
			StateMachine.amz_PAGE_COUNT=new Number(amazonSearchResults.TotalPages);
			amazonSearchResults.TotalResults= event.result..TotalResults;
			//amazonSearchResults.ItemPage=

			
			 for(var i:int=0;i<listItem.length();i++){
			 	var doAmazon:DataObjectAmazon= new DataObjectAmazon();
			 	
			 	doAmazon.BigImage_URL=listItem[i].LargeImage.URL;
			 	doAmazon.BigImage_Height=listItem[i].LargeImage.Height;
			 	doAmazon.BigImage_Width=listItem[i].LargeImage.Width;
			 	doAmazon.Brand=listItem[i]..Brand;
			 	doAmazon.DetailPageURL=listItem[i].DetailPageURL;
			 	doAmazon.ListPrice_Amount=listItem[i]..ListPrice.Amount;
			 	doAmazon.LowestNewPrice_Amount=listItem[i]..LowestNewPrice.Amount;
			 	doAmazon.LowestUsedPrice_Amount=listItem[i]..LowestUsedPrice.Amount;
			 	doAmazon.Manufacturer=listItem[i]..Manufacturer;
			 	doAmazon.Model=listItem[i]..Model;	
			 	doAmazon.MPN=listItem[i]..MPN;
			 	doAmazon.SmallImage_Height=listItem[i].SmallImage.Height;
			 	doAmazon.SmallImage_URL=listItem[i].SmallImage.URL;
			 	doAmazon.MediumImage_URL=listItem[i].MediumImage.URL;
			 	doAmazon.SmallImage_Width=listItem[i].SmallImage.Width;
			 	doAmazon.Title=listItem[i]..Title;
			 	
			 	
			 	//price conversion
			 	var rate:Number = new Number(Currencies.getInstance().getRate("USD"));
			 	trace("whatever - "+rate);
			 	trace("RATE:"+rate);
			 	trace("ListPrice_Amount:"+new Number(doAmazon.ListPrice_Amount));
			 	var nf:NumberFormatter= new NumberFormatter();
			 	//nf.decimalSeparatorFrom=",";
			 	nf.precision=2;	
			 	nf.rounding=NumberBaseRoundType.UP;
			 	doAmazon.ListPriceNative = nf.format(rate*(new Number(doAmazon.ListPrice_Amount)/100))+"PLN/"+nf.format(new Number(doAmazon.ListPrice_Amount)/100)+"USD";
			 	doAmazon.LowestNewPriceNative= nf.format(rate*(new Number(doAmazon.LowestNewPrice_Amount)/100))+"PLN/"+nf.format(new Number(doAmazon.LowestNewPrice_Amount)/100)+"USD";
			 	doAmazon.LowestUsedPriceNative = nf.format(rate*(new Number(doAmazon.LowestUsedPrice_Amount)/100))+"PLN/"+nf.format(new Number(doAmazon.LowestUsedPrice_Amount)/100)+"USD";
			 	
			 	var ListPrice_Amount:Number =  Number(doAmazon.ListPrice_Amount);
			 	var LowestNewPrice_Amount:Number =  Number(doAmazon.LowestNewPrice_Amount);
			 	var LowestUsedPrice_Amount:Number =  Number(doAmazon.LowestUsedPrice_Amount);
			 	
			 	doAmazon.lowestPrice=0;
			 	
			 	if(ListPrice_Amount>0){
			 		doAmazon.lowestPrice=ListPrice_Amount;
			 		doAmazon.lowestPriceFormatted=nf.format(rate*(ListPrice_Amount/100))+"PLN "+nf.format(ListPrice_Amount/100)+"USD";
			 		doAmazon.lowestPriceUrl=listItem[i].DetailPageURL;
			 	}
			 	
			 	if(LowestNewPrice_Amount>0 && LowestNewPrice_Amount <doAmazon.lowestPrice ){
			 		doAmazon.lowestPrice=LowestNewPrice_Amount;
			 		doAmazon.lowestPriceFormatted=nf.format(rate*(LowestNewPrice_Amount/100))+"PLN "+nf.format(LowestNewPrice_Amount/100)+"USD";
			 		doAmazon.lowestPriceUrl=listItem[i].DetailPageURL;
			 	}
			 	
			 	if(LowestUsedPrice_Amount>0 && LowestUsedPrice_Amount<doAmazon.lowestPrice){
			 		doAmazon.lowestPrice=LowestUsedPrice_Amount;
			 		doAmazon.lowestPriceFormatted=nf.format(rate*(LowestUsedPrice_Amount/100))+"PLN "+nf.format(LowestUsedPrice_Amount/100)+"USD";
			 		doAmazon.lowestPriceUrl=listItem[i].DetailPageURL;
			 	}
			 	
			 	doAmazonList.addItem(doAmazon);
			 	
			 }
			 //adding stuff to amazon overall search result carrier.
		     amazonSearchResults.amazonSearchDataObjects=doAmazonList;
		     //trace("Received data: "+amazonSearchResults.toString());
			 
			 this.data=amazonSearchResults;
			 notifyListeners();
		
		//now we can MOVE to browsbale state
		logger.info("After data received, setting state to NEW Search (weried but true)"); 
		IStart.getInstance().setBrowseResultsLabel("Page "+StateMachine.amz_PAGE+" from "+amazonSearchResults.TotalPages);
		StateMachine.getInstance().state=StateMachine.getInstance().stateNewSearch;
	    }
	
		public function faultHandler(faul:FaultEvent):void{
			logger.warn("Fault connection or retrival");
			Alert.show("Error: "+faul.message,"Error");
		}
		public function getState():Object{
			trace("State of the WebServiceCNET acquired");
			return  data;
		}
		public function notifyListeners():void{
			if(this.listeners.length>0){
				trace("update registered folks");
				for(var i:int=0;i<this.listeners.length;i++){
					 trace("updating with gathered data "+i);
					(listeners.getItemAt(i) as WebServiceListener).update(this.data);
				}
			}else {
				//warning
				logger.warn("No listeners registered to update with data");
			}
			
		}
		
	}
}


class SingletonEnforcer {}