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
	import engine.StateMachine;
	import engine.sBroken;
	import engine.sSearchingAlt;
	
	
	import engine.sBoot;
	
	import flexunit.framework.TestCase;

	public class TestAWSMachine extends TestCase
	{
		public function TestAWSMachine(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testCreation():void {
			assertTrue(StateMachine.getInstance(),StateMachine.getInstance());
		}
	
		
		public function testStates():void {
			var machine:StateMachine= StateMachine.getInstance();
			

		}
		
		
	}
}
