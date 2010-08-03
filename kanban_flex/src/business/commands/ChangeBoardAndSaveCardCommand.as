package business.commands
{
	import business.events.SaveCardEvent;
	
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Board;
	import models.Card;
	import models.Type;
	
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;

	public class ChangeBoardAndSaveCardCommand extends SequenceCommand
	{
		var card:Card;
		var board:Board;
		
		public function ChangeBoardAndSaveCardCommand()
		{
			super();
		}
		
		public override function execute(event:CairngormEvent):void
		{
			card = event.card;
			var board = event.board;
			if (board.hasOwnProperty("id")) {
	   			board.addEventListener(ResultEvent.RESULT, boardRetrievedHandler);
	   			board.find(board.id);
			} else {
				card.column_id = 0;
				nextEvent = new SaveCardEvent(card);
				executeNextCommand();
			}
		}
		
		private function boardRetrievedHandler(event:ResultEvent)
		{
			board = event.result;
			board.removeEventListener(ResultEvent.RESULT, boardRetrievedHandler);
			if (noColumnsInBoard()) return;

			card.column_id = board.columns[0].id;
			attemptToMatchCardType();

			if (noCardsInColumn(board.columns[0]))
				card.position = 1;
			else
				card.position = board.columns[0].cards.length + 1;
				
			nextEvent = new SaveCardEvent(card);
			executeNextCommand();
		}

		private function noColumnsInBoard():Boolean
		{
			if (board.columns.length == 0)
			{
            	Alert.show("There are no columns in the selected board, please either add columns to that board or select a different board.");
				ModelLocator.getInstance().statusMessages.addItemAt( "Card '" + card.name + "' Not Saved.",0 );
				return true;
            }
			return false;
		}
		
		private function noCardsInColumn(column) {
			if (column.cards == null)
				return true;
			
			if (column.cards.length == 0)
				return true;
				
			return false;
		}		

		private function attemptToMatchCardType():void
		{
			if (!card.hasOwnProperty("type_id") || card.type_id < 1) return;
			for each (var type:Type in ModelLocator.getInstance().currentBoardTypes)
			{
				if (type.id == card.type_id)
				{
					for each (var newBoardType:Type in board.types)
					{
						if (type.name == newBoardType.name)
						{
							card.type_id = newBoardType.id;
							return;
						}
					}
				}
			}
		}
	}
}