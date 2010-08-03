package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.Tag;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class RefreshTagListCommand implements ICommand 
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		var tag:Tag;
		
	    public function execute(event:CairngormEvent):void
		{
			tag = new Tag();
			tag.addEventListener(ResultEvent.RESULT, newTagListRetrievedHandler);
			tag.find("all");
		}
		
		private function newTagListRetrievedHandler(event:ResultEvent) {
			tag.removeEventListener(ResultEvent.RESULT, newTagListRetrievedHandler);

			var newTagList:ArrayCollection = event.result as ArrayCollection;
			if (newTagList == null) return;
			newTagList = SortHelper.sortAlphaBy(newTagList,"name");
			var noneTag:Tag = new Tag();
			noneTag.id = 0;
			noneTag.name = " ";
			if (newTagList.length > 0) newTagList.addItemAt(noneTag,0);

			// find selected Tag in new List
			var oldSelectedTag:Tag = null;
			if (__model.currentTag != null && __model.currentTag.hasOwnProperty("id")) {
				for  (var index = 1; index < newTagList.length; index++) {
					if (newTagList[index].id == __model.currentTag.id) {
						oldSelectedTag = newTagList[index];
					}
				}
			}
			__model.tags = newTagList;
			__model.currentTag = oldSelectedTag;
			__model.selectedTagIndex(__model.currentTag, __model.userTags == null ? __model.tags : __model.userTags);
			__model.statusMessages.addItemAt( "Global Tag List Refreshed...",0 );
		}
	}
}