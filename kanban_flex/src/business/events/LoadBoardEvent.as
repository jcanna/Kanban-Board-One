package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadBoardEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="loadBoardEvent";
		public var id:int;
		public function LoadBoardEvent(id:int = -1)
		{
			this.id = id;
			super(EVENT_ID);
		}
		
	}
}