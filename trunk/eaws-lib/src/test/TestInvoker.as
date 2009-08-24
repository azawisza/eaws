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
import cmd.Invoker;

import flexunit.framework.TestCase;
import flexunit.framework.TestSuite;

	public class TestInvoker extends TestCase{
		
		//Constructor have to ake string that is name of method   
		public function TestInvoker(name:String){
		super(name);
	
		
		
		 
		
		}
		//Method HAVE TO have name in pattern test***, be public and return void 
		//
		public function testCreation():void{
			var inv:Invoker= Invoker.getInstance();
			var inv2:Invoker= Invoker.getInstance();
			assertTrue(inv==inv2);
			
			
		}
		//Add method that is static and returns a test suite that is associated with this certain test case
		//You may add many diffrent cases to one test suite
			public static function suite():TestSuite {
   			var ts:TestSuite = new TestSuite();
   			ts.addTest( new TestInvoker( "testCreation" ) );		
   			return ts;
   		}
	//Then in file MXML create componenet that is FlexUnit
	//TestRunnerBase comonenet that presents UI to run and show test results
	//In this UI add creationComplete="onCreationComplete()
	//and define as INSIDE MXML ActionScript3 script that defines this method ...   
	

    }
   
}