package helpers
{
	import model.ModelLocator;
	
	import models.Tag;
	import models.User;
	
	import mx.collections.ArrayCollection;
	
	public class ResetListHelper
	{
		
		public static function makeBlankEntryInUserTagList(trueList:ArrayCollection):ArrayCollection
		{
			var modifiedList:ArrayCollection = new ArrayCollection();
			for each (var tag:Tag in trueList)
				modifiedList.addItem( tag );
			var noneTag:Tag = new Tag();
			noneTag.id = 0;
			noneTag.name = " ";
			if (modifiedList.length > 0) modifiedList.addItemAt(noneTag,0);
			return modifiedList;
		}		

		public static function resetUserLists(users:ArrayCollection):void
		{
			var newUsers:ArrayCollection = SortHelper.sortAlphaBy(users, "mud_id");
			if (newUsers.length > 0 && newUsers[0].id > 0) {
				var noneUser:User = new User();
				noneUser.id = 0;
				noneUser.mud_id = noneUser.first_name = noneUser.last_name = " ";
				if (newUsers.length > 0) newUsers.addItemAt(noneUser,0);
			}

			// find selected Owner in new List
			var oldSelectedOwner:User = null;
			if (ModelLocator.getInstance().ownerFilter != null && ModelLocator.getInstance().ownerFilter.hasOwnProperty("id")) {
				for  (var index = 1; index < newUsers.length; index++) {
					if (newUsers[index].id == ModelLocator.getInstance().ownerFilter.id) {
						oldSelectedOwner = newUsers[index];
					}
				}
			}
			ModelLocator.getInstance().ownerFilter = oldSelectedOwner;			

			// find selected User in new List
			var oldSelectedUser:User = null;
			if (ModelLocator.getInstance().user != null && ModelLocator.getInstance().user.hasOwnProperty("id")) {
				for  (var index = 1; index < newUsers.length; index++) {
					if (newUsers[index].id == ModelLocator.getInstance().user.id) {
						oldSelectedUser = newUsers[index];
					}
				}
			}
			ModelLocator.getInstance().user = oldSelectedUser;			

			ModelLocator.getInstance().users = newUsers;
		}
	}
}