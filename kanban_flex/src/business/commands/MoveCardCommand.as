package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Card;
	import models.Column;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class MoveCardCommand implements ICommand
	{
		private var movedCard:Card;
		private var movedToCard:Card;
		private var originalMovedCardColumnID:int;
		

		public function execute(event:CairngormEvent):void
		{
			movedCard = event.movedCard;
			movedToCard = event.toCard;				
			originalMovedCardColumnID = movedCard.column_id;
			
			movedCard.column_id = movedToCard.column_id;
			var movedToPosition = findColumn(movedToCard.column_id).cards.getItemIndex(movedToCard) + 1; // rails uses 1 based positions
			movedCard.position = movedToPosition;
			
			movedCard.addEventListener(ResultEvent.RESULT, updateCompletedHandler);
			movedCard.save();
		}
		
		private function updateCompletedHandler(event:ResultEvent) {
			movedCard.removeEventListener(ResultEvent.RESULT, updateCompletedHandler);
			
			var movedToCards:ArrayCollection = findColumn(movedToCard.column_id).cards;
			var originalColumnCards:ArrayCollection = findColumn(originalMovedCardColumnID).cards;
			
			originalColumnCards.removeItemAt(originalColumnCards.getItemIndex(movedCard));
			movedToCards.addItemAt(movedCard, movedToCards.getItemIndex(movedToCard));
		}
		
		private function findColumn(columnID:int):Column {
			var columns:ArrayCollection = ModelLocator.getInstance().currentBoard.columns;
			var inx:int = 0;
			var column:Column;
			while (inx < columns.length) {
				if (columns[inx].id == columnID) {
					column = columns[inx]
					break;
				}
				inx++;
			}
			
			return column;
			
		}
	}
}