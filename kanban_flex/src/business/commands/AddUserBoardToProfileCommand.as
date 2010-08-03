package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	import helpers.SortHelper;
	
	import models.Board;
	import models.User;
	
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	
	public class AddUserBoardToProfileCommand implements ICommand
	{
		var user:User;
		var board:Board;
		
		public function AddUserBoardToProfileCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			user = event.user;
			board = event.board;
			if (isDuplicate()) return;
			
			user.addEventListener(ResultEvent.RESULT, userBoardAddedHandler);
			user.updateAction = "addBoard";
			user.board_id = board.id;
			user.save();
		}
		
		private function userBoardAddedHandler(event:ResultEvent)
		{
			user.removeEventListener(ResultEvent.RESULT, userBoardAddedHandler);
			user = event.result;
			ModelLocator.getInstance().user = user;
			ModelLocator.getInstance().userBoards = SortHelper.sortAlphaBy( user.boards, "name" );
		}

		private function isDuplicate():Boolean {
            if (!board.hasOwnProperty("id") || board.id < 1) {
            	Alert.show("Please select a board to add to the profile.");
				return true;
            }
			for  (var index = 0; index < user.boards.length; index++) {
				if (board.id == user.boards[index].id) {
	            	Alert.show("This board is already on the profile list.");
					return true;
				}	
			}
			return false;
		}
		
	}
}