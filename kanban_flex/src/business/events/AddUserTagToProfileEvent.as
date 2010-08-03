package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.Tag;
	import models.User;
	
	public class AddUserTagToProfileEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="AddUserTagToProfileEvent";
		public var user:User;
		public var tag:Tag;
		public function AddUserTagToProfileEvent(user:User, tag:Tag)
		{
			super(EVENT_ID);
			this.user = user;
			this.tag = tag;
		}
		
	}
}