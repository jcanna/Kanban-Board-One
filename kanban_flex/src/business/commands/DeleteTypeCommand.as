package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Card;
	import models.Type;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;

	public class DeleteTypeCommand implements ICommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var type:Type;
		
		public function execute(event:CairngormEvent):void
		{
			type = event.eventType;
			if (deleteNotValid()) return;
			
			type.addEventListener(ResultEvent.RESULT, deleteTypeHandler);
			type.remove();
		}
		
		private function deleteTypeHandler(event:ResultEvent)
		{
			type.removeEventListener(ResultEvent.RESULT, deleteTypeHandler);
			for(var idx:uint = 0; idx < __model.currentBoardTypes.length; idx++)
			{
				if (__model.currentBoardTypes[idx].id == type.id)
	            {
					__model.currentBoardTypes.removeItemAt(idx);
					__model.statusMessages.addItemAt( "Type Deleted: " + type.name,0 );
					return;
	            }
			}
		}
		
		private function deleteNotValid():Boolean 
		{
			var cardsOfThisType:ArrayCollection = new ArrayCollection();
			
			var columns:ArrayCollection = __model.currentBoard.columns;
			for (var columnIndex:int = 0; columnIndex < columns.length; columnIndex++) 
			{
				var cards:ArrayCollection = columns[columnIndex].cards;
				for (var cardIndex:int = 0; cardIndex < cards.length; cardIndex++)
				{
					if (cards[cardIndex].type_id == type.id) {
						cardsOfThisType.addItem(cards[cardIndex]);
					}
				}
			}
			
			if (cardsOfThisType.length > 0)
			{
				var alertMessage:String = "Please change the following cards to a different type before deleting.\n\n";
				for (var cardIndex:int = 0; cardIndex < cardsOfThisType.length; cardIndex++)
				{
					alertMessage += (cardIndex+1).toString() + ". " + cardsOfThisType[cardIndex].name + "\n";
				}
				Alert.show(alertMessage);
				__model.statusMessages.addItemAt( "Type Not Deleted: " + type.name,0 );
				return true;
			}
			return false;

		}

	}
}