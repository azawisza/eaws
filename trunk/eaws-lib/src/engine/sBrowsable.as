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
	
	public class sBrowsable implements State
	{
	    private var machine:StateMachine = null;
	    private static var logger:ILogger = Log.getLogger("engine.sBrowsable");
		public function sBrowsable(machine:StateMachine)
		{
			this.machine=machine;
		}

		public function init():State
		{
			trace("Not allowed (init)");
		return machine.state;	
		}
		public function iinit(msg:String):State
		
		{
			trace("Not allowed (iinit)");
			return machine.state;
			
		}
	    /**
		 Another search call in this state will 
		 * 1.Move state to SearchAmazon (new search)
		 * 2. Perform new search regardless of keyword.
		 * */
		public function newSeacrh(sdata:SearchData):State
		{
			machine.oldKeyword=null;
			machine.sdata= null;
			machine.state=machine.stateSearchingAmazon;	
			machine.newSeacrh(sdata);
			return machine.state;
		}
		
		public function searchAmazon():State
		{
			trace("Not allowed (searchAmazon)");
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