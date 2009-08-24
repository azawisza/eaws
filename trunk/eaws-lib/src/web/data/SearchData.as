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
	/**Trnsfers data from UI to engine*/
	public class SearchData
	{	
		public var keyword:String="";
		public var category:String="";
		public var cnetCall:Boolean=false;
		public var ebayCall:Boolean=false;
		public var ebayItems:int=5;
		public var ebayBuyNow:Boolean=false;
		public var fromItem:int=1;
		public var toItem:int=10;
		public function SearchData()
		{
		}
		public function toString():String{
			return "" + 
					"keyword" + keyword+"\n"+
					"category" + category+"\n"+
					"cnetCall" + cnetCall+"\n"+
					"ebayCall" + ebayCall+"\n"+
					"ebayItems" + ebayItems+"\n"+
					"ebayBuyNow" + ebayBuyNow+"\n"+
					"fromItem" + fromItem+"\n"+
					"toItem" +toItem +"\n"+
					"";
		}

	}
}