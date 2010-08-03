package business.commands
{
	import business.events.LoadAllCardsEvent;
	
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Card;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;

	public class SaveCardCommand extends SequenceCommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var card:Card;
		var error:String = "";
		var notNew:Boolean = false;
		
		public function SaveCardCommand()
		{
			super();
		}
		
		public override function execute(event:CairngormEvent):void
		{
			card = event.card;
			error += newCardNotValid(card);
			error += parentNotSelfCheck(card);
			if (error.length > 0)			{
				var notSaved:String = "Card Not Saved: " + card.name;
            	Alert.show(error + notSaved);
				__model.statusMessages.addItemAt( notSaved,0 );
				return;
			} 

			notNew = card.hasOwnProperty("id");
			card.addEventListener(ResultEvent.RESULT, updateCompletedHandler);
			card.save();
		}
		
		private function updateCompletedHandler(event:ResultEvent)
		{
			card.removeEventListener(ResultEvent.RESULT, updateCompletedHandler);
			saveCardToAllCardsList();
/* 			nextEvent = new LoadAllCardsEvent();
			executeNextCommand();
 */			var columns:ArrayCollection = __model.currentBoard.columns;
			for(var colIndex:uint = 0; colIndex < columns.length; colIndex++)
			{
				for(var cardIndex:uint = 0; cardIndex < columns[colIndex].cards.length; cardIndex++)
				{
					if (columns[colIndex].cards[cardIndex].id == card.id)
					{
						updateModel(columns,colIndex,cardIndex);
						__model.statusMessages.addItemAt( "Card Saved: " + card.name,0 );
						return;
					}
				}
			}
		}

		// Just replace card if it is not moving columns or boards
		// otherwise remove the card from its current column
		// and add it to another column, unless it is moving to a new board		
		private function updateModel(columns:ArrayCollection, colIndex:uint, cardIndex:uint):void 
		{
			if ( columns[colIndex].id == card.column_id)
			{
				columns[colIndex].cards[cardIndex] = card;
			}
			else {
				columns[colIndex].cards.removeItemAt(cardIndex);
				for(var moveIndex:uint = 0; moveIndex < columns.length; moveIndex++)
				{
					if ( columns[moveIndex].id == card.column_id)
					{
						columns[moveIndex].cards.addItem(card);
					}
				}				
			}

		}

		public function saveCardToAllCardsList():void
		{
			if (card == null) return;
			if (notNew)
			{
				for(var idx:uint = 0; idx < __model.allCards.length; idx++)
				{
					if (__model.allCards[idx].id == card.id)
					{
						__model.allCards[idx] = card;
					}
				}
			} else {
				__model.allCards.addItem( card );
			}
		}

		public function newCardNotValid(card:Card):String {
			if (card.hasOwnProperty("name")) {
				if (card.name.length == 0) {
					return "Please add text for the card name before saving.\n";
	            }
			}
			return "";
		}
		
		public function parentNotSelfCheck(card:Card):String {
			if (card.hasOwnProperty("parent_id") && card.hasOwnProperty("id")) {
	            if (card.parent_id == card.id) {
					return "Please do not choose this card as its own parent.\n";
	            }
			}
			return "";
		}
	}
}