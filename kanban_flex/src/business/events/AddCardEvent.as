package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent; 
	
	import models.Card;

	public class AddCardEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="AddCardEvent";
		public var card:Card;
		public function AddCardEvent( card:Card )
		{
			super(EVENT_ID);
			this.card = card;
		}
		
	}
}