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
	import web.data.SearchData;
	
	public interface State
	{
		function init():State ;
		function newSeacrh(sdata:SearchData):State ;
		function searchAmazon():State;
		function searchAlt():State;
		function next():State;
		function prev():State;	
		function quit():State ;
		function iinit(msg:String):State ;
	}
}