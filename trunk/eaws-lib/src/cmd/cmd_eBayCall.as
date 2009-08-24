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
	import mx.rpc.soap.WebService;
	
	public class cmd_eBayCall implements Command
	{	
		private static var logger:ILogger = Log.getLogger("cmd.cmd_eBayCall");
		public function cmd_eBayCall(manufactirer:String,model:String,itemsPerPage:int)
		{
			
		/*	var r:GetSearchResultsRequestType= new GetSearchResultsRequestType();
						
		
			var service:EBayAPIInterfaceService = new EBayAPIInterfaceService();
			//getSearchResultsRequestType
			
			
	    	var type:GetSearchResultsRequestType = new GetSearchResultsRequestType();
			//type.AdFormat=false;
			//type.AffiliateTrackingDetails = new AffiliateTrackingDetailsType();
			//type.BidRange= new BidRangeType();
			
			type.Query=manufactirer+" "+model;
			type.Pagination = new PaginationType();
			type.Pagination.EntriesPerPage=itemsPerPage;
			type.Pagination.anyElement = new Array();
			type.Pagination.PageNumber=1;
			
			//@
			service.addgetSearchResultsEventListener(tmpRes);
			var response:AsyncToken=  service.getSearchResults(type);
			
			trace(response);
			var data:DataObjectEBay = new DataObjectEBay();
			*/
			
			//FindItemsAdvanced
			//service.
		/////////////////////////////
		
			//setting web service
			var ws:WebService = new WebService();
			ws.wsdl="http://developer.ebay.com/webservices/latest/eBaySvc.wsdl";
			ws.addEventListener(FaultEvent.FAULT,tmpFault);
			ws.addEventListener(ResultEvent.RESULT,tmpRes);
			ws.loadWSDL();
			ws.GetSearchResults.resultFormat="e4x";
			
			//paging and query data (???)
			var GetSearchResultsRequestO:Object= new Object();
			var PaginationO:Object =new Object(); 
			PaginationO.EntriesPerpage=5;
			//PaginationO.PageNumber=1;
			//var smala:Object= new Object();
			//smala[0]="";
			//PaginationO.anyEntry=smala;
			//AuthTokenTypeCodeType
			GetSearchResultsRequestO.Pagination=PaginationO;
			GetSearchResultsRequestO.Query=manufactirer+" "+model;
			ws.GetSearchResults.request.GetSearchResultsRequest=GetSearchResultsRequestO;
			
			//handlers 
		    ws.addEventListener(FaultEvent.FAULT,tmpFault);
			ws.addEventListener(ResultEvent.RESULT,tmpRes);
			
			
			//header with atuth data 
			
			/*var header :Object=new Object();
			var RequesterCredentials:Object= new Object();
            RequesterCredentials.eBayAuthToken=Conf.getInstance().geteBayKey();
            header.RequesterCredentials=RequesterCredentials;*/
            Conf.getInstance().geteBayKey()
            ws.addHeader(<RequesterCredentials><eBayAuthToken>viewcomm-b107-41ff-937e-2739566c037e</eBayAuthToken></RequesterCredentials>);
            
            ws.GetSearchResults.request=	<GetSearchResults>
			<Query>
			samsung
			</Query>
			<Pagination>
			 <EntriesPerpage>
			 5
			 </EntriesPerpage>
			 
			</Pagination>
			</GetSearchResults>;
            //execute		
			ws.GetSearchResults.send();
		

			
			
				
		}
		private function tmpFault(fau:FaultEvent):void {
			trace(fau.toString());
		}
		private function tmpRes(eve:ResultEvent):void {
			trace(eve.toString());
		}

		public function execute():void
		{
			
		}
		
	}
}