package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.ResetListHelper;
	
	import model.ModelLocator;
	
	import models.User;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class LoadAllUsersCommand implements ICommand 
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		var user:User;
		
	    public function execute(event:CairngormEvent):void
		{
			user = new User();
			user.addEventListener(ResultEvent.RESULT, userListHandler);
			user.find("all");
		}
		
		private function userListHandler(event:ResultEvent) {
			user.removeEventListener(ResultEvent.RESULT, userListHandler);
			var users:ArrayCollection = event.result as ArrayCollection;
			if (users == null) return;
			ResetListHelper.resetUserLists( users );

			__model.statusMessages.addItemAt( "All Users Refreshed...",0 );
		}
	}
}