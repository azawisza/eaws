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
	import application.IStart;
	
	import cmd.ui.cmd_WSFail;
	import cmd.ui.cmd_WSSuccess;
	
	import mx.formatters.NumberBaseRoundType;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.soap.LoadEvent;
	
	import web.service.Currencies;
	public class Start
	{
		private static var logger:ILogger=Log.getLogger("cmd.Start");
		private static var  instance:Start;
		public static  function getInstance():Start{
			logger.info("Obtaining instance of invoker");
			trace("Obtaining instance of invoker"); 
			if(instance==null){
				instance= new Start(new SingletonEnforcer());
				
			}
				return instance;
		}
		
		public function Start(blocker:SingletonEnforcer) {
			//this class cannot be instantied from outside - 
			//AS do not suport private constructors
		}
		/**Obsolete*/
		public static function init():void {

		}
		public static function initCurrencyRates():void {
			trace("Initializing curiencies ...");
			var c:int = Currencies.getInstance().gerCurrencyRateInPLN();
			if(c==0){
				logger.warn("Cannot obtain currnecy, please wait for system");
			}
			trace("");
			trace("Currency Tested and initialized");
		}
		public static function initNumberFormat():void {
			Conf.getInstance().numberFormatter.rounding= NumberBaseRoundType.UP;
			Conf.getInstance().numberFormatter.precision=2;
			Conf.getInstance().numberFormatter.decimalSeparatorFrom=",";
		}
		
		public static function initConf():void {
			trace("Initializing configuration...");
			Conf.getInstance().setAmazonKey("1K9F7ZQ6BZ5A0QEV76R2");
			Conf.getInstance().setAmazonWsdlUrl("http://azbest.vdl.pl/proxy.php?url=http://webservices.amazon.com/AWSECommerceService/AWSECommerceService.wsdl");
			Conf.getInstance().setCnetKey("22569241417921932475142053432913");
			Conf.getInstance().setCnetRestUrl("http://api.cnet.com/rest/v1.0/techProductSearch?");
			Conf.getInstance().seteBayKey("viewcomm-b107-41ff-937e-2739566c037e");//E651EF97-EF88-DA85-57D0-413AC07DF21A
			Conf.getInstance().setAmazonRestUrl("http://azbest.vdl.pl/proxy.php?url=http://webservices.amazon.com/onca/xml?Service=AWSECommerceService");
			Conf.getInstance().seteBayRestURL("http://open.api.ebay.com/shopping?");
			Conf.getInstance().setCurrency(Currencies.PLN);
			trace("   ...done[init conf]");
			//trace("Security file loaded from:http://azbest.vdl.pl/crossdomain.xml");
			//Security.loadPolicyFile("http://azbest.vdl.pl/crossdomain.xml");
		}
		
		public static function initLogging():void{
			trace("Initializing logging...");
			
			//var tt:TraceTarget  = new TraceTarget();
			//tt.includeCategory= true;
			//tt.includeDate = true;
			//tt.includeTime =true;
			//tt.includeLevel=true;
			
			
		//	trace("  ...done[logging init]");
			//tt.filters=["cmd.*","web.*","web.service.*","application.*","tools.*","engine.*","cmd.ui.*"];
           // tt.filters=["application.*","engine.*","cmd.ui.*","cmd.*","web.service.*","flash.*","flash.events.*"];
          //  tt.filters=["web.service.*"];
			//tt.level=LogEventLevel.DEBUG;
			//Log.addTarget(tt);  
			Invoker.getInstance();
			//trace("...logging init done.")
		}
		private static var TEST_QUERY_EBAY:String= "http://open.api.ebay.com/shopping?version=517&appid=viewcomm-b107-41ff-937e-2739566c037e&callname=FindItemsAdvanced&QueryKeywords=samsung model&ItemSort=BestMatch&MaxEntries=1&Currency=USD";
		private static var TEST_QUERY_CNET:String = "http://api.cnet.com/rest/v1.0/techProductSearch?partKey=22569241417921932475142053432913&query=samsung&iod=Cbreadcrumb&start=0&limit=3&";
		/**Testing web services for availability*/
		private static var cnet : HTTPService= new HTTPService();
		private static var ebay : HTTPService= new HTTPService();
		public static function initWebServices():void {
			Conf.AMZ=1;
			/*
			trace("testing amazon");
			var amazon : WebService= new WebService();
			amazon.wsdl=Conf.getInstance().getAmazonWsdlUrl();
			amazon.addEventListener(LoadEvent.LOAD,loadHandlerAmazon);
			amazon.addEventLstener(FaultEvent.FAULT,faultHandlerAmazon);
			amazon.loadWSDL();
			
			var aws:WebService= new WebService();
			
			
						//here we have to define SOAP method invocation
			var ResponseGroup:Array=[] ;
			ResponseGroup[0]="ItemAttributes";
			var Shared:Object= new Object();  
			
            Shared.Keywords="samsung";//ex samsung 940N
            Shared.SearchIndex="Electronics"
            Shared.ItemPage=1;          
            aws.ItemSearch.resultFormat="e4x";
            aws.ItemSearch.request.AWSAccessKeyId=Conf.getInstance().getAmazonKey();  //should obtain in AWS dev center            
            aws.ItemSearch.request.Shared=Shared;
            
            aws.ItemSearch.send();
            
            */
            
       
            
			
			
			
			trace("Testing ebay...");
			
			
			ebay.url=TEST_QUERY_EBAY;
			ebay.addEventListener(ResultEvent.RESULT,loadHandlereBay);
			ebay.addEventListener(FaultEvent.FAULT,faultHandlereBay);
			trace("Testing ebay with call: "+TEST_QUERY_EBAY);	
			ebay.send();
		
			trace("Testing cnet...");
			
			cnet.url=TEST_QUERY_CNET;
			trace("Testing ebay with call: "+TEST_QUERY_CNET);
			cnet.addEventListener(ResultEvent.RESULT,loadHandlerCNET);
			cnet.addEventListener(FaultEvent.FAULT,faultHandlerCNET);
			cnet.send();

			trace(" All test started.");
		}
	
		
		//OKs
		private static function loadHandlerAmazon(eve:LoadEvent):void {
			Conf.AMZ=1;
			logger.info("Amazon WS available");
			
			Invoker.getInstance().addCommand( new cmd_WSSuccess());
			Invoker.getInstance().invoke();
		}
		private  static function loadHandlereBay(eve:ResultEvent):void {
			Conf.EBY=1;
			logger.info("eBay WS available");
			IStart.getInstance().setBrowseResultsLabel("eBay available");
			Invoker.getInstance().addCommand( new cmd_WSSuccess());
			Invoker.getInstance().invoke();
			
		}
		private  static function loadHandlerCNET(eve:ResultEvent):void {
			Conf.CNE=1;
			logger.info("CNET WS available");
			IStart.getInstance().setBrowseResultsLabel("CNET available");
			Invoker.getInstance().addCommand( new cmd_WSSuccess());
			Invoker.getInstance().invoke();
		}

		
		
		//Falls
		private  static function faultHandlerAmazon(faul:FaultEvent):void {
			logger.fatal("Amazon WS not available.");
			Conf.AMZ=-1;
			Invoker.getInstance().addCommand( new cmd_WSFail("Amazon WS failure, This is fatal eror. Application is usless."));
			Invoker.getInstance().invoke();
			
        	
		}
		private static function faultHandlereBay(faul:FaultEvent):void {
			logger.error("eBay WS not available.");
			Conf.EBY=-1;
			Invoker.getInstance().addCommand( new cmd_WSFail("Error: eBay Web Service failure, You cannot add eBay alterantives  to search results"));
			Invoker.getInstance().invoke();
		}
		private static function faultHandlerCNET(faul:FaultEvent):void {
			logger.error("CNET WS not available.");
		    Conf.CNE=-1;
			Invoker.getInstance().addCommand( new cmd_WSFail("Error: Cannot connect to CNET service, You cannot add CNET data  to search results"));
			Invoker.getInstance().invoke();
			
		}
		
		
	}
}
class SingletonEnforcer{}