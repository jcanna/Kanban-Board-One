package business.commands
{
	import com.adobe.cairngorm.commands.ICommand; 
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Card;
	import models.Column;
	
	import mx.rpc.events.ResultEvent;

	public class AddCardCommand implements ICommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var card:Card;
		
		public function execute(event:CairngormEvent):void
		{
			card = event.card;
			card.addEventListener(ResultEvent.RESULT, newCardPersistedHandler);

			card.create();

		}
		
		private function newCardPersistedHandler(event:ResultEvent):void
		{
			for each (var column:Column in __model.currentBoard.columns)
			{
				if (column.id == card.column_id)
	            {
					column.cards.addItem(event.result)
					__model.statusMessages.addItemAt( "Added Card: " + event.result.name,0 );
	            }
			}
		}
		
	}
}