package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Board;
	import models.User;
	
	public class AddUserBoardToProfileEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="AddUserBoardToProfileEvent";
		public var user:User;
		public var board:Board;
		public function AddUserBoardToProfileEvent(user:User, board:Board)
		{
			super(EVENT_ID);
			this.user = user;
			this.board = board;
		}
		
	}
}