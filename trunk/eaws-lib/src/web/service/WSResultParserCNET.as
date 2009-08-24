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
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import web.WebServiceListener;
	import web.WebServiceResultReceiver;
	import web.WebServiceSubject;
	import web.data.DataObjectAmazon;
	import web.data.DataObjectCNET;
	
	/**This class is for real used by application, amazon uses SOAP calls and eBay uses SOAP auto generated library
	 * CNET uses REST. al of them (CNET and amazon) return data in e4x.
	 * */
	public class WSResultParserCNET implements WebServiceSubject, WebServiceResultReceiver
	{
		private static var logger:ILogger = Log.getLogger("web.service.WebServiceCNET");
		private var nsCNET: Namespace= new Namespace("http://api.cnet.com/rest/v1.0/ns");
		private var nsCNET2: Namespace= new Namespace("http://www.w3.org/1999/xlink");
		//
		private var listeners:ArrayCollection = new ArrayCollection();
		private var data:ArrayCollection = new ArrayCollection();
		private static var  instance:WSResultParserCNET;
		public static  function getInstance():WSResultParserCNET{
			logger.info("Obtaining instance of invoker");
			trace("Obtaining instance of invoker"); 
			if(instance==null){
				//instance= new WSResultParserCNET(new SingletonEnforcer());
			}
				return instance;
		}
		private var itemAdInit:ArrayCollection= null;
		private var doa:DataObjectAmazon= null;
		
	/*	public function WSResultParserCNET(blocker:SingletonEnforcer) {
			//this class cannot be instantied from outside - 
			//AS do not suport private constructors
		}
		*/
		public function WSResultParserCNET(itemAdInit:ArrayCollection,doa:DataObjectAmazon) {
			//this class cannot be instantied from outside - 
			//AS do not suport private constructors
			this.itemAdInit=itemAdInit;
			this.doa=doa;
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
			trace("Get event with XML data from CNET");
			default xml namespace=nsCNET ;
			
			
			var xList:XMLList =event.result..TechProduct;
			var data: DataObjectCNET = new DataObjectCNET();
			//chaeck if any :
			//trace("LENGTH ="+event.result.CNETResponse [0].TechProducts (@numFound=="0") );
			
			trace((event.result as XML).namespaceDeclarations().toString());//if you dont call this you wont parse it !!!!!!!!
			
			//trace("LENGTH ="+event.result..TechProduct.length());
			//trace("PRICE URL ="+event.result..TechProduct[0].PriceURL);
		//	trace("LN "+event.result..TechProduct[0].ImageURL.length());
		//	trace(""+event.result..TechProduct[1].ImageURL.length());
			
			
			var xmldata:XML=event.result as XML;
			//chek if any results

			
		
			var xmlList:XMLList = xmldata..TechProduct as XMLList;
			var l:int=xmlList.length();
			var parsedList:ArrayCollection= new ArrayCollection();
			//parsing product
			for(var k:int=0;k<l;k++){
				trace("Iteration --------------"+k);
				var parsed:DataObjectCNET = new DataObjectCNET();
				parsed.name = xmlList[k].Name;
				//images
				var j:int = xmlList[k].ImageURL.length();
				trace("Image array length= "+j);
				var images:ArrayCollection= new ArrayCollection();
				for(var i:int=0;i<j;i++){
					trace(" Iteration in url ------"+i);
					images.addItem(xmlList[k].ImageURL[i]);
				}
				trace(images.toString());
				parsed.imageURLs=images;
				//Item features
				parsed.priceURL=xmlList[k].PriceURL;
				parsed.reviewURL=xmlList[k].ReviewURL;
				parsed.manufacturerName=xmlList[k].Manufacturer.Name;
				parsed.SKU=xmlList[k].SKU;
				parsed.specs=xmlList[k].Specs;
				
				//reviews
				parsed.editorsChoice=xmlList[k].EditorsChice;
				parsed.editorsRatingOutOf=xmlList[k].EditorsRating.@outOf;
				parsed.editorsRatingValue=xmlList[k].EditorsRating;
				parsed.editorsStarRatingOutOf=xmlList[k].EditorsStarRating.@outOf;
				parsed.editorsStarRatingValue=xmlList[k].EditorsStarRating;
				
				logger.debug("CNET data: "+parsed.toString());
				parsedList.addItem(parsed);
			}	
			//ok parsed
			if(parsedList.length==0){
				logger.warn("NO DATA from CNET, sending DUMMY object, probably CNET does not have any information on this item, google will help. ");
				var parsed:DataObjectCNET = new DataObjectCNET();
				parsed.reviewURL="http://www.google.com/search?q="+doa.Title;
				
				parsedList.addItem(parsed);
				this.data= parsedList;
				this.doa.dataObjectCnet=parsedList.getItemAt(0)as DataObjectCNET;
			    this.itemAdInit.refresh();
				return ;
			}
			this.data=parsedList;
			
			this.doa.dataObjectCnet=parsedList.getItemAt(0)as DataObjectCNET;
			this.itemAdInit.refresh();
		
	}
	
		public function faultHandler(list:FaultEvent):void{
			logger.warn("Fault connection or retrival");
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