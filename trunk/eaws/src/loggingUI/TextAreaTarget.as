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
package loggingUI
{
	//import application.TextAreaLogger;
	
	import application.TextAreaLoggerInterface;
	
	import mx.collections.ArrayCollection;
	import mx.controls.TextArea;
	import mx.logging.targets.LineFormattedTarget;
	
	
	public class TextAreaTarget extends LineFormattedTarget 
	{
		public  static var instance:TextAreaTarget= null;
		private var area:TextArea= null;
		private var areas:ArrayCollection= new ArrayCollection();
		
		namespace mx_internal="http://www.adobe.com/2006/flex/mx/internal";
		public function TextAreaTarget(area:TextArea)
		{
			super();
			this.area=area;
			instance=this;
			
			
		}
		
		 override mx_internal function internalLog(message:String):void
        {
        	if(area!=null){
        		trace("Invoked internalLog");
        		
        		//area.text=area.text.substr(0,area.text.length-2)+message+" from:"+this.filters+"\n";
        		area.text=area.text.substr(0,area.text.length-2)+message+"\n";
        		area.text+="\n\n";
        		
        		area.verticalScrollPosition=area.maxVerticalScrollPosition+10;
        		trace("baseline="+area.baselinePosition);
        		trace("scroll="+area.verticalScrollPosition);
        		trace("scroll="+area.maxVerticalScrollPosition+10);
        		//trace(message+" from:"+this.filters+",");
        	}
        }
        
        public function regitserNewTextArea(area:TextArea):void {
        	if(area is TextArea){
        		throw "This is not TextArea";	
        		return ;
        	}	
        }
        
        private var talis:ArrayCollection= new ArrayCollection();
        public function registerTextAreaLogger(tali:TextAreaLoggerInterface):void {
        	talis.addItem(tali);
        }
        public function removeTextAreaLogger(tali:TextAreaLoggerInterface):void {
        	talis.removeItemAt(talis.getItemIndex(tali));
        }
		
	}
}