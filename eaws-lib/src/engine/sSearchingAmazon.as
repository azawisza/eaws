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
package engine
{
	import cmd.Invoker;
	import cmd.cmd_AmazonCall;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import web.data.SearchData;
	
	public class sSearchingAmazon implements State
	{
	    private var machine:StateMachine = null;
	    private static var logger:ILogger = Log.getLogger("engine.sSearchingAmazon");
		public function sSearchingAmazon(machine:StateMachine)
		{
			this.machine=machine;
		}

		public function init():State
		{
			return machine.state;
		}
			public function iinit(msg:String):State
		
		{
			trace("signal");
			return machine.state;
			
		}
		/**
		 * 1.receive data from UI and call method that creates the main searh root
		 * */
		
		public function newSeacrh(sdata:SearchData):State
		{
		if(StateMachine.amz_PAGE!=StateMachine.amz_PAGE_OLD){
				//we had a Next/Back call
				//rollback it 
				trace("We have REJECTED call ");
		    	trace("Reason: " + 
					"amz_PAGE=" + StateMachine.amz_PAGE+"\n"+
					"amz_PAGE_OLD=" + StateMachine.amz_PAGE_OLD+"\n"+
					"keyword=" + sdata.keyword+"\n"+
					"oldKeyword=" + this.machine.oldKeyword+"\n"+					
					"");
				StateMachine.amz_PAGE=StateMachine.amz_PAGE_OLD;	
		}
		
			/*if( this.machine.oldKeyword==null) {
				//completely start
				trace("We have accepted call (new keyword ="+sdata.keyword+") (old keyword="+this.machine.oldKeyword+")");
				//sdata keyw is now OLD keyw
				this.machine.oldKeyword=sdata.keyword;
				StateMachine.amz_PAGE=1;
				StateMachine.amz_PAGE_OLD=1;
			    this.machine.sdata=sdata;
				this.searchAmazon();
			}else if(sdata.keyword!=this.machine.oldKeyword){
				//new keyword
				trace("We have accepted call (new keyword ="+sdata.keyword+") (old keyword="+this.machine.oldKeyword+")");
				//sdata keyw is now OLD keyw
				this.machine.oldKeyword=this.machine.sdata.keyword;
				StateMachine.amz_PAGE=1;
				StateMachine.amz_PAGE_OLD=1;
			    this.machine.sdata=sdata;	
				this.searchAmazon();
			}else if(( StateMachine.amz_PAGE >0 &&StateMachine.amz_PAGE!=StateMachine.amz_PAGE_OLD &&  sdata.keyword==this.machine.oldKeyword)) {
				//old keyworld but NEXT or PREV page
				trace("We have accepted call (new keyword ="+sdata.keyword+") (old keyword="+this.machine.oldKeyword+")");
				trace("BUT we have request for next page "+StateMachine.amz_PAGE +" old one: "+StateMachine.amz_PAGE_OLD);
				this.machine.oldKeyword=sdata.keyword;
				StateMachine.amz_PAGE_OLD=StateMachine.amz_PAGE;
				
			this.machine.sdata=sdata;
			this.searchAmazon();
			}
			else {
			trace("We have REJECTED call ");
			trace("Reason: " + 
					"amz_PAGE=" + StateMachine.amz_PAGE+"\n"+
					"amz_PAGE_OLD=" + StateMachine.amz_PAGE_OLD+"\n"+
					"keyword=" + sdata.keyword+"\n"+
					"oldKeyword=" + this.machine.oldKeyword+"\n"+					
					"");
		}
		*/
		trace("SORRY CANT PERFORM NEW SEARCH, WAITING FOR DATA TO ARRIVE");
		return machine.state;
		
		}//new Search
		
		 /**
		 * 1. Define call to amazon
		 * 2. Move to browsable (from searching thread)
		 * */
		public function searchAmazon():State
		{	trace("Calling amazon"+this.machine.sdata.keyword);
		    trace("Calling amazon"+this.machine.sdata.category);
		    trace("Calling amazon"+this.machine.sdata.toItem);
		    
		    logger.info("New Search="+this.machine.sdata.toString());
				
				trace("We have accepted call (new keyword), page2display = "+StateMachine.amz_PAGE);
				
			    this.machine.oldKeyword=this.machine.sdata.keyword;
			
			Invoker.getInstance().addCommand(new cmd_AmazonCall(this.machine.sdata.keyword,this.machine.sdata.category,StateMachine.amz_PAGE));
			Invoker.getInstance().invoke();
			//state to browsable will be changd when calll searching amazon will finish.
		    
		    return machine.state;
			
			
			
		}
		
		public function searchAlt():State
		{
			return machine.state;
		}
		
		public function next():State
		{
			return machine.state;
		}
		
		public function prev():State
		{
			return machine.state;
		}
		
		public function quit():State
		{
			return machine.state;
		}
		
	}
}