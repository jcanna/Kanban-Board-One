package business.commands
{
	import business.events.LoadBoardEvent;
	
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Column;
	
	import mx.rpc.events.ResultEvent;

	public class SaveColumnCommand extends SequenceCommand
	{
		var column:Column;
		var isNew:Boolean;
		var __model:ModelLocator = ModelLocator.getInstance();
				
		public function SaveColumnCommand()
		{
			super(new LoadBoardEvent());
		}
		
		public override function execute(event:CairngormEvent):void
		{
			column = event.column;
			column.addEventListener(ResultEvent.RESULT, updateCompletedHandler);
			isNew = !column.hasOwnProperty("id") || (column.id == -1)
			
			isNew ? column.create() : column.save();
		}
		
		private function updateCompletedHandler(event:ResultEvent)
		{
			column.removeEventListener(ResultEvent.RESULT, updateCompletedHandler);
			if (isNew)
			{
				__model.allColumns.addItem(column);
			} else {
				for (var idx:int; idx < __model.allColumns.length; idx++)
				{
					if (__model.allColumns[idx].id == column.id)
					{
						__model.allColumns.setItemAt( column, idx );
					}
				}
			}

           	__model.statusMessages.addItemAt( "Saved Column: " + column.name,0 );
			executeNextCommand();
		}
		
	}
}