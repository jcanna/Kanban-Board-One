package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Card;
	import models.Tag;
	
	import views.CardDetail;

	public class DeleteCardTagEvent extends CairngormEvent
	{
		public var card:Card;
		public var tag:Tag = new Tag();
		static public var EVENT_ID:String="DeleteCardTagEvent";
		
		public function DeleteCardTagEvent(card:Card,tag:Tag)
		{
			super(EVENT_ID);
			this.card=card;
			this.tag.id = tag.id;
			this.tag.card_id = card.id;
		}
		
	}
}