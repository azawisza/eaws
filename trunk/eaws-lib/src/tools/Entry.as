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
	public class Entry
	{
		private var key:Object = null;
		private var value:Object= null;
		public function Entry(key:Object,value:Object)
		{
			this.key=key;
			this.value=value;
		}
		public function getKey():Object{
			return this.key;
		}
		public function getValue():Object{
			return this.value;
		}
		public function setValue(value:Object):void{
			this.value=value;
		}
		public function toString():String{
			if(this.value!=null){
			return "["+(this.key as String)+","+(this.value as String)+"]";
			}else {
			return "["+(this.key as String)+","+"null"+"]";	
			}
		}
		

	}
}