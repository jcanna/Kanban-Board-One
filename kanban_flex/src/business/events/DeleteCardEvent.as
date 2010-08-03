package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Card;

	public class DeleteCardEvent extends CairngormEvent
	{
		public var card:Card;
		static public var EVENT_ID:String="DeleteCardEvent";
		
		public function DeleteCardEvent(card:Card)
		{
			super(EVENT_ID);
			this.card=card;
		}
		
	}
}