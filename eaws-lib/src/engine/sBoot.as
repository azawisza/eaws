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
	import application.UIFacade;
	
	import cmd.Start;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import web.data.SearchData;
	
	/**
	 * Appliaction initialization 
	 * - loading configuration from config files (todo)
	 * - loading Currencies
	 * - lesting availabilty of SOAs (amazon, ebay, CNET)
	 * - starting recovery procedure (todo)
	 * - applying certian constraints to UI (design flow)
	 * 
	 * */
	public class sBoot implements State
	{
	    private var machine:StateMachine = null;
	    private static var logger:ILogger = Log.getLogger("engine.awStateInitializing");
		public function sBoot(machine:StateMachine)
		{
			this.machine=machine;
		}
		/**
		 * 1.Initialize Configuration, logging, 
		 * 2. Start test of SOAs (curency, webservices)
		 * This init is started only once by UI
		 * */
		public function init():State
		{
			trace("[init][BOOT] peform init() ......");
			Start.initConf();
			Start.initLogging();
			Start.initCurrencyRates();
			Start.initWebServices();
			trace("   ...................[init][BOOT]");
			return machine.state;
			
		}
		
		public function newSeacrh(sdata:SearchData):State
		{
			logger.warn("Not available in this state");
			return machine.state;
		}
		/**If this function is called in INIT state, we have FISRT occuatnce of error.
		 * We have to 
		 * 1. OPEN window with error report
		 * 2. ADD soem TXT comment to it.
		 * 3. change state to IINIT
		 * If called by cmd_WSSuccess this method does not do anything.
		 * 
		 * */
		public function iinit(msg:String):State{
			trace("" + 
					"AMZ=" + Conf.AMZ+"\n"+
					"CNE=" + Conf.CNE+"\n"+
					"CUR=" +  Conf.CUR+"\n"+
					"EBY=" +Conf.EBY+ "\n"+
					"");
			if(Conf.AMZ<0 || Conf.CNE<0 || Conf.CUR<0|| Conf.EBY<0){
				//at least one fails
		    	trace("At least one SOA test failed. Opening IInit dialog and moving to IINIT");
			    IStart.getInstance().openStart(msg);
		        machine.state=machine.stateInteractiveInit;
      			return machine.state;
      		}else {
      			trace("Ok all SOA test OK or unchecked, proceedeing ...");
      			//do nothing those are not failures.
      			if(Conf.AMZ>0 && Conf.CNE>0 && Conf.CUR>0&& Conf.EBY>0){
      				// but if all test are completed, prepare UI
      				trace("All SOA tests passed.");
      				UIFacade.getInstance().enableUISearchOptions();
      				//moving to IDLE - wiating for keywords to search
      				
      				var t:Timer= new Timer(1000,1);
      				t.addEventListener(TimerEvent.TIMER_COMPLETE,doneT);
      				t.start(); 
      				machine.state=machine.stateIdle;
      				
      			}
      			
      			return machine.state;
      		}
			
		}
		public function doneT(event:TimerEvent){
			IStart.getInstance().setBrowseResultsLabel("Ready");
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
		
		public function quit():State
		{
			return machine.state;
		}
		
	}
}