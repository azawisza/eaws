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
	import flash.display.DisplayObject;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.managers.PopUpManager;
	
	/**Simple manager of custom floating popup windows
	 * have to be first initialized on UI load - createInstance()
	 * Thab can be used via getInstance() and openXXX methods family.
	 * */
	public class IStart

	{	
		private static var logger:ILogger = Log.getLogger("application.IStart");
		private static var  instance:IStart= null;
		private static var displayMother:DisplayObject= null;
		
		
		/**Creating instance during app init*/
		public static function  createInstance(disp:DisplayObject):void{
			displayMother = disp;
		
			if(instance==null){
				instance= new IStart(new SingletonEnforcer());
			}else
				return ;
		}
		
		/**Access to instance if initialized*/
		public static  function getInstance():IStart{
			 
			if(displayMother == null){
				trace("Please initialize this class (IStart)");
				return null ;
			}else 
				return instance;
		}
		
		public function IStart(blocker:SingletonEnforcer) {
			//this class cannot be instantied from outside - 
			//AS do not suport private constructors
			if(displayMother is GeneralUIInterface ){
				this.setGeneralUI(displayMother as GeneralUIInterface);
			}
		}
		
		
	
		private var window:InteractivesSart=null;
		/**Crating custom pop up window*/
		public function openStart(message:String):void {
			//AWSMachine.getInstance().setState(new awStateInteractiveInit(AWSMachine.getInstance());
			
			if(window==null){
				window= new InteractivesSart();
				if(displayMother==null)trace("DIS IS NULLLLLLLL");
				PopUpManager.addPopUp(window,displayMother,true);
				PopUpManager.centerPopUp(window);
				window.wsTestReportArea.text+=message;
			    
			}
		}
		public function addMsgToStart(msg:String):void {
			if(window!=null){
				window.wsTestReportArea.text+=msg;
				
			}
		}
		public function stopStartGatheringinfo():void {
			if(window!=null){
				window.testWSPBar.setVisible(false);
				
			}
		}
		public function currencySetter():void {
				if(window!=null){
				window.curremcyLabel.enabled=true;
				window.currencyCents.enabled=true;
				window.currencyDecs.enabled= true;
				window.currencyLabelText.enabled=true;
				window.currencyDecs.value=1;
				window.currencySaveButton.enabled=true;
			}
		}
		public function openWindowImage(urlr:String,height:String,width:String,title:String):void {
			
				var window:ImageWindow = new ImageWindow();
				window.imageURL=urlr;
				window.windowTitle=title;
				window.windowHeight=height;
				window.windowWidth=width;
				
				
				if(displayMother==null)trace("DIS IS NULLLLLLLL");
				PopUpManager.addPopUp(window,displayMother,true);
				PopUpManager.centerPopUp(window);	
		}
		private var generalUIInterface:GeneralUIInterface= null;
		public function setGeneralUI(ui:GeneralUIInterface):void {
			this.generalUIInterface= ui;
		}
		public function showResultGrid():void {
			this.generalUIInterface.showResultGrid();
		}
		public function setBrowseResultsLabel(txt:String):void {
			this.generalUIInterface.setBrowseResultsLabel(txt);
		}
		public function openFloatingLoggerWindow():void {
			
			var window:FloatingLoggerWindow= new FloatingLoggerWindow();
			if(displayMother==null)trace("DIS IS NULLLLLLLL");
			PopUpManager.addPopUp(window,displayMother,true);
			PopUpManager.centerPopUp(window);	
			
		}
		
		
	
	}
}
class SingletonEnforcer{}