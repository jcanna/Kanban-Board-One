package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Board;

	public class SaveBoardEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "SaveBoardEvent";

		// Creating a new board because we *only* want to capture the name for now.  The UI also captures
       // and owner and purpose, but those can't be saved down just yet.
		public var board:Board;
		
		public function SaveBoardEvent(board:Board)
		{
			super(EVENT_ID);
			this.board = board;
		}
		
	}
}