package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Card;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class DeleteCardCommand implements ICommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var card:Card;
		
		public function execute(event:CairngormEvent):void
		{
			card = event.card;
			
			card.addEventListener(ResultEvent.RESULT, deleteCardHandler);
			card.remove();
		}
		
		private function deleteCardHandler(event:ResultEvent)
		{
			var columns:ArrayCollection = __model.currentBoard.columns;
			for (var columnIndex:int = 0; columnIndex < columns.length; columnIndex++) 
			{
				var cards:ArrayCollection = columns[columnIndex].cards;
				for (var cardIndex:int = 0; cardIndex < cards.length; cardIndex++)
				{
					if (cards[cardIndex].id == card.id) {
						cards.removeItemAt(cardIndex);
					}
				}
			}
			card.removeEventListener(ResultEvent.RESULT, deleteCardHandler);
			__model.statusMessages.addItemAt( "Card Deleted: " + card.name,0 );
		}
		
	}
}