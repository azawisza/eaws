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
package sbx

{
	import mx.controls.Alert;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class ResearchXMLe4x
	{
		//private var url:String = "http://api.cnet.com/rest/v1.0/techProductSearch?partKey=22569241417921932475142053432913&query=samsung&iod=Cbreadcrumb&start=0&limit=3&";
		//private var url:String = "http://azbest.vdl.pl/data/roomList.xml";
		//private var url:String = "http://azbest.vdl.pl/data/amazon.xml";
		private var nsAmaozn: Namespace = new Namespace("http://webservices.amazon.com/AWSECommerceService/2005-10-05");
		private var nsEBay:Namespace= new Namespace("urn:ebay:apis:eBLBaseComponents");
		private var nsCNET: Namespace= new Namespace("http://api.cnet.com/rest/v1.0/ns");
		private var url:String = "http://azbest.vdl.pl/data/amazon.xml";
		private static var logger:ILogger = Log.getLogger("sbx.ResearchXMLe4x");
		//http://azbest.vdl.pl/data/amazon.xml
		//private var url:String = "http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&&AWSAccessKeyId=1K9F7ZQ6BZ5A0QEV76R2&Operation=ItemSearch&SearchIndex=PCHardware&Keywords=Keywords&ResponseGroup=ItemAttributes,Images,OfferSummary&ItemPage=1&Availability=Availabile&Sort=salesrank";
		//
		
	//	private var url:String = 'http://open.api.ebay.com/shopping?version=517&appid=viewcomm-b107-41ff-937e-2739566c037e&callname=FindItemsAdvanced&QueryKeywords=LCD&ItemSort=BestMatch&MaxEntries=4&Currency=USD';
		//http://azbest.vdl.pl/data/roomList.xml
		private var service:HTTPService = new HTTPService();
		private var datax:XMLList = new XMLList();
		public static function getInstance():ResearchXMLe4x{
			return new ResearchXMLe4x();
		}
		public function ResearchXMLe4x()
		{
			
			
		}
		public function xmlLoad():void {
			
			service.url= url;
			service.useProxy=false;
			service.resultFormat="e4x";
			service.requestTimeout=30;
			service.addEventListener(ResultEvent.RESULT,resultHandler);
			service.addEventListener(FaultEvent.FAULT,faultHandler);
			service.send();
			
		}
		private function resultHandler(eve:ResultEvent):void {
			
			//default xml namespace=nsAmaozn;
			trace(eve as XML);
			datax= eve.result..Argument;
			
			trace(eve.result..Argument);
			trace("As XML "+datax.toXMLString());
			for(var i:int=0;i<datax.length();i++){
				trace("i="+i);
			}
		}
		private function faultHandler(faul:FaultEvent):void {
			Alert.show("error"+faul.toString(),"Error");
			
		}
		

	}
}