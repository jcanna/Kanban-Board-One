package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadTagReportEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="loadTagReportEvent";
		public var id:int;
		public function LoadTagReportEvent(id:int = -1)
		{
			this.id = id;
			super(EVENT_ID);
		}
		
	}
}