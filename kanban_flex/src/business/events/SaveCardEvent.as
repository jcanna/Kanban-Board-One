package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Card;

	public class SaveCardEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="SaveCardEvent";
		public var card:Card;
		
		public function SaveCardEvent(card:Card)
		{
			super(EVENT_ID);
			this.card = card;
		}
		
	}
}