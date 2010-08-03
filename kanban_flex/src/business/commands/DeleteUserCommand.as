package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	
	import models.User;
	
	import mx.rpc.events.ResultEvent;

	public class DeleteUserCommand implements ICommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var user:User;
		
		public function execute(event:CairngormEvent):void
		{
			user = event.user;

			user.addEventListener(ResultEvent.RESULT, deleteUserHandler);
			user.remove();
		}
		
		private function deleteUserHandler(event:ResultEvent)
		{
			user.removeEventListener(ResultEvent.RESULT, deleteUserHandler);
			for (var idx:uint=0; idx < __model.users.length; idx++)
			{
				if (__model.users[idx].id == user.id) __model.users.removeItemAt(idx);
			}
			__model.statusMessages.addItemAt( "Deleted User: " + user.mud_id,0 );
		}
		
	}
}