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
	import mx.formatters.NumberFormatter;
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	import web.service.Currencies;
	
	/**main application configuration. this is java bean not data object*/
	public class Conf
	{
		
		
		private static var logger:ILogger = Log.getLogger("cmd.Conf");
	
	    private static var instance:Conf ;
		public function Conf(blocker:SingletonEnforcer) {
			//trace("Creating instance of Conf"); 
		}
		
		public static  function getInstance():Conf{
			//logger.info("Obtaining instance of Conf"); 
			if(instance==null){
				instance= new Conf(new SingletonEnforcer());
			}
				return instance;
		}//getinstance
		
		// 0 - not checked, 1 - OK working -1 not working
		public static var AMZ:int=0;
		public static var EBY:int=0;
		public static var CNE:int=0;
		public static var CUR:int=0;
		
		private var amazonWsdlUrl:String="";
		private var amazonKey:String="";
		private var eBayKey:String="";
		private var eBayWsdlUrl:String="";
		private var cnetKey:String="";
		private var amazonRestUrl:String = "";
		private var eBayRestURL = "";
		private var currency:String= Currencies.USD;
		public var  amzpage:int=0;//this is sbuject to change . 

			 	
		public var numberFormatter:NumberFormatter= new NumberFormatter();
		
		private var cnetWsdlUrl:String="";
		private var cnetRestUrl:String="";
		
		public function toString():String{
			return "amazonWsdlUrl=" + amazonWsdlUrl+"\n"+
					"amazonKey=" + amazonKey+"\n"+
					"eBayKey=" + eBayKey+"\n"+
					"eBayWsdlUrl=" + eBayWsdlUrl+"\n"+
					"cnetKey=" + cnetKey+"\n"+
					"cnetWsdlUrl=" + cnetWsdlUrl+"\n"+
					"cnetRestUrl=" + cnetRestUrl+"\n"+
					"currency=" + currency+"\n"+
					"cnetWsdlUrl=" + cnetWsdlUrl+"\n"+
					"cnetRestUrl=" + cnetRestUrl+"\n"+
					"";
		}
		
		public function setAmazonWsdlUrl(value:String):void {
			this.amazonWsdlUrl=value;
		}
		public function getAmazonWsdlUrl():String {
			return this.amazonWsdlUrl;
		}

		public function setAmazonKey(value:String):void {
			this.amazonKey=value;
		}
		public function getAmazonKey():String {
			return this.amazonKey;
		}		
		
		public function seteBayKey(value:String):void {
			this.eBayKey=value;
		}
		public function geteBayKey():String {
			return this.eBayKey;
		}
		
		public function seteBayWsdlUrl(value:String):void {
			this.eBayWsdlUrl=value;
		}
		public function geteBayWsdlUrl():String {
			return this.eBayWsdlUrl;
		}
		
		public function setCnetKey(value:String):void {
			this.cnetKey=value;
		}
		public function getCnetKey():String {
			return this.cnetKey;
		}		
		
		public function setCnetWsdlUrl(value:String):void {
			this.cnetWsdlUrl=value;
		}
		public function getCnetWsdlUrl():String {
			return this.cnetWsdlUrl;
		}
		public function setCnetRestUrl(value:String):void {
			this.cnetRestUrl=value;
		}
		public function getCnetRestUrl():String {
			return this.cnetRestUrl;
		}
		public function setAmazonRestUrl(value:String):void {
			this.amazonRestUrl=value;
		}
		public function getAmazonRestUrl():String {
			return this.amazonRestUrl;
		}
			public function seteBayRestURL(value:String):void {
			this.eBayRestURL=value;
		}
		public function geteBayRestURL():String {
			return this.eBayRestURL;
		}
		public function getCurrency():String{
			return this.currency;
		}
		public function setCurrency(currency:String):void{
			this.currency=currency;
		}

//http://webservices.amazon.com/onca/xml?Service=AWSECommerceService

	}
}
class MYBoolean {
	public var bool:Boolean= false ;
}
class SingletonEnforcer{}