package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.ResetListHelper;
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.User;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class DeleteUserTagsCommand implements ICommand
	{
		var __model:ModelLocator = ModelLocator.getInstance();
		var user:User;
		var tags:ArrayCollection;
		var tag_ids:ArrayCollection = new ArrayCollection();
		
		public function DeleteUserTagsCommand()
		{
			super();
		}

		public function execute(event:CairngormEvent):void
		{
			user = event.user;
			tags = event.tags;

			if (isNotValid()) return;
			user.addEventListener(ResultEvent.RESULT, deleteUserTagsHandler);
			user.updateAction = "removeTags";

			for (var x:uint=0; x < tags.length; x++)
			{
				tag_ids.addItem(tags[x].id);
			}
			user.tag_ids = tag_ids;
			user.save();
		}
		
		private function deleteUserTagsHandler(event:ResultEvent)
		{
			user.removeEventListener(ResultEvent.RESULT, deleteUserTagsHandler);
			user = event.result;
			__model.user = user;
			__model.user.tags = SortHelper.sortAlphaBy( __model.user.tags, "name" );
			__model.userTags = ResetListHelper.makeBlankEntryInUserTagList( __model.user.tags );
			checkIfOldTagStillExists();
		}

		private function checkIfOldTagStillExists():void
		{
			if (__model.currentTag == null) return;
			for  (var index = 0; index < __model.user.tags.length; index++) {
				if (__model.currentTag.id == __model.user.tags[index].id) {
					return;
				}	
			}
			__model.currentTag = null; //If it got this far, old tag is not in new list
		}

		private function isNotValid():Boolean
		{
            if (this.tags == null || this.tags.length == 0)
            {
            	Alert.show("Please select at least one Tag to remove from the profile.");
				return true;
            }
			return false;
		}	
			
	}
}