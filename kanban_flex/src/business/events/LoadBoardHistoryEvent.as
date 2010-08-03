package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadBoardHistoryEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="loadBoardHistoryEvent";
		public var id:int;
		public function LoadBoardHistoryEvent(id:int = -1)
		{
			this.id = id;
			super(EVENT_ID);
		}
		
	}
}