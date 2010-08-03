package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadAllColumnsEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="loadAllColumnsEvent";
		public function LoadAllColumnsEvent()
		{
			super(EVENT_ID);
		}
		
	}
}