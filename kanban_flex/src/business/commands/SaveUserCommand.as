package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.ResetListHelper;
	
	import model.ModelLocator;
	
	import models.User;
	
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	
	public class SaveUserCommand implements ICommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var user:User;
		var isNew:Boolean = false;

		public function execute(event:CairngormEvent):void
		{
			user = event.user;
			isNew = user.id == null; 
			if (newUserNotValid()) return;

			user.addEventListener(ResultEvent.RESULT, userPersistedHandler);
			if (isNew) {
				user.create();
			} else {
				user.updateAction = 'updateProfile';
				user.save();
			}

		}
		
		private function userPersistedHandler(event:ResultEvent)
		{
			user.removeEventListener(ResultEvent.RESULT, userPersistedHandler);
			__model.statusMessages.addItemAt( "Added User: " + user.mud_id,0);
			if (isNew) {
				__model.users.addItem(event.result);
			} else {
				user = event.result;
				for(var idx:uint = 0; idx < __model.users.length; idx++)
				{
					if (__model.users[idx].id == user.id)
		            {
						__model.users[idx] = user;
						__model.user = user;
						__model.showTypeLegend = __model.user.show_type_legend == 'true';
						ResetListHelper.resetUserLists( __model.users );
						return;
		            }
				}
			}
		}

		private function newUserNotValid():Boolean 
		{
            if (user.mud_id.length == 0) {
            	Alert.show("Please add text for the user's mud id before saving.");
            	__model.statusMessages.addItemAt( "User Not Saved: " + user.mud_id,0 );
				return true;
            }
			if (isNew)
			{
				for each (var existingUser:User in __model.users)
				{
		            if (user.mud_id == existingUser.mud_id) {
		            	Alert.show("This user may already be in the system, as their mud id '" + user.mud_id + "' is not new.  Please add a unique mud id for this user before saving.");
		            	__model.statusMessages.addItemAt( "User Not Saved: " + user.mud_id,0 );
						return true;
		            }
				}
			}
			return false;
		}

	}
}