package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import models.Column;

	public class DeleteColumnEvent extends CairngormEvent
	{
		public var column:Column;
		static public var EVENT_ID:String="DeleteColumnEvent";
		
		public function DeleteColumnEvent(column:Column)
		{
			super(EVENT_ID);
			this.column = column;
		}
		
	}
}