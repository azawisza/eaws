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
package web.data
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	/**Represents data of result set of amazon search, without alternatives from ebay or CNET or allegro, it can be considered as main result page */	
	public class AmazonSearchResults implements  IEventDispatcher
	{
		public function AmazonSearchResults()
		{
		}
		public var ItemPage:String;
		public var TotalResults:String;
		public var TotalPages:String;
		public var ItemCount:int; //items per page (real) if we have 13 results, then this val for sec page will be 3
		public var amazonSearchDataObjects:ArrayCollection= new ArrayCollection();
		
		public function toString():String {
			
			return "" + 
					"itemPage=" + ItemPage+ "\n"+
					"totalResults=" + TotalResults+  "\n"+
					"totalPages=" + TotalPages+  "\n"+
					"itemCount=" + ItemCount+  "\n\n\n"+
					"amazonSearchDataObjects=" + amazonSearchDataObjects.toString()+  "\n"+
					"";
		}
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return false;
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return false;
		}
		
		public function willTrigger(type:String):Boolean
		{
			return false;
		}
	}
}