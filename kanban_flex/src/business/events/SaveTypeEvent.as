package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Type;
	
	public class SaveTypeEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="SaveTypeEvent";
		public var cardType:Type;
		
		public function SaveTypeEvent(type:Type)
		{
			super(EVENT_ID);
			this.cardType = type;
		}
		
	}
}