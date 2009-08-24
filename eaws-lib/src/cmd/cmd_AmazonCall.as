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
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.WebService;
	
	import web.WebServiceResultReceiver;
	import web.service.WSResultParserAmazon;
	/**SOAP amazon call and result handler plug in*/
	public class cmd_AmazonCall implements Command
	{
		private var logger:ILogger = Log.getLogger("cmd.cmd_AmazonCall");
		private var query:String="";
		private var category:String="";
		private var page:int;
		private var result:WebServiceResultReceiver = null;
		private var aws:WebService= new WebService();
		
		public function cmd_AmazonCall(query:String,category:String,page:int)
		{
			trace("instance of cmd_AmazonCall created.. ");
			this.query=query;
			this.category=category;
			this.page=page;
			
		}

		public function execute():void
		{
			IStart.getInstance().setBrowseResultsLabel("Please wait ...");
			trace("Start of command cmd_AmazonCall execution ..............");
			result = WSResultParserAmazon.getInstance();
			aws.wsdl=Conf.getInstance().getAmazonWsdlUrl();
			aws.addEventListener(FaultEvent.FAULT,result.faultHandler);
			aws.addEventListener(ResultEvent.RESULT,result.resultHandler);
			aws.requestTimeout=60;
			
		
			
			trace("amazon SOAP handlers added.");
			aws.endpointURI="http://azbest.vdl.pl/proxy.php?url=soap.amazon.com/onca/soap";
			aws.loadWSDL();
			//here we have to define SOAP method invocation
			var ResponseGroup:Array=[] ;
			ResponseGroup[0]="ItemAttributes";
			ResponseGroup[1]="Images";
			//ItemAttributes,Images,OfferSummary
			ResponseGroup[2]="OfferSummary";
			var Shared:Object= new Object();  
			
            Shared.Keywords=this.query;//ex samsung 940N
            Shared.SearchIndex=this.category;//ex PCHardware
            Shared.ItemPage=page;
            Shared.ResponseGroup=ResponseGroup;
            
          
            //aws.resultType="e4x";
       		//aws.ItemSearch.resultType="e4x";
            aws.ItemSearch.resultFormat="e4x";
           // aws.resultType="e4x";
            aws.ItemSearch.request.AWSAccessKeyId=Conf.getInstance().getAmazonKey();  //should obtain in AWS dev center            
            aws.ItemSearch.request.Shared=Shared;
            logger.info("Call: "+aws.rootURL);
            
            aws.ItemSearch.send();
            trace("request SENT");  
			trace("     .......... End of command cmd_AmazonCall execution");
		}
		
		
	}
}