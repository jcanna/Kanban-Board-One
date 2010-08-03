package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Card;
	import models.Tag;
	
	public class AddCardTagEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="AddCardTagEvent";
		public var card:Card;
		public var tag:Tag;
		public function AddCardTagEvent(card:Card, tagName:String)
		{
			super(EVENT_ID);
			this.card = card;
			this.tag = new Tag();
			this.tag.card_id = card.id;
			this.tag.name = tagName;
		}
		
	}
}