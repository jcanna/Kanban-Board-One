package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.ResetListHelper;
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.Tag;
	import models.User;
	
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	
	public class AddUserTagToProfileCommand implements ICommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var user:User;
		var tag:Tag;
		
		public function AddUserTagToProfileCommand()
		{
			super();
		}
		
		public function execute(event:CairngormEvent):void
		{
			user = event.user;
			tag = event.tag;
			if (isDuplicate()) return;
			
			user.addEventListener(ResultEvent.RESULT, userTagAddedHandler);
			user.updateAction = "addTag";
			user.tag_id = tag.id;
			user.save();
		}
		
		private function userTagAddedHandler(event:ResultEvent)
		{
			user.removeEventListener(ResultEvent.RESULT, userTagAddedHandler);
			user = event.result;
			__model.user = user;
			__model.user.tags = SortHelper.sortAlphaBy( __model.user.tags, "name" );
			__model.userTags = ResetListHelper.makeBlankEntryInUserTagList( __model.user.tags );
		}

		private function isDuplicate():Boolean {
            if (!tag.hasOwnProperty("id") || tag.id < 1) {
            	Alert.show("Please select a tag to add to the profile.");
				return true;
            }
			for  (var index = 0; index < user.tags.length; index++) {
				if (tag.id == user.tags[index].id) {
	            	Alert.show("This tag is already on the profile list.");
					return true;
				}	
			}
			return false;
		}
		
	}
}