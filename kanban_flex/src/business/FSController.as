package business
{
	import business.commands.AddCardCommand;
	import business.commands.AddCardTagCommand;
	import business.commands.AddUserBoardToProfileCommand;
	import business.commands.AddUserTagToProfileCommand;
	import business.commands.ChangeBoardAndSaveCardCommand;
	import business.commands.DeleteBoardCommand;
	import business.commands.DeleteCardCommand;
	import business.commands.DeleteCardTagCommand;
	import business.commands.DeleteColumnCommand;
	import business.commands.DeleteTypeCommand;
	import business.commands.DeleteUserBoardsCommand;
	import business.commands.DeleteUserCommand;
	import business.commands.DeleteUserTagsCommand;
	import business.commands.GetCardDetailsCommand;
	import business.commands.LoadAllCardsCommand;
	import business.commands.LoadAllColumnsCommand;
	import business.commands.LoadAllUsersCommand;
	import business.commands.LoadBoardCommand;
	import business.commands.LoadBoardHistoryCommand;
	import business.commands.LoadUserProfileCommand;
	import business.commands.MoveCardCommand;
	import business.commands.RefreshBoardListCommand;
	import business.commands.RefreshTagListCommand;
	import business.commands.SaveBoardCommand;
	import business.commands.SaveCardCommand;
	import business.commands.SaveColumnCommand;
	import business.commands.SaveTypeCommand;
	import business.commands.SaveUserCommand;
	import business.events.AddCardEvent;
	import business.events.AddCardTagEvent;
	import business.events.AddUserBoardToProfileEvent;
	import business.events.AddUserTagToProfileEvent;
	import business.events.ChangeBoardAndSaveCardEvent;
	import business.events.DeleteBoardEvent;
	import business.events.DeleteCardEvent;
	import business.events.DeleteCardTagEvent;
	import business.events.DeleteColumnEvent;
	import business.events.DeleteTypeEvent;
	import business.events.DeleteUserBoardsEvent;
	import business.events.DeleteUserEvent;
	import business.events.DeleteUserTagsEvent;
	import business.events.GetCardDetailsEvent;
	import business.events.LoadAllCardsEvent;
	import business.events.LoadAllColumnsEvent;
	import business.events.LoadAllUsersEvent;
	import business.events.LoadBoardEvent;
	import business.events.LoadBoardHistoryEvent;
	import business.events.LoadUserProfileEvent;
	import business.events.MoveCardEvent;
	import business.events.RefreshBoardListEvent;
	import business.events.RefreshTagListEvent;
	import business.events.SaveBoardEvent;
	import business.events.SaveCardEvent;
	import business.events.SaveColumnEvent;
	import business.events.SaveTypeEvent;
	import business.events.SaveUserEvent;
	
	import com.adobe.cairngorm.control.FrontController;

	public class FSController extends FrontController
	{
		public function FSController()
		{
			super();
			addCommand(AddCardEvent.EVENT_ID, AddCardCommand);
			addCommand(AddCardTagEvent.EVENT_ID, AddCardTagCommand);
			addCommand(AddUserBoardToProfileEvent.EVENT_ID, AddUserBoardToProfileCommand);
			addCommand(AddUserTagToProfileEvent.EVENT_ID, AddUserTagToProfileCommand);
			addCommand(ChangeBoardAndSaveCardEvent.EVENT_ID, ChangeBoardAndSaveCardCommand);
			addCommand(DeleteBoardEvent.EVENT_ID, DeleteBoardCommand);
			addCommand(DeleteCardEvent.EVENT_ID, DeleteCardCommand);
			addCommand(DeleteCardTagEvent.EVENT_ID, DeleteCardTagCommand);
			addCommand(DeleteColumnEvent.EVENT_ID, DeleteColumnCommand);
			addCommand(DeleteTypeEvent.EVENT_ID, DeleteTypeCommand);
			addCommand(DeleteUserEvent.EVENT_ID, DeleteUserCommand);
			addCommand(DeleteUserBoardsEvent.EVENT_ID, DeleteUserBoardsCommand);
			addCommand(DeleteUserTagsEvent.EVENT_ID, DeleteUserTagsCommand);
			addCommand(GetCardDetailsEvent.EVENT_ID, GetCardDetailsCommand);
			addCommand(LoadAllCardsEvent.EVENT_ID, LoadAllCardsCommand);
			addCommand(LoadAllColumnsEvent.EVENT_ID, LoadAllColumnsCommand);
			addCommand(LoadAllUsersEvent.EVENT_ID, LoadAllUsersCommand);
			addCommand(LoadBoardEvent.EVENT_ID, LoadBoardCommand);
			addCommand(LoadBoardHistoryEvent.EVENT_ID, LoadBoardHistoryCommand);
			addCommand(LoadUserProfileEvent.EVENT_ID, LoadUserProfileCommand);
			addCommand(RefreshBoardListEvent.EVENT_ID, RefreshBoardListCommand);
			addCommand(RefreshTagListEvent.EVENT_ID, RefreshTagListCommand);
			addCommand(SaveColumnEvent.EVENT_ID, SaveColumnCommand);
			addCommand(SaveCardEvent.EVENT_ID, SaveCardCommand);
			addCommand(SaveBoardEvent.EVENT_ID, SaveBoardCommand);
			addCommand(SaveTypeEvent.EVENT_ID, SaveTypeCommand);
			addCommand(SaveUserEvent.EVENT_ID, SaveUserCommand);
			addCommand(MoveCardEvent.EVENT_ID, MoveCardCommand);
		}
		
	}
}
