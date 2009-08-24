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
{	/**Represents data of single item found on amazon*/
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	public class DataObjectAmazon implements IEventDispatcher
	{
		public function DataObjectAmazon()
		{
		}
		public var DetailPageURL:String;
		public var SmallImage_URL:String;
		public var SmallImage_Height:String;
		public var SmallImage_Width:String;
		public var MediumImage_URL:String;
		public var BigImage_URL:String;
		public var BigImage_Height:String;
		public var BigImage_Width:String;
		public var Brand:String;//Item[i].ItemAttributes.Brand

		public var ListPrice_Amount:String;
		
		public var ListPriceNative:String="n/a";	
		public var LowestUsedPriceNative:String="n/a";
		public var LowestNewPriceNative:String="n/a";
		
		public var LowestUsedPrice_Amount:String;
		public var LowestNewPrice_Amount:String="n/a";
		public var Manufacturer:String;
		public var Model:String;
		public var MPN:String;
		public var Title:String;
		
		public var lowestPrice:Number;
		public var lowestPriceFormatted:String;
		public var lowestPriceUrl:String;
		
		public var lowestPriceURL:String="http://www.ebay.com";
		//cnet stuff
		public var dataObjectCnet:DataObjectCNET= null;
		public var dataObjectEBayList: ArrayCollection= null;
		public var dataObjectEBayListXML: XML= null;
		
		
	
		
		public function toString():String{
			
			return"" + 
					"DetailPageURL=" + DetailPageURL+"\n"+
					"SmallImage_URL=" + SmallImage_URL+"\n"+
					"MediumImage_URL=" + MediumImage_URL+"\n"+
					"SmallImage_Height=" + SmallImage_Height+"\n"+
					"SmallImage_Width=" + SmallImage_Width+"\n"+
					"BigImage_URL=" + BigImage_URL+"\n"+
					"BigImage_Height=" + BigImage_Height+"\n"+
					"BigImage_Width=" + BigImage_Width+"\n"+
					"Brand=" + Brand+"\n"+
					"ListPrice_Amount=" + ListPrice_Amount+"\n"+
					"Manufacturer=" + Manufacturer+"\n"+
					"Model=" + Model+"\n"+
					"MPN=" + MPN+"\n"+
					"Title=" + Title+"\n"+
					"LowestUsedPrice_Amount=" + LowestUsedPrice_Amount+"\n"+
					"LowestNewPrice_Amount=" +LowestNewPrice_Amount+"\n"+ 
					"";
		}
		/**Generates Object  data representation .*/
		public function getData():Object {
		 var data:Object= new Object();
		  data.DetailPageURL=DetailPageURL; 
		  data.SmallImage_URL=SmallImage_URL;
		  data.MediumImage_URL=MediumImage_URL;
		  data.SmallImage_Height=SmallImage_Height;
		  data.SmallImage_Width=SmallImage_Width;
		  data.BigImage_URL=BigImage_URL;
		  data.BigImage_Height=BigImage_Height;
		  data.BigImage_Width=BigImage_Width;
		  data.Brand=Brand;//Item[i].ItemAttributes.Brand
		  data.ListPrice_Amount=ListPrice_Amount; 
		  data.LowestUsedPrice_Amount=LowestUsedPrice_Amount;
		  data.LowestNewPrice_Amount=LowestNewPrice_Amount;
		  data.Manufacturer=Manufacturer;
		  data.Model=Model;
		  data.MPN=MPN;
		  data.Title=Title;
		  return data ;
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