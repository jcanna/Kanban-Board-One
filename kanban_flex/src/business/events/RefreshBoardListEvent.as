package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class RefreshBoardListEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="refreshBoardListEvent";
		public function RefreshBoardListEvent()
		{
			super(EVENT_ID);
		}
	}
}
