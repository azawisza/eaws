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
	import web.data.DataObjectAmazon;
	import web.data.DataObjectEBay;
	/**Parsing data from eBay using e4x*/
	public class WSResultParsereBay implements WebServiceSubject, WebServiceResultReceiver
	{
		
		private var logger:ILogger = Log.getLogger("cmd.WSResultParsereBay");
		private var ebayNS:Namespace=new Namespace("urn:ebay:apis:eBLBaseComponents");
		private var itemAdInit:ArrayCollection=null;
		private var doa:DataObjectAmazon= null;
		public function WSResultParsereBay(itemAdInit:ArrayCollection,doa:DataObjectAmazon)
		{
			this.itemAdInit=itemAdInit;
			this.doa=doa;
			trace("ebay rest parser created ");
		}

		public function regsiterWebServiceListener(listener:WebServiceListener):void
		{
		}
		
		public function removeWebServiceListener(listener:WebServiceListener):void
		{
		}
		
		public function getState():Object
		{
			return null;
		}
		
		[Bindable]
		public var doEBayList:ArrayCollection= new ArrayCollection();
		public function resultHandler(event:ResultEvent):void
		{
			//trace("DATA:"+event.result.toString());
			this.doa.dataObjectEBayList=doEBayList;
			default xml namespace=ebayNS;
		//	var doEBayList:ArrayCollection = new ArrayCollection();
			var doEBayListXML:XML = new XML();
			doEBayListXML=<altebay></altebay>;
			
			
			logger.info("Got results from ebay, now parsing...");
			trace("---");
			
			var list:XMLList= new XMLList(event.result..Item);
			
			for(var i:int=0;i<list.length();i++){
				var doeBay:DataObjectEBay= new DataObjectEBay();
				var rate:Number = new Number(Currencies.getInstance().getRate("USD"));
				//prices	
			 	var nf:NumberFormatter= new NumberFormatter();
			 	//nf.decimalSeparatorFrom=",";
				nf.precision=2;	
			 	nf.useThousandsSeparator=true;
			 	logger.warn("eBay Price: "+doeBay.ConvertedCurrentPrice);
			 	nf.rounding=NumberBaseRoundType.UP;
			 	
				doeBay.BidCount= list[i].BidCount;
				doeBay.ViewItemURLForNaturalSearch=list[i].ViewItemURLForNaturalSearch;
				logger.debug("eBay item URL: "+doeBay.ViewItemURLForNaturalSearch);
				doeBay.BuyItNowAvailable= list[i].BuyItNowAvailable;
				doeBay.ConvertedBuyItNowPrice= list[i].ConvertedBuyItNowPrice;
				
				doeBay.ConvertedBuyItNowPrice = nf.format(rate*(new Number(doeBay.ConvertedBuyItNowPrice)))+"PLN/"+nf.format(new Number(doeBay.ConvertedBuyItNowPrice))+"USD";
				
				
				var ConvertedBuyItNowPrice:Number= new Number(list[i].ConvertedBuyItNowPrice);
				var	ConvertedCurrentPrice:Number = new Number(list[i].ConvertedCurrentPrice);
				
				
				logger.info("ConvertedBuyItNowPrice="+ConvertedBuyItNowPrice);
				logger.info("ConvertedCurrentPrice="+ConvertedCurrentPrice);
				
				
				
				if(ConvertedCurrentPrice > 0 && ConvertedCurrentPrice*100 < doa.lowestPrice){
					doa.lowestPrice = ConvertedCurrentPrice;
					doa.lowestPriceFormatted=doa.lowestPriceFormatted=nf.format(rate*(ConvertedCurrentPrice))+"PLN "+nf.format(ConvertedCurrentPrice)+"USD";
					doa.lowestPriceUrl=list[i].ViewItemURLForNaturalSearch;
				}
				
				if(ConvertedBuyItNowPrice > 0 && ConvertedBuyItNowPrice*100 < doa.lowestPrice){
					doa.lowestPrice = ConvertedBuyItNowPrice;
					doa.lowestPriceFormatted=doa.lowestPriceFormatted=nf.format(rate*(ConvertedBuyItNowPrice))+"PLN"+nf.format(ConvertedBuyItNowPrice)+"USD";
					doa.lowestPriceUrl=list[i].ViewItemURLForNaturalSearch;
				}  
			
				doeBay.ConvertedCurrentPrice= list[i].ConvertedCurrentPrice;
				doeBay.EndTime= list[i].EndTime;
				doeBay.GalleryURL= list[i].GalleryURL;
				doeBay.Title= list[i].Title;
				doEBayList.addItem(doeBay);
				
			 	
			 	doeBay.ConvertedCurrentPriceNative = nf.format(rate*(new Number(doeBay.ConvertedCurrentPrice)))+"PLN/"+nf.format(new Number(doeBay.ConvertedCurrentPrice))+"USD";
			 	logger.debug("eBay Price (formatted): "+doeBay.ConvertedCurrentPrice);
			 	logger.debug("eBay natice Price (formatted): "+doeBay.ConvertedCurrentPriceNative);
				//doEBayListXML.appendChild(doeBay.toXML());
				//trace(doeBay.toXML());
				
			}
			
			//trace("ebay alterantives: "+doEBayList.toString());
			
			this.doa.dataObjectEBayListXML=doEBayListXML;
			this.itemAdInit.refresh();
			/*
			trace("ebay list length: "+list.length());
			trace("ebay Item count: "+list..ItemArray.length());
			trace("ebay Item count: "+list..SearchResult.length());
			trace("ebay Item count: "+list..Item.length());
			trace("ebay Item count: "+list..SearchResult.length());
			trace("ebay Item count: "+list.FindItemsAdvancedResponse.SearchResult.ItemArray.Item.length());
			
			trace("ebay list length: "+list);
			trace("ebay Item count: "+list..ItemArray);
			trace("ebay Item count: "+list..SearchResult);
			trace("ebay Item count: "+list..Item);
			trace("ebay Item count: "+list..SearchResult);
			trace("------------ new approach");
			var listItem:XMLList= event.result..Item;
			trace("ebay list length: "+listItem);
			trace("-------");
			trace(listItem.length());
		*/
			
			
			
			//FindItemsAdvancedResponse.SearchResult.ItemArray.Item
			
			
			
			
			logger.info("------------------EBAY ALT DATA PARSED AND AVAILABLE-----:"+this.doa.dataObjectEBayList.length);
			logger.info("-------------manufacturer: "+doa.Manufacturer+" model: "+doa.Model);
			logger.info("---------itemAdInit="+itemAdInit.length);
			
		}
		
		public function faultHandler(event:FaultEvent):void
		{
			logger.warn("Error");
			Alert.show("Error"+event.toString(),"Error.");
		}
		public function notifyListeners():void {
	    }
		
	}
}