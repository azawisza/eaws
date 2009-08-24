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
	import application.Conf;
	import application.IStart;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import web.data.SearchData;
	
	public class sInteractiveInit implements State
	{
	    private var machine:StateMachine = null;
	    private static var logger:ILogger = Log.getLogger("engine.StateInteractiveInit");
		public function sInteractiveInit(machine:StateMachine)
		{
			this.machine=machine;
		}

		public function init():State
		{
			logger.warn("Operation not supported.");
			return machine.state;
		}
		/**
		 * Invoked by 
		 * cmd_WSSuccess - 
		 * */
		public function iinit(msg:String):State
		{
			
			trace("[iinit][INTERACTIVE_INIT]...........");
			IStart.getInstance().addMsgToStart(msg);// if success ads nothing
			trace("   POPUP window opened.")
			
			//if curency failure
			if(Conf.CUR==-1){
				trace("manual currencies");
				IStart.getInstance().currencySetter();
				IStart.getInstance().addMsgToStart("\nPlease set Curency values (USD) otherwise 1 USD = 1 ");	
				
			}
			
			//if all elemnts checked
			trace("CNET ="+Conf.CNE);
			trace("Curr="+ Conf.CUR);
			trace("ebay="+Conf.EBY);
			
			if(( Conf.CNE* Conf.CUR*Conf.EBY)!=0){
				//all checked now final report.
			trace("CNET ="+Conf.CNE);
			trace("Curr="+ Conf.CUR);
			trace("ebay="+Conf.EBY);
				
				if(Conf.CNE==-1)IStart.getInstance().addMsgToStart("CNET not available");
				if(Conf.CUR==-1)IStart.getInstance().addMsgToStart("Currencies have to be set in  manual  way");
				if(Conf.EBY==-1){
						trace("EBAY not available");
						IStart.getInstance().addMsgToStart("eBya Not available");
				}
				trace("STOP gathering info ");
				IStart.getInstance().stopStartGatheringinfo();
				trace("           .........................[INTERACTIVE_INIT][iinit]");
				machine.state=machine.stateIdle;
				trace("init on IDLE");
				machine.iinit("");
				return machine.state;
				
			}
			trace("           .........................[INTERACTIVE_INIT][iinit]");			
			return machine.state;
		}
		public function newSeacrh(sdata:SearchData):State
		{
			return machine.state;
		}
		
		public function searchAmazon():State
		{
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
		
	    public 	function quit():State
		{
			return machine.state;
		}
		
	}
}