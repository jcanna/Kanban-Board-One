package business.commands
{
	import business.events.LoadBoardEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Board;
	
	import mx.rpc.events.ResultEvent;

	public class SaveBoardCommand implements ICommand
	{

		private var isNew:Boolean = false;		
		private var __model:ModelLocator = ModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var board = event.board;
			board.addEventListener(ResultEvent.RESULT, boardPersistedHandler);
			if (board.id == null) {
				isNew = true;
				board.create();
			} else {
				board.save();
			}
		}
		
		private function boardPersistedHandler(event:ResultEvent)
		{
			var newBoard:Board = event.result;
			if ( isNew ) __model.boards.addItem( newBoard )
			else {
				for(var i:uint = 0; i < __model.boards.length; i++) {
					if (__model.boards[i].id == newBoard.id) {
						__model.boards.setItemAt( newBoard, i );
					}
				}
			}
			__model.statusMessages.addItemAt("Board Saved: " + newBoard.name,0);
 			var newEvent:LoadBoardEvent = new LoadBoardEvent(newBoard.id);
			newEvent.dispatch();
		}
		
	}
}