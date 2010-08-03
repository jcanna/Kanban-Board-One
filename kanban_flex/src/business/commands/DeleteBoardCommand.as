package business.commands
{
	import business.events.RefreshBoardListEvent;
	
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Board;
	import models.Column;
	
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;

	public class DeleteBoardCommand extends SequenceCommand
	{
		var board:Board;
		
		public function DeleteBoardCommand()
		{
			super(new RefreshBoardListEvent());
		}
		
		public override function execute(event:CairngormEvent):void
		{
			board = event.board;
			if (boardIsNotValid())
			{
				ModelLocator.getInstance().statusMessages.addItemAt( "Board Not Deleted: " + board.name,0 );
				return;
			} 
			board.addEventListener(ResultEvent.RESULT,deleteCommandHandler);
			board.remove();
		}
		
		private function deleteCommandHandler(event:ResultEvent)
		{
			board.removeEventListener(ResultEvent.RESULT, deleteCommandHandler);
			ModelLocator.getInstance().currentBoard = new Board(); //reset board selector
			executeNextCommand();
			ModelLocator.getInstance().statusMessages.addItemAt( "Board Deleted: " + board.name,0 );
		}
		
		private function boardIsNotValid():Boolean
		{
			if (board == null || board.name == null)
			{
				Alert.show("Please select a board before attempting to delete it.");
				return true;
			}
			for each (var column:Column in board.columns)
			{
				if (column.cards != null && column.cards.length > 0)
				{
					Alert.show("Please move " + board.name + "'s cards before deleting.");				
					return true;
				}
			}
			return false;
		}
		
	}
}