package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllCardsEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="loadAllCardsEvent";
		public function LoadAllCardsEvent()
		{
			super(EVENT_ID);
		}
		
	}
}