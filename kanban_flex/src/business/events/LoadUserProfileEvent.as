package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoadUserProfileEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="loadUserProfileEvent";
		public var id;
		public function LoadUserProfileEvent(id)
		{
			this.id = id;
			super(EVENT_ID);
		}
		
	}
}