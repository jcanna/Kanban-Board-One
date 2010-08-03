package model
{
	import flash.events.EventDispatcher;
	
	import models.Board;
	import models.Card;
	import models.Column;
	import models.Tag;
	import models.Type;
	import models.User;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ModelLocator extends EventDispatcher
	{
		
		static private var __instance:ModelLocator=null;

		//Global entries
		public var statusMessages:ArrayCollection = new ArrayCollection();
		public var searchResults:ArrayCollection = new ArrayCollection();

		//Board entries
		public var boards:ArrayCollection = new ArrayCollection();
		public var currentBoard:Board = new Board();
		public var currentBoardTypes:ArrayCollection = new ArrayCollection();
		public var currentBoardHistory:Board = new Board();
		public var boardDetailViewStackIndex:int = 0;

		//User entries
		public var users:ArrayCollection = new ArrayCollection();
		public var ownerFilter:User = new User();
		public var user:User = new User();
		public var userBoards:ArrayCollection = new ArrayCollection();
		public var userTags:ArrayCollection = new ArrayCollection();

		//Tag entries			
		public var tags:ArrayCollection = new ArrayCollection();
		public var currentTag:Tag = new Tag();
		public var tagReport:Tag = new Tag();

		//Card Detail entries		
		public var allCards:ArrayCollection = new ArrayCollection();
		public var currentCardDetails:Card = new Card();
		public var currentCardDetailType:Type = new Type();
		public var currentCardDetailTypeIndex:Number = -1;
		public var currentCardDetailParent:Card = new Card();
		public var currentCardDetailParentIndex:Number = -1;
		public var currentCardDetailOwnerIndex:Number = -1;
		public var showCardDetailHierarchy:Boolean = false;
		public var cardDetailViewStackIndex = 0;

		//Column entries
		public var allColumns:ArrayCollection = new ArrayCollection();
		public var isColumnDragable:Boolean = false;

		//UI Related Preferences
		public var showTypeLegend:Boolean = false;



		static public function getInstance():ModelLocator
		{
			if (__instance == null)
			{
				__instance = new ModelLocator();
			}
			return __instance;
		}
		
		//If User Profile is loaded, we should use the userBoards instead of the entire board list
		public function selectedBoardIndex(board:Board, boardList:ArrayCollection)
		{
			return selectedIndex ( board, (userBoards == null || userBoards.length == 0)
				? boardList : userBoards );
		}	

		//Assume that we are using the User Tags list if it is not null
		public function selectedTagIndex(tag:Tag, tagList:ArrayCollection)
		{
			return selectedIndex ( tag, (userTags == null || userTags.length == 0)
				? tagList : userTags );
		}	

		public function selectedOwnerIndex( user:User, users:ArrayCollection ):int {
			return selectedIndex ( user, users );
		}

		public function selectedIndex(object:Object, objectList:ArrayCollection)
		{
			if (object != null && object.hasOwnProperty("id"))
			{
				for (var index:int; index < objectList.length; index++)
				{
					if (objectList[index].id == object.id)
					{
						return index;
					}
				}
			}	
			return -1;
		}	

		public function boardListWithBlankOption( boards:ArrayCollection ):ArrayCollection {
			if (boards[0].name == " ") return boards;
			var blankBoard:Board = new Board();
			blankBoard.name = " ";
			boards.addItemAt(blankBoard, 0);
			return boards;
		}

		public function allCardListWithBlankOption( cards:ArrayCollection ):ArrayCollection {
			if (cards[0].name == " ") return cards;
			var blankCard:Card = new Card();
			blankCard.name = " ";
			cards.addItemAt(blankCard, 0);
			return cards;
		}
		
		public function cardBoardSelected( card:Card, columns:ArrayCollection ):int {
			if (card == null || card.column_id == 0) {
				return 0;
			}
			for each (var column:Column in columns) {
				if (column.id == card.column_id) {
					for (var idx:int=0; idx < this.boards.length; idx++) {
						if (column.board_id == this.boards[idx].id) {
							return idx;
						}
					}
				}
			}
			return 0; //Just in case
		}
	
	}
}