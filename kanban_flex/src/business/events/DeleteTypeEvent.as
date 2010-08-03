package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Type;

	public class DeleteTypeEvent extends CairngormEvent
	{
		public var eventType:Type;
		static public var EVENT_ID:String="DeleteTypeEvent";
		
		public function DeleteTypeEvent(type:Type)
		{
			super(EVENT_ID);
			this.eventType=type;
		}
		
	}
}