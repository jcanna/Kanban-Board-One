package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Board;
	import models.Card;

	public class ChangeBoardAndSaveCardEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="ChangeBoardAndSaveCardEvent";
		public var card:Card;
		public var board:Board;
		
		public function ChangeBoardAndSaveCardEvent(card:Card, board:Board)
		{
			super(EVENT_ID);
			this.card = card;
			this.board = board;
		}
		
	}
}