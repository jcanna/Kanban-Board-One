package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.ResetListHelper;
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.Tag;
	import models.User;
	
	import mx.rpc.events.ResultEvent;
	
	public class LoadUserProfileCommand implements ICommand 
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		var user:User;
		
	    public function execute(event:CairngormEvent):void
		{
			user = new User();
			user.addEventListener(ResultEvent.RESULT, userProfileHandler);
			user.find(event.id);
		}
		
		private function userProfileHandler(event:ResultEvent) {
			user.removeEventListener(ResultEvent.RESULT, userProfileHandler);
			__model.user = event.result;
			if (__model.user == null) return;
			
			__model.showTypeLegend = __model.user.show_type_legend == 'true';
			if (__model.user.boards != null)	{
				__model.userBoards = SortHelper.sortAlphaBy( __model.user.boards, "name" );
			} 
			if (__model.user.tags != null)	{
				setUserTagsToModel();
			} 
			__model.statusMessages.addItemAt( "User Profile " + __model.user.mud_id + " Loaded...",0 );
		}
		
		private function setUserTagsToModel():void
		{
			__model.user.tags = SortHelper.sortAlphaBy( __model.user.tags, "name" );
			__model.currentTag = findOldSelectedTagInNewList();
			__model.userTags = ResetListHelper.makeBlankEntryInUserTagList( __model.user.tags );
			
		}		

		private function findOldSelectedTagInNewList():Tag
		{
			if (__model.currentTag != null && __model.currentTag.hasOwnProperty("id")) {
				for  (var index = 0; index < __model.user.tags.length; index++) {
					if (__model.user.tags[index].id == __model.currentTag.id) {
						 //use global tag list because it has child cards attached already
						return useTagInGlobalList(__model.currentTag.id);
					}
				}
			}
			return null;
		}
		
		private function useTagInGlobalList(matchedId:int):Tag
		{
			for  (var index = 0; index < __model.tags.length; index++) {
				if (__model.tags[index].id == matchedId) {
					return __model.tags[index];
				}
			}
			return null;
		}
	}
}