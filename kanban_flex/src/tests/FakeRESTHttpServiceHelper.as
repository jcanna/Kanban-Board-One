package tests
{
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class FakeRESTHttpServiceHelper extends HTTPService 
	{
		public var resultOfSend;

		override public function send(params:Object = null):AsyncToken {
			dispatchEvent(ResultEvent.createEvent(resultOfSend));			
		}
	}
}