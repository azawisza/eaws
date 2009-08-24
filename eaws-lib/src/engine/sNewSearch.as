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
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import web.data.SearchData;

	public class sNewSearch implements State
	{
		private var machine:StateMachine = null;
		private var logger:ILogger = Log.getLogger("engine.sNewSearch");
		public function sNewSearch(machine:StateMachine)
		{
			this.machine=machine;
		}

		public function init():State
		{
			return null;
		}
	
		public function newSeacrh(sdata:SearchData):State
		{
			if( this.machine.oldKeyword==null) {
				//completely start
				trace("We have accepted call (new keyword ="+sdata.keyword+") (old keyword="+this.machine.oldKeyword+")");
				//sdata keyw is now OLD keyw
				this.machine.oldKeyword=sdata.keyword;
				StateMachine.amz_PAGE=1;
				StateMachine.amz_PAGE_OLD=1;
			    this.machine.sdata=sdata;
			    this.machine.state= machine.stateSearchingAmazon;
				machine.searchAmazon();
			}else if(sdata.keyword!=this.machine.oldKeyword){
				//accepting old keyword
				trace("We have accepted call (new keyword ="+sdata.keyword+") (old keyword="+this.machine.oldKeyword+")");
				//sdata keyw is now OLD keyw
				this.machine.oldKeyword=this.machine.sdata.keyword;
				StateMachine.amz_PAGE=1;
				StateMachine.amz_PAGE_OLD=1;
			    this.machine.sdata=sdata;
			    this.machine.state= machine.stateSearchingAmazon;	
				machine.searchAmazon();
			}
			
			else if(( StateMachine.amz_PAGE >0 &&StateMachine.amz_PAGE!=StateMachine.amz_PAGE_OLD &&  sdata.keyword==this.machine.oldKeyword)) {
				//old keyworld but NEXT or PREV page
				trace("We have accepted call (new keyword ="+sdata.keyword+") (old keyword="+this.machine.oldKeyword+")");
				trace("BUT we have request for next page "+StateMachine.amz_PAGE +" old one: "+StateMachine.amz_PAGE_OLD);
				this.machine.oldKeyword=sdata.keyword;
				
				StateMachine.amz_PAGE_OLD=StateMachine.amz_PAGE;
				
			this.machine.sdata=sdata;
			this.machine.state= machine.stateSearchingAmazon;
			machine.searchAmazon();
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
		return machine.state;
		
		}//new Search
		
		
		public function searchAmazon():State
		{
			return null;
		}
		
		public function searchAlt():State
		{
			return null;
		}
		
		public function next():State
		{
			return null;
		}
		
		public function prev():State
		{
			return null;
		}
		
		public function quit():State
		{
			return null;
		}
		
		public function iinit(msg:String):State
		{
			return null;
		}
		
	}
}