package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Card;
	import models.Column;

	public class MoveCardEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="MoveCardEvent";
		public var movedCard:Card;
		public var toCard:Card;
		
		public function MoveCardEvent(movedCard:Card, toCard:Card)
		{
			super(EVENT_ID);
			this.movedCard = movedCard;
			this.toCard = toCard;
		}
		
	}
}