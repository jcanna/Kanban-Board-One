package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.User;
	
	import mx.collections.ArrayCollection;

	public class DeleteUserTagsEvent extends CairngormEvent
	{
		public var user:User;
		public var tags:ArrayCollection;
		
		static public var EVENT_ID:String="DeleteUserTagsEvent";
		
		public function DeleteUserTagsEvent(user:User, tags:ArrayCollection)
		{
			super(EVENT_ID);
			this.user = user;
			this.tags = tags;
		}
		
	}
}