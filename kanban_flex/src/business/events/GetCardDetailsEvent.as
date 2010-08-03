package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Card;
	
	import views.CardDetail;

	public class GetCardDetailsEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="GetCardDetailsEvent";
		public var card:Card;
		public function GetCardDetailsEvent(card:Card)
		{
			super(EVENT_ID);
			this.card = card;
		}
		
	}
}