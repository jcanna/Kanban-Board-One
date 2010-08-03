package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.CardHistoryCalculator;
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.Board;
	import models.Card;
	import models.Card_History;
	import models.Column;
	import models.Tag;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class LoadTagReportCommand implements ICommand
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		var tag:Tag = new Tag();
		var tagHistories:ArrayCollection = new ArrayCollection();
		var earliestDay:Date = new Date();		
		var latestDay:Date = new Date();		

		public function execute(event:CairngormEvent):void
		{
			var params:Object = new Object();
			params['history'] = "yes";
			tag = __model.currentTag;
	   		tag.addEventListener(ResultEvent.RESULT, tagRetrievedHandler);
			tag.find(__model.currentTag.id, params);
		}
		
		private function tagRetrievedHandler(event:ResultEvent)
		{
			tag.removeEventListener(ResultEvent.RESULT, tagRetrievedHandler);
			tag = event.result;
			
			calculateCardHistories();
			
			sortAndSaveRawCalculatedHistories();
			
			tag.boards = organizeHistoriesIntoColumnsAndBoards();

			__model.tagReport = tag;
		}

		private function calculateCardHistories():void
		{
			if (tag != null && tag.cards.length > 0)
			{
				for each (var card:Card in tag.cards)
				{
					var historyCalculator:CardHistoryCalculator = 
						new CardHistoryCalculator( card.card_histories, null, card.name, earliestDay );

					if (earliestDay.getTime() > historyCalculator.earliestDay) 
						earliestDay = historyCalculator.earliestDay;

					addRawHistories( historyCalculator.calcCardHistories );
				}
			}
		}
		
		public function addRawHistories( newCalculatedCardHistories:ArrayCollection ):void
		{
			for each (var calcCardHistory:Card_History in newCalculatedCardHistories)
			{
				tagHistories.addItem( calcCardHistory );
			}
		}
		
		public function sortAndSaveRawCalculatedHistories():void
		{
			if (tagHistories.length > 0)
			{
				SortHelper.sortNumerics(tagHistories, "board_id", "column_id");
				tag.tagRawHistories = tagHistories;
			}
		}
		
		public function organizeHistoriesIntoColumnsAndBoards():ArrayCollection
		{
			if (tagHistories.length < 1) return;
			
			var calculatedBoards:ArrayCollection = new ArrayCollection();
			var tmpBoardId:int = tagHistories[0].board_id;
			var tmpBoard:Board = new Board();
			var tmpColumnId:int = tagHistories[0].column_id;
			var tmpColumns:ArrayCollection = new ArrayCollection();
			var tmpHistories:ArrayCollection = new ArrayCollection();
			for each (var cardHistory:Card_History in tagHistories) {
				if (cardHistory.column_id != tmpColumnId) {
					tmpColumns.addItem( addAccumulationColumn( tmpHistories ) );

					if (cardHistory.board_id != tmpBoardId) {
						calculatedBoards.addItem( addAccumulationBoard( tmpColumns ) );
						tmpColumns = new ArrayCollection();
						tmpBoardId = cardHistory.board_id;
					}
					tmpHistories = new ArrayCollection();
					tmpColumnId = cardHistory.column_id;
				}
				tmpHistories.addItem( cardHistory );
			}
			tmpColumns.addItem( addAccumulationColumn( tmpHistories ) );
			calculatedBoards.addItem( addAccumulationBoard( tmpColumns ) );
			return calculatedBoards;
		}
		
		public function addAccumulationColumn( histories:ArrayCollection ):Column
		{
			var col:Column = new Column();
			col = new Column();
			col.name = histories[0].column_name;
			col.position = histories[0].column_position;
			col.calculatedHistories = histories;
			return col;
		}

		public function addAccumulationBoard( columns:ArrayCollection ):Board
		{
			var accumulatedBoard = new Board();
			accumulatedBoard.earliestDay = this.earliestDay;
			accumulatedBoard.latestDay = this.latestDay;
			accumulatedBoard.columns = columns;
			return accumulatedBoard;			
		}


	}

}