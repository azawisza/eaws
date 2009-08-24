package web
{
	public interface WebServiceSubject
	{
		  function regsiterWebServiceListener(listener:WebServiceListener):void;
		  function removeWebServiceListener(listener:WebServiceListener):void;
		  function getState():Object;
		  function notifyListeners():void;
	}
}