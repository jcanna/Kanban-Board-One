package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import models.Board;

	public class DeleteBoardEvent extends CairngormEvent
	{
		public var board:Board;
		static public var EVENT_ID:String="DeleteBoardEvent";
		
		public function DeleteBoardEvent(board:Board)
		{
			super(EVENT_ID);
			this.board = board;
		}
		
	}
}