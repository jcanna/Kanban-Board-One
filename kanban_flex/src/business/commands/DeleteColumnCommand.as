package business.commands
{
	import business.events.LoadBoardEvent;
	
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Column;
	
	import mx.rpc.events.ResultEvent;

	public class DeleteColumnCommand extends SequenceCommand
	{
		var column:Column;
		var __model:ModelLocator = ModelLocator.getInstance();
		
		public function DeleteColumnCommand()
		{
			super(new LoadBoardEvent());
		}
		
		public override function execute(event:CairngormEvent):void
		{
			column = event.column;
			column.addEventListener(ResultEvent.RESULT,deleteCommandHandler);
			column.remove();
		}
		
		private function deleteCommandHandler(event:ResultEvent)
		{
			column.removeEventListener(ResultEvent.RESULT, deleteCommandHandler);
			for (var idx:int; idx < __model.allColumns; idx++)
			{
				if (__model.allColumns[idx].id == column.id)
				{
					__model.allColumns.removeItemAt( idx );
				}
			}

			__model.statusMessages.addItemAt( "Column Deleted: " + column.name,0 );
			executeNextCommand();
		}
		
	}
}