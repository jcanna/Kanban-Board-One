package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class RefreshTagListEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="RefreshTagListEvent";
		public function RefreshTagListEvent()
		{
			super(EVENT_ID);
		}
	}
}
