package business.commands
{
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import business.events.GetCardDetailsEvent;
	import business.events.RefreshTagListEvent;
	
	import model.ModelLocator;
	import models.Card;
	import models.Tag;
	
	import mx.rpc.events.ResultEvent;

	public class DeleteCardTagCommand  extends SequenceCommand
	{
		var card:Card;
		var tag:Tag;
		
		public function DeleteCardTagCommand()
		{
			super();
		}

		public override function execute(event:CairngormEvent):void
		{
			card = event.card;
			tag = event.tag;

			tag.addEventListener(ResultEvent.RESULT, deleteCardTagHandler);
			tag.remove();
		}
		
		private function deleteCardTagHandler(event:ResultEvent)
		{
			tag.removeEventListener(ResultEvent.RESULT, deleteCardTagHandler);
			for  (var index = 0; index < card.tags.length; index++) {
				if (card.tags[index].id == tag.id) {
					card.tags.removeItemAt(index);
				}			
			}
			ModelLocator.getInstance().currentCardDetails = card;
			ModelLocator.getInstance().statusMessages.addItemAt( "Deleted Tag '" + tag.name + "' on Card",0 );
			nextEvent = new RefreshTagListEvent();
			executeNextCommand();
		}
		
	}
}