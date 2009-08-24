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
	import cmd.Invoker;
	import cmd.cmd_eBayCallRest;
	
	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import web.data.DataObjectAmazon;
	
	/**eBay call manager. Calls for  products alt*/
	public class AltEBayController
	{
		
		
		private static var logger:ILogger = Log.getLogger("application.AltCNETController");
	
	    private static var instance:AltEBayController;
		public function AltEBayController(blocker:SingletonEnforcer) {
			//trace("Creating instance of Conf"); 
		}
		
		
		public static  function getInstance():AltEBayController{
			//logger.info("Obtaining instance of Conf"); 
			if(instance==null){
				instance= new AltEBayController(new SingletonEnforcer());
			}
				return instance;
		}//getinstance
		
		private var model:String;
		private var man:String;
		private var itemAdInit:ArrayCollection;
		private var doa:DataObjectAmazon;
		
		public function configure(itemAdInit :ArrayCollection,doa:DataObjectAmazon):void {
			
			this.itemAdInit=itemAdInit;
			this.doa=doa;
			trace("Configured with itemAdInit of length :"+itemAdInit.length+" and doa= "+doa.Manufacturer+" model= "+doa.Model);
		}
		public function launchEBayAlt(man:String,model:String,itemsCount:int):void {
			this.man=man;
			this.model=model;
			trace("launch CNET alts");
			Invoker.getInstance().addCommand(new cmd_eBayCallRest(man,model,itemsCount,itemAdInit,doa));
			Invoker.getInstance().invoke();
		}

	}
}
class SingletonEnforcer{}