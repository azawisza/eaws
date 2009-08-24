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
	import application.IStart;
	import application.UIFacade;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import web.data.SearchData;
	
	public class sIdle implements State
	{
	    private var machine:StateMachine = null;
	    private static var logger:ILogger = Log.getLogger("engine.sIdle");
		public function sIdle(machine:StateMachine)
		{
			this.machine=machine;
		}

		public function init():State
		{
			return machine.state;
		}
		/**This is last phaese of Interactve init in case of fai;ure of one of Ws tests performd at start.*/
		public function iinit(msg:String):State
		
		{	
			trace("[IDLE](iinit): Enabling UI elements according to WS test");
			UIFacade.getInstance().enableUISearchOptions();
			return machine.state;
			
		}
		/**
		 * 1. gathers data from UI (sarch settings)
		 * 2. launches proper inner commands 
		 * 3. reacts on command from UI
		 * */
		public function newSeacrh(sdata:SearchData):State
		
		{
			if(StateMachine.amz_PAGE<0){
				logger.warn("Illegal call - cannot take PREVIOUS page if IDLE");
				StateMachine.amz_PAGE=0;
				return machine.state;
			}
			if(StateMachine.amz_PAGE>0){
				logger.warn("Illegal call - cannot take NEXT page if IDLE");
				StateMachine.amz_PAGE=0;
				return machine.state;
			}
			IStart.getInstance().showResultGrid();
			logger.info("Moving from Idle to stateSearchingAmazon");
			machine.state=machine.stateNewSearch;
			machine.state.newSeacrh(sdata);
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
		
		public function quit():State
		{
			return machine.state;
		}
		
	}
}