package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Card;
	
	import mx.rpc.events.ResultEvent;

	public class GetCardDetailsCommand implements ICommand
	{
		var card:Card;
		
		public function GetCardDetailsCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			card = event.card;
			card.addEventListener(ResultEvent.RESULT, updateCardDetailsHandler);
   			card.find(card.id);
		}
		
		private function updateCardDetailsHandler(event:ResultEvent)
		{
			card.removeEventListener(ResultEvent.RESULT, updateCardDetailsHandler);
			ModelLocator.getInstance().currentCardDetails = event.result;
		}
		
	}
}