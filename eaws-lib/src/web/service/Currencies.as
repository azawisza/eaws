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
package web.service
{	/**This class represents all supported currencies
 * based on http://www.nbp.pl/Kursy/KursyA.html
 * also provides current valus of those cureencies for system
 *  */
 import application.Conf;
 import application.IStart;
 
 import cmd.Invoker;
 import cmd.ui.cmd_WSFail;
 import cmd.ui.cmd_WSSuccess;
 
 import mx.logging.ILogger;
 import mx.logging.Log;
 import mx.rpc.events.FaultEvent;
 import mx.rpc.events.ResultEvent;
 import mx.rpc.http.HTTPService;
 
 import tools.HashMap;
 
	public class Currencies
	{
		
		public  static  var	PLN :String="PLN";//zloty
        public  static  var	USD :String="USD";//DOLAR
        public static  var	EUR :String="EUR";//euro
        public static  var THB :String="THB";//bat (Tajlandia)  	      
        public static  var	AUD :String="AUD";//For more please visit http://www.nbp.pl/Kursy/KursyA.html	      
        public static  var HKD :String="HKD";//	      
        public static  var	CAD	:String="CAD";//      
        public static  var NZD	:String="NZD";//      
        public static  var	SGD	:String="SGD";//      
        public static  var	HUF	:String="HUF";//      
        public static  var CHF	:String="CHF";//      
        public static  var GBP :String="GBP";//	      
        public static  var	UAH	:String="UAH";//      
        public static  var JPY	:String="JPY";//      
        public static  var CZK :String="CZK";//	      
        public static  var DKK	:String="DKK";//      
        public static  var EEK	:String="EEK";//      
        public static  var ISK	:String="ISK";//      
        public static  var NOK	:String="NOK";//      
        public static  var SKK	:String="SKK";//     
        public static  var SEK	:String="SEK";//      
        public static  var	HRK	:String="HRK";//     
        public static  var	RON	:String="RON";//      
        public static  var BGN	:String="BGN";//      
        public static  var TRY :String="TRY";//	      
        public static  var	LTL	:String="LTL";//      
        public static  var LVL	:String="LVL";//     
        public static  var PHP :String="PHP";//	      
        public static  var MXN	:String="MXN";//
        public static  var BRL	:String="BRL";//      
        public static  var MYR	:String="MYR";//      
        public static  var	RUB	:String="RUB";//     
        public static  var IDR	:String="IDR";//      
        public static  var KRW	:String="KRW";//  
        public static  var CNY	:String="CNY";//     
        public static  var	XDR	:String="XDR";//      
        
        private var NBP_URL:String = "www.nbp.pl/kursy/xml/";
        private var PROXY:String = "http://azbest.vdl.pl/proxy.php?url=";
        private var NBP_XML_DIRLIST_NAME = "dir.txt";
        private static var logger:ILogger = Log.getLogger("web.service.Currencies");
	    private var lastCheck:Date  = null;
	    private var currencyTable:HashMap= new HashMap(); 
	    
	    /**Obtaining $
	    * 
	    *<b>Useage</b><br>
	    * In orfder to use this class obtain it instance and call gerCurrencyRateInPLN(), it will work providing that 
	    * application is configured properly and there is access to nbp curremcies xml file.
	    * <b>Version History<b><br>
	    *    
	    * Version 0.1
	    * This class takes Conf currency value that is set on application init and returns its current value in PLN.
	    * Example. In Conf we set USD, so this class connects to NBP parses XML with current numbers, puts them in map and returns
	    * value to user. 
	    * This is testing version so at themoment user have to wait at the application start for currncies to be obtained 
	    * @todo Fix waiting for $ problem
	    *       implement getCurrencyRate(SOURCE:String,DESTINATION:String):Number 
	    *   
	    * 
	    * 
	    * */
	    private static var instance:Currencies ;
		public function Currencies(blocker:SingletonEnforcer) {
		
		}
		
		
		public static  function getInstance():Currencies{
		
			if(instance==null){
				instance= new Currencies(new SingletonEnforcer());
			}
				return instance;
		}//getinstance
        
        
        public  var fauilureValue:Number= 0.0;
        /**Should be called at the system load */
        public  function gerCurrencyRateInPLN():Number {
        	if(fauilureValue!=0.0){
        		return fauilureValue;
        	}
        	return getRate(Conf.getInstance().getCurrency());
        	
        }
        /**Not implementsed yet */
        public function getCurrencyRate(SOURCE:String,DESTINATION:String):Number {
        	var src:Number= new Number(SOURCE);
        	var dest:Number= new Number(DESTINATION);
        	return 0;
        }
        
        public  function getRate(CURRENCY:String):Number {
        	
        	if(checkFileList()){
        		//we have to do update ...
        		readFileList();
        	}else {
        		trace(CURRENCY);
        		trace("GMO "+this.currencyTable.getValue(CURRENCY));
        		return new Number(this.currencyTable.getValue(CURRENCY));
        	}
        	return 0;
        }
        /**Chaeck for last currency list check, if this check ws one day ago, it will perform it again*/
        private function checkFileList():Boolean {
        	if(lastCheck==null){
        		trace("CURENCY INIT: lsit was Never checked ");
        		
        		return true;
        	}else {
        		var currentdate:Date = new Date();
        		if(currentdate.day> lastCheck.day){
        			trace("CURENCY INIT: It is day since we lst checked $, e should do it again");
        			return true ;
        		}else {
        			trace("CURENCY INIT:  has been already checked today. ");
        			return false;
        		}
        	}
        }
        /**Load file name of XML with curencies.*/
        private function findFileWithCurrency(fileInhalt:String):String {
        	var names:Array = fileInhalt.split("\n");

        	var name:String = names[names.length-2];
        	name = name.replace("\n","");
        	return names[names.length-2];
        	
        }
        /**Obtain PRESENT xml with $*/
        private function getCurencies(fileName:String):void {
        	//http://www.nbp.pl/kursy/xml/a212z081029.xml
        	fileName = fileName.substring(0,fileName.length-1);
        	trace("buzz = "+fileName+"_");
        	
        	var path:String="http://azbest.vdl.pl/proxy.php?url="+"www.nbp.pl/kursy/xml/"+fileName;
        	path=path+".xml";        	
        	logger.info("get inhalt of file: >>"+"http://azbest.vdl.pl/proxy.php?url=www.nbp.pl/kursy/xml/b046z081112"+".xml");
        	
        	var service:HTTPService= new HTTPService();
        	service.url=path;
        	service.resultFormat="e4x";  
        	service.requestTimeout=30;  
        	service.addEventListener(ResultEvent.RESULT,this.resultHandlerCurrency);  
        	service.addEventListener(FaultEvent.FAULT,this.faultHandlerCurrency);
        	logger.info("Checking list of files with $ from "+service.url);  
        	service.send();  
        	
        	
        } 
        
        /**Parsing XML data from NBP*/
        private function readFileList():void {
        	//Security.allowDomain("www.nbp.pl");
        	//"http://nbp.pl/kursy/xml/"
        	var service:HTTPService= new HTTPService();
        	service.url=PROXY+NBP_URL+"/"+NBP_XML_DIRLIST_NAME; 
        	  
        	service.resultFormat="text";  
        	service.requestTimeout=30;  
        	service.addEventListener(ResultEvent.RESULT,this.resultHandler);  
        	service.addEventListener(FaultEvent.FAULT,this.faultHandler);
        	logger.info("CURENCY INIT: Checking list of files with $ from "+service.url);  
        	service.send();
        	  
        	
        }
        private function resultHandler(res:ResultEvent):void {
        	logger.info(" ... CURENCY INIT: Got list of files with $.");
        	var dirList:String = res.result as String;
       
        	getCurencies(findFileWithCurrency(dirList));
        }
        private function faultHandler(faul:FaultEvent):void {	
        	Conf.CUR=-1;
        	Invoker.getInstance().addCommand( new cmd_WSFail("Cannot obtin currency rates - xml dir listing error\n"+faul.toString()));
			Invoker.getInstance().invoke();
        }
        private function resultHandlerCurrency(res:ResultEvent):void {
        	logger.info("CURENCY INIT:  Got data  with $ course");
        
        	var list:XMLList = res.result.pozycja;

        	for(var i:int=0;i<list.length();i++){
        		
        		/*
        		   <pozycja>
    <nazwa_kraju>Zimbabwe</nazwa_kraju>
    <nazwa_waluty>dolar</nazwa_waluty>
    <przelicznik>1</przelicznik>
    <kod_waluty>ZWR</kod_waluty>
    <kurs_sredni>0,0051</kurs_sredni>
  </pozycja> 
        		 */
        		 var nazwa:String=list[i].kod_waluty ;
        		 var wartosc:String=list[i].kurs_sredni; 
        		wartosc=wartosc.replace(",",".");
        		 currencyTable.put(nazwa,wartosc);
        		 //ok we are obligatd to call here cmd_WSSuccess
        		 lastCheck=new Date();
        		
        	}
        	Conf.CUR=1;
			logger.info("CURRENCY WS  available");
			IStart.getInstance().setBrowseResultsLabel("nbp.pl available");
			Invoker.getInstance().addCommand( new cmd_WSSuccess());
			Invoker.getInstance().invoke();  
        }
        
        private function faultHandlerCurrency(faul:FaultEvent):void {
        	Conf.CUR=-1;
        	Invoker.getInstance().addCommand( new cmd_WSFail("Cannot obtin currency rates - XML parser error\n"+faul.toString()));
			Invoker.getInstance().invoke();
			
        	
        }
	}
}
class SingletonEnforcer{}