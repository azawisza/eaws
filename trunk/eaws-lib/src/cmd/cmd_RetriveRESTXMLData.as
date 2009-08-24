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
	import mx.rpc.soap.LoadEvent;
	import mx.rpc.soap.WebService;
	
	import web.WebServiceResultReceiver;
	import web.service.WSResultParserAmazon;
	import web.service.WSResultParserCNETOld;

	
	/**Rtriing data from WebSrvice
	 * Using rest and XMLrequest objects
	 * Typically invoked by REST creators 
	 * this class uses generic webservices, no matter if they use SOAP, REST or libray.
	 * Amazon - SOAP
	 * eBay - SOAP library generated 
	 * CNET - Rest call. Proper class servies (all of witch are subclasses of WebServiceResultReceiver)
	 * rael soap call takes place here, and only diffrence is that diffrent result handlers are plugged in . 
	 * 
	 * */
	public class cmd_RetriveRESTXMLData implements Command
	{	
		public static const  AMAZON:Number=0 ;
		public static const  CNET:Number=1;
		public static const  ALLEGRO:Number=2;
		public static const  AMAZON_SOAP:Number=3 ;
		private var type:Number = -1;
		private var xmlUrl:String= "";
		private var logger:ILogger = Log.getLogger("cmd.cmd_RetriveXMLData");
		public function cmd_RetriveRESTXMLData(query:String,type:Number)
		{
			if(type<3)this.type=type;
			else throw new IllegalCommandTypeException("This is not valid command type");
			
			this.xmlUrl=query;
		}
        private var result:WebServiceResultReceiver = null;
		public function execute():void
		{
			trace("Executing command - retriving CNET REST data");
			var service:HTTPService = new HTTPService();
			
			if(type==1){
				logger.info("CNET command");
				result=WSResultParserCNETOld.getInstance();
			}
			
			if(type==0){
				logger.info("Amazon command");
				result=WSResultParserAmazon.getInstance();
				logger.warn("Use SOAP for amazon calls");
				
				return ;
			}
			if (type ==2){
				//2
				logger.info("Allegro command");
				result = WSResultParserAmazon.getInstance();
				logger.warn("Allegro not supported");
				return;
			}
			if(type==3){
				//3
				logger.info("Amazon SOAP command");
				result = WSResultParserAmazon.getInstance();
				amazonSOAPCall();
				return;
			}
			
			service.url=xmlUrl;
			logger.info("Retriving XML data from: "+xmlUrl);
			service.resultFormat="e4x";
			service.requestTimeout=30;
			service.addEventListener(ResultEvent.RESULT,result.resultHandler);
			service.addEventListener(FaultEvent.FAULT,result.faultHandler);
			trace(""+service.toString());
			service.send();
			trace("Call sent of type="+type);			
		}//execute
		
		private var aws:WebService= new WebService();
		private function amazonSOAPCall():void {
			
			  aws.wsdl=Conf.getInstance().getAmazonWsdlUrl();
			  aws.addEventListener(FaultEvent.FAULT,result.faultHandler);
			  aws.addEventListener(ResultEvent.RESULT,result.resultHandler);
			  aws.addEventListener(LoadEvent.LOAD,wsdlLoadHandler);
			  trace("amazon SOAP handlers added.");
			  aws.loadWSDL();
			  //here we have to define SOAP method invocation
			  
			  var Shared:Object= new Object();  
              //Shared.Keywords=query;//ex samsung 940N
              
              
              aws.ItemSearch.request.AWSAccessKeyId=Conf.getInstance().getAmazonKey();  
              aws.ItemSearch.request.Shared=Shared;  
              trace("request SENT...");  
              aws.ItemSearch.send();
                
		}
		private function wsdlLoadHandler(load:LoadEvent):void {
			logger.info("Amazon wsdl loaded:"+load.wsdl);
		}	
		
	}
}
	
class IllegalCommandTypeException extends Error {
	public function IllegalCommandTypeException(msg:String ){
		super(msg);
	}
} 
