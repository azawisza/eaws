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
	import mx.utils.ObjectProxy;
	
	import web.WebServiceListener;
	import web.WebServiceResultReceiver;
	import web.WebServiceSubject;
	import web.data.DataObjectCNET;
	/**
	 * Obsolete . pasring webService (SOAP)/HTTPService(REST) using objects tree
	 * */
	public class WebServiceObject implements WebServiceSubject, WebServiceResultReceiver
	{
		private static var logger:ILogger = Log.getLogger("web.service.WebServiceCNET");
		private var listeners:ArrayCollection = new ArrayCollection();
		private var data:ArrayCollection = new ArrayCollection();
		private static var  instance:WebServiceObject;
		public static  function getInstance():WebServiceObject{
			logger.info("Obtaining instance of invoker");
			trace("Obtaining instance of invoker"); 
			if(instance==null){
				instance= new WebServiceObject(new SingletonEnforcer());
			}
				return instance;
		}
		
		public function WebServiceObject(blocker:SingletonEnforcer) {
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
		
		public function resultHandler(event:ResultEvent):void
		{	
		
			var dataCNET:DataObjectCNET = new DataObjectCNET();
			
			
			logger.info("In result handler - obtainng data ");
			var rawData:ArrayCollection = event.result.CNETResponse.TechProducts.TechProduct;
			
			var length:int = rawData.length;
			logger.info("Searching for complex xml data (level 1, 2 etc)");
			for(var i:int=0;i<length;i++){
				trace("raw data item No. :"+i);
				var item : Object = rawData.getItemAt(i) ;
				/*if(item is Category || item is EditorsRating || item is EditorsStarRating || 
				item is ImageURL ||item is Manufacturer||item is PreferredNode || item is Topic){	 
					trace("1 level item, have to digg in");
					//digg in
					continue;
				}*/
			
			dataCNET.editorsChoice = rawData.getItemAt(i).EditorsChoice ;
			dataCNET.id = rawData.getItemAt(i).id ;
			dataCNET.name = rawData.getItemAt(i).Name ;
			dataCNET.priceURL = rawData.getItemAt(i).PriceURL ;
			dataCNET.publishDate = rawData.getItemAt(i).PublishDate ;
			dataCNET.reviewURL = rawData.getItemAt(i).ReviewURL ;
			dataCNET.editorsStarRatingValue = rawData.getItemAt(i).EditorsStarRating;
			dataCNET.SKU = rawData.getItemAt(i).SKU ;
			dataCNET.specs = rawData.getItemAt(i).Spec ;
			dataCNET.uid = rawData.getItemAt(i).uid ;
			dataCNET.editorsRatingValue = rawData.getItemAt(i).EditorsRating;   
			
			
			var urls:ArrayCollection= rawData.getItemAt(i).ImageURL;
			for(var j:int=0;j<urls.length;j++){
				dataCNET.imageURLs.addItem(urls.getItemAt(j).value);
			}
			
			
			
			
			
			//complex data
			var ob:String =rawData.getItemAt(i).EditorsRating;
			logger.info("Category complex "+ob);
			
			var ob2:ObjectProxy = rawData.getItemAt(i).Manufacturer;
			
			
		 
				
				
			}//for
	
			trace(dataCNET.toString());
			
			
			
			
			/*
			
			data = new ArrayCollection();//empty for now 
			trace("Results are comming.");
			//receivin data
			trace("Updating observers registerd");
			for(var i:int=0;i<listeners.length;i++){
				(listeners.getItemAt(i) as WebServiceListener).update(this);
				trace("Observer updated.");
			}
			*/
			
		}
		public function faultHandler(event:FaultEvent):void{
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