package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.Column;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class LoadAllColumnsCommand implements ICommand 
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		var column:Column;
		
	    public function execute(event:CairngormEvent):void
		{
			column = new Column();
			column.addEventListener(ResultEvent.RESULT, columnListHandler);
			column.find("all");
		}
		
		private function columnListHandler(event:ResultEvent) {
			column.removeEventListener(ResultEvent.RESULT, columnListHandler);
			var columns:ArrayCollection = event.result as ArrayCollection;
			__model.allColumns = SortHelper.sortAlphaBy(columns, "name");
			__model.statusMessages.addItemAt( "All Columns Refreshed...",0 );
		}
	}
}