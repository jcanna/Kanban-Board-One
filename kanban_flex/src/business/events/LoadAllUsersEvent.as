package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllUsersEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="loadAllUsersEvent";
		public function LoadAllUsersEvent()
		{
			super(EVENT_ID);
		}
		
	}
}