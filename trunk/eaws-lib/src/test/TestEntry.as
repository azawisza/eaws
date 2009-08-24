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
package test
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import mx.utils.ObjectUtil;
	
	import tools.Entry;
	
	public class TestEntry extends TestCase
	{
	    public function TestEntry(name:String){
		    super(name);
		}
		public function testEntry():void {
			var entry:Entry = new Entry("key","value");
			assertTrue(ObjectUtil.compare(entry.toString(),"[key,value]")==0);
		}
		public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			ts.addTest( new TestEntry( "testEntry" ) );		
   			return ts;
   		}

	}
}