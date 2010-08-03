package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.*;

	public class SaveUserEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="SaveUserEvent";
		public var user:User;
		
		public function SaveUserEvent(user:User)
		{
			super(EVENT_ID);
			this.user = user;
		}
		
	}
}