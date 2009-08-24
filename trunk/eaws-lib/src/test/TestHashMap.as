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
	import cmd.Start;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.utils.ObjectUtil;
	
	import tools.HashMap;
	
	public class TestHashMap extends TestCase
	{
		private static var logger:ILogger=Log.getLogger("TestHashMap");
		public function TestHashMap(str:String)
		{
			super(str);
		}
		public function testPut():void {
			 Start.initLogging();
			 var map:HashMap= new HashMap();
			 assertNull(map.put("one","1"));
			 assertTrue(map.put("one","1.0")==="1");
			 assertNull(map.put("two","2.0"));
			 
			 
			 
		}
		public function testToString():void {
			 var map:HashMap= new HashMap();
			 assertTrue(map.toString()==="");
			 map.put("Ally","Thomson");
			 assertTrue(map.toString()==="[Ally,Thomson]");
			 map.put("Joe","Chip");
			 assertTrue(map.toString()==="[Ally,Thomson][Joe,Chip]");
		}
		public function testGetValue():void {
			var map:HashMap= new HashMap();
			map.put("Ally","Thomson");
			map.put("Joe","Chip");
			map.put("Glen","Runciters");
			map.put("Glen","Runciter");
			map.put("Pat","Conroy");
			assertNull(map.getValue("John"));
			assertNull(map.getValue("Chip"));
			assertTrue(map.getValue("Joe")==="Chip");
			assertFalse(map.getValue("Glen")==="Runciters");
		}
		public function testValues():void {
			
			var map:HashMap= new HashMap();
			map.put("Ally","Thomson");
			map.put("Joe","Chip");
			map.put("Glen","Runciter");
			var arrayx:ArrayCollection= new ArrayCollection();		
			arrayx.addItem("Thomson");
			arrayx.addItem("Chip");
			arrayx.addItem("Runciter");
			trace(arrayx.toString().toString());
			trace(map.values().toString());
			assertTrue(ObjectUtil.compare(arrayx,map.values())==0);
			
			assertTrue(ObjectUtil.compare(arrayx,map.values())==0);
		}
		public function testKeySet():void {
			
			var map:HashMap= new HashMap();
			map.put("Ally","Thomson");
			map.put("Joe","Chip");
			map.put("Glen","Runciter");
			var arrayx:ArrayCollection= new ArrayCollection();		
			arrayx.addItem("Ally");
			arrayx.addItem("Joe");
			arrayx.addItem("Glen");
			trace(arrayx.toString().toString());
			trace(map.keySet().toString());
			assertTrue(ObjectUtil.compare(arrayx,map.keySet())==0);
			
		}
		
	    public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			ts.addTest( new TestHashMap( "testPut" ) );
   			ts.addTest( new TestHashMap( "testToString" ) );
   			ts.addTest( new TestHashMap( "testGetValue" ) );
   			ts.addTest( new TestHashMap( "testValues" ) );
   			ts.addTest( new TestHashMap( "testKeySet" ) );
   			return ts;
   		}

	}
}