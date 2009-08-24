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
package application
{
	/**this interace represents major UI calls */
	public interface GeneralUIInterface
	{
		/**Show main data grid, in idle state app does not show one.*/
		function showResultGrid():void;
		/**Update values about place in search results in amz return search data.*/
		function setBrowseResultsLabel(txt:String):void;
		
	}
}