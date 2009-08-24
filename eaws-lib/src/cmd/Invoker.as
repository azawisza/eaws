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
package cmd
{
	import mx.collections.ArrayCollection;
	import mx.logging.*;
	import mx.logging.targets.*;
	/**Behaviour of this class in mthreaded environmet is subject to discusss. 
	 * Is ArrayCollection thread safe ?
	 * */
	public class Invoker {
		
		
		private static var logger:ILogger = Log.getLogger("cmd.Invoker");
		private var command:Command;
		private var commands:ArrayCollection= new ArrayCollection();
	    private static var instance:Invoker ;
		public function Invoker(blocker:SingletonEnforcer) {
			//this class cannot be instantied from outside - 
			//AS do not suport private constructors
			//trace("Creating instance of invoker"); 
		}
		
		//Normal get instamnce like in java
		public static  function getInstance():Invoker{
			//logger.info("Obtaining instance of invoker"); 
			if(instance==null){
				instance= new Invoker(new SingletonEnforcer());
			}
				return instance;
		}
		public function addCommand(command:Command):void{
			this.commands.addItem(command);
		}
		public function invoke():void{
			//trace("Executing command(s) in ");
			//if(this.command!=null)this.command.execute();
			for(var i:int=0;i<commands.length;i++){
				(commands.getItemAt(i)as Command).execute();
				commands.removeItemAt(i);
			}	
		}
		
	}
}
//this class is not visible outside 
//the package so it prohibits from invoking constructor of Invoker directly.
class SingletonEnforcer {}