package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.User;

	public class DeleteUserEvent extends CairngormEvent
	{
		public var user:User;
		static public var EVENT_ID:String="DeleteUserEvent";
		
		public function DeleteUserEvent(user:User)
		{
			super(EVENT_ID);
			this.user=user;
		}
		
	}
}