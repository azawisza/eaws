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
	
	/**State machine of  AWS system */
	public class StateMachine implements State
	{
		public var stateDisfunctional:State=null;
		
		
		public static const  INTERACTIVE_INIT:int=0;
		public static const  BROKEN:int=0;
		public static const  IDLE:int=0;
		public static const  NEW_SEARCH:int=0;
		public static const  SERACHING_AMAZON:int=0;
		public static const  BROWSABLE:int=0;
		public static const  SEARCHING_ALT:int=0;
		public static var   amz_PAGE:int=0;
		public static var   amz_PAGE_OLD:int=0;
		public static var   amz_PAGE_COUNT:int=0;
		
		public var stateInitializing:State= null;
		public var stateIdle:State= null;
		public var stateIdleBrowsable:State= null;
		public var stateInteractiveInit:State= null;
		public var stateSearchingAmazon:State= null;
		public var stateIBSearchingAlternatives:State= null;
		public var stateNewSearch:State= null;
		public var state:State= null;
		
		public var sdata:SearchData= null;
		var oldKeyword:String = null;
		
		 
		private static var logger:ILogger = Log.getLogger("engine.AWSMachine");
		
		private static var instance:StateMachine ;
	
		
		
		public static  function getInstance():StateMachine{
			logger.info("Obtaining instance of AWSMachine"); 
			if(instance==null){
				instance= new StateMachine(new SingletonEnforcer());
			}
				return instance;
		}//getinstance
		
		
		
		public function setState(state:State):void {
			this.state=state;
			logger.info("New state");
		}
		
		public function StateMachine(enforcer:SingletonEnforcer)
		{
			stateDisfunctional=new sBroken(this);
			stateIBSearchingAlternatives= new sSearchingAlt(this);
			stateIdle= new sIdle(this);
			stateIdleBrowsable = new sBrowsable(this);
			stateInitializing = new sBoot(this);
			stateInteractiveInit = new sInteractiveInit(this);
			stateSearchingAmazon = new sSearchingAmazon(this);
			stateNewSearch= new sNewSearch(this);
			state=stateInitializing;
			logger.info("AWSMachine created and configured; state Initializing"); 
			
		}

		public function init():State
		{	
			logger.info("init call");
			state.init();
    		return state;
		}
		public function iinit(msg:String):State
		
		{
			state.iinit(msg);
			return state;
			
		}
		public function newSeacrh(sdata:SearchData):State
		{
			logger.info("newSeacrh call");
			state.newSeacrh(sdata);
    		return state;			
		}
		
		public function searchAmazon():State
		{
			logger.info("searchAlt call");
			state.searchAmazon();
    		return state;			
		}
		
		public function searchAlt():State
		{
			logger.info("searchAlt call");
			state.searchAlt();
    		return state;			
		}
		
		public function next():State
		{
			logger.info("next call");
			state.next();
    		return state;			
		}
		
		public function prev():State
		{
			logger.info("prev call");
			state.prev();
    		return state;			
		}
		
		public function quit():State
		{
			logger.info("quit call");
			state.quit();
    		return state;			
		}
		
	}
}
class SingletonEnforcer{}