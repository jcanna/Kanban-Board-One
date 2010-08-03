package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.Type;
	
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	
	public class SaveTypeCommand implements ICommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var type:Type;
		var isNew:Boolean = false;

		public function execute(event:CairngormEvent):void
		{
			type = event.cardType;
			if (newTypeNotValid()) return;

			type.addEventListener(ResultEvent.RESULT, typePersistedHandler);
			isNew = type.id == null; 
			if (isNew) {
				type.create();
			} else {
				type.save();
			}

		}
		
		private function typePersistedHandler(event:ResultEvent)
		{
			type.removeEventListener(ResultEvent.RESULT, typePersistedHandler);
			__model.statusMessages.addItemAt( "Added Board Type: " + type.name,0);
			if (isNew) {
				__model.currentBoardTypes.addItem(event.result);
			} else {
				type = event.result;
				for(var idx:uint = 0; idx < __model.currentBoardTypes.length; idx++)
				{
					if (__model.currentBoardTypes[idx].id == type.id)
		            {
						__model.currentBoardTypes[idx] = type;
						return;
		            }
				}
			}
		}

		private function newTypeNotValid():Boolean 
		{
            if (type.name.length == 0) {
            	Alert.show("Please add text for the type's name before saving.");
            	__model.statusMessages.addItemAt( "Type Not Saved: " + type.name,0 );
				return true;
            }
			if (isNew)
			{
				for each (var existingType:Type in ModelLocator.getInstance().currentBoardTypes)
				{
		            if (type.name == existingType.name) {
		            	Alert.show("Please add a unique name for this type before saving this new type.");
		            	__model.statusMessages.addItemAt( "Type Not Saved: " + type.name,0 );
						return true;
		            }
				}
			}
			return false;
		}

	}
}