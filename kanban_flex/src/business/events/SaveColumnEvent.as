package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import models.Column;

	public class SaveColumnEvent extends CairngormEvent
	{
		static public var EVENT_ID:String="SaveColumnEvent";
		public var column:Column;
		
		public function SaveColumnEvent(column:Column)
		{
			super(EVENT_ID);
			this.column = column;
		}
		
	}
}