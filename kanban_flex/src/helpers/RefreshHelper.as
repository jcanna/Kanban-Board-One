package helpers
{
	import business.events.LoadAllCardsEvent;
	import business.events.LoadAllColumnsEvent;
	import business.events.LoadAllUsersEvent;
	import business.events.RefreshBoardListEvent;
	import business.events.RefreshTagListEvent;
	
	import model.ModelLocator;
	
	public class RefreshHelper
	{
		public static function refreshEverything():void
		{
			var __model:ModelLocator = ModelLocator.getInstance();
			__model.statusMessages.addItemAt( "Loading boards...",0 );
			var event:RefreshBoardListEvent = new RefreshBoardListEvent();
			event.dispatch();
			__model.statusMessages.addItemAt( "Loading tags...",0 );
			var tagEvent:RefreshTagListEvent = new RefreshTagListEvent();
			tagEvent.dispatch();
			__model.statusMessages.addItemAt( "Loading users...",0 );
			var userEvent:LoadAllUsersEvent = new LoadAllUsersEvent();
			userEvent.dispatch();
			__model.statusMessages.addItemAt( "Loading Parent cards...",0 );
			var loadAllCardsEvent:LoadAllCardsEvent = new LoadAllCardsEvent();
			loadAllCardsEvent.dispatch();
			__model.statusMessages.addItemAt( "Loading Columns...",0 );
			var loadAllColumnsEvent:LoadAllColumnsEvent = new LoadAllColumnsEvent();
			loadAllColumnsEvent.dispatch();
		}		
	}


}