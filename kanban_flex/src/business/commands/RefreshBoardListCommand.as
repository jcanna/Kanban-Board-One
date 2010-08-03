package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.Board;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class RefreshBoardListCommand implements ICommand 
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		
	    public function execute(event:CairngormEvent):void
		{
			updateBoardList();
		}
		
		private function updateBoardList()
		{
			var board = new Board();
			board.addEventListener(ResultEvent.RESULT, newBoardListRetrievedHandler);
			board.find("all");
		}
		
		private function newBoardListRetrievedHandler(event:ResultEvent) {
			var boards:ArrayCollection = event.result as ArrayCollection;
			__model.boards = SortHelper.sortAlphaBy( boards, "name" );
			__model.statusMessages.addItemAt( "Board List Loaded",0 );

		}
	}
}