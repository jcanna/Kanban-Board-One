package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.Board;
	
	import mx.rpc.events.ResultEvent;

	public class LoadBoardCommand implements ICommand
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var board = new Board();
	   		board.addEventListener(ResultEvent.RESULT, boardRetrievedHandler);
	   		
			if (event.id == -1 && __model.currentBoard.hasOwnProperty("id"))
			{
				board.find(__model.currentBoard.id);
			}
			else if (event.id != -1)
			{
				board.find(event.id);
			}
		}
		
		private function boardRetrievedHandler(event:ResultEvent)
		{
			__model.currentBoard = event.result;
			if (__model.currentBoard.types != null)
			{
				__model.currentBoardTypes = SortHelper.sortAlphaBy( __model.currentBoard.types, "name" );
			} 
			__model.statusMessages.addItemAt( "Board Loaded: " + __model.currentBoard.name,0 );
		}
	}
}