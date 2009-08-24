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
package cmd.ui
{
	import cmd.Command;
	
	import engine.StateMachine;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	/**this command is very similar to Falue command but it does not change state of engine.*/
	
	public class cmd_WSSuccess implements Command
	{
		private static var logger:ILogger=Log.getLogger("cmd.ui.cmd_WSSuccess");
		public function cmd_WSSuccess()
		{
		}

		public function execute():void
		{
			logger.info("Test success call on engine (iinit) ");
			StateMachine.getInstance().iinit("");		
		}
		
	}
}