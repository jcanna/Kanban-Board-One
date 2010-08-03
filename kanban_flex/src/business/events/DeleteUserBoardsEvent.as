package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.User;
	
	import mx.collections.ArrayCollection;

	public class DeleteUserBoardsEvent extends CairngormEvent
	{
		public var user:User;
		public var boards:ArrayCollection;
		
		static public var EVENT_ID:String="DeleteUserBoardsEvent";
		
		public function DeleteUserBoardsEvent(user:User, boards:ArrayCollection)
		{
			super(EVENT_ID);
			this.user = user;
			this.boards = boards;
		}
		
	}
}