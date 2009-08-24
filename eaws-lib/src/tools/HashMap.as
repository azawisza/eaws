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
package tools
{
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectUtil;
	/**This class uses mx.utils.ObjectUtil to compare objcts, as there is no hashCode or equals methods in AS3
	 * Tested for Strings
	 * */
	public class HashMap
	{
		private static var logger:ILogger=Log.getLogger("HashMap");
		private var array:ArrayCollection=new ArrayCollection();
		public function HashMap()
		{
			
		
		}
		public function put(key:Object,value:Object):Object{
			var entry:Entry=new Entry(key,value);
			trace(" putting ...");
			//loking for certain key in hashmap
			for(var i:int=0; i<array.length ; i++ ){
				var item:Object = array.getItemAt(i);
				var oldItem:Entry = item as Entry;
				trace(oldItem.getKey()+" "+key);
				if(ObjectUtil.compare(oldItem.getKey(),key )==0){
					trace("we have found an entry with same key, we switch the values");
					var oldValue:Object = oldItem.getValue() ;
					oldItem.setValue(value); 
					return oldValue;
				}else {
					//continue looking for key...
				}
			}
			//it seems that there is no such element ...
			array.addItem(entry);
			return null;
		}
		public function getValue(key:Object):Object{
			//loking for certain key in hashmap
			for(var i:int=0; i<array.length ; i++ ){
				var oldItem:Entry = array.getItemAt(i) as Entry;
				 
				trace(oldItem.getKey()+" "+key);
				if(ObjectUtil.compare(oldItem.getKey(),key )==0){
					trace("we have found an entry with same key, now let's return value"); 
					return oldItem.getValue() ;
				}else {
					//continue looking for key...
				}
			}
			//it seems that there is no such element ...
			return null;
		}
		
		public function values():ArrayCollection{
			var output:ArrayCollection=new ArrayCollection();
			// transfering data
			for(var i:int=0; i<array.length ; i++ ){
				var item:Entry = array.getItemAt(i) as Entry;
			    output.addItem(item.getValue());
			}
			return output;
		}
		public function keySet():ArrayCollection{
			var output:ArrayCollection=new ArrayCollection();
			// transfering data
			for(var i:int=0; i<array.length ; i++ ){
				var item:Entry = array.getItemAt(i) as Entry;
			    output.addItem(item.getKey());
			}
			return output;
		}
		public function toString():String{
			var about:String="";
			if(array.length==0){
				return "";
			}
			for(var i:int=0;i<array.length;i++){	
				about+= (array.getItemAt(i) as Entry).toString();
			}
			return about;
		}
		

	}
}