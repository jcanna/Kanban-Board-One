package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.User;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class DeleteUserBoardsCommand implements ICommand
	{
		var user:User;
		var boards:ArrayCollection;
		var board_ids:ArrayCollection = new ArrayCollection();
		
		public function DeleteUserBoardsCommand()
		{
			super();
		}

		public function execute(event:CairngormEvent):void
		{
			user = event.user;
			boards = event.boards;

			if (isNotValid()) return;
			user.addEventListener(ResultEvent.RESULT, deleteUserBoardsHandler);
			user.updateAction = "removeBoards";

			for (var x:uint=0; x < boards.length; x++)
			{
				board_ids.addItem(boards[x].id);
			}						
			user.board_ids = board_ids;
			user.save();
		}
		
		private function deleteUserBoardsHandler(event:ResultEvent)
		{
			user.removeEventListener(ResultEvent.RESULT, deleteUserBoardsHandler);
			user = event.result;
			ModelLocator.getInstance().user = user;
			ModelLocator.getInstance().userBoards = SortHelper.sortAlphaBy( user.boards, "name" );
		}

		private function isNotValid():Boolean
		{
            if (this.boards == null || this.boards.length == 0)
            {
            	Alert.show("Please select at least one board to remove from the profile.");
				return true;
            }
			return false;
		}	
			
	}
}