package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.DateHelper;
	
	import model.ModelLocator;
	
	import models.Board;
	import models.Card_History;
	import models.Column;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class LoadBoardHistoryCommand implements ICommand
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		var board:Board = new Board();
		
		private var earliestDay:Date = new Date();
		
		public function execute(event:CairngormEvent):void
		{
			var params:Object = new Object();
			params['history'] = "yes";
	   		board.addEventListener(ResultEvent.RESULT, boardRetrievedHandler);
			board.find(__model.currentBoard.id, params);
		}
		
		private function boardRetrievedHandler(event:ResultEvent)
		{
			board.removeEventListener(ResultEvent.RESULT, boardRetrievedHandler);
			board = event.result;
			var cardHistories:ArrayCollection = new ArrayCollection();
			if (board != null && board.columns.length > 0)
			{
				for each (var column:Column in board.columns)
				{
					calculatedHistory(column, cardHistories);
				}
			}			
			board.cardHistories = cardHistories;
			board.earliestDay = earliestDay;
			__model.currentBoardHistory = board;
		}

		private function calculatedHistory(column:Column,calculatedCardHistories:ArrayCollection):void
		{
			var cardHistories:ArrayCollection = column.card_histories;
			var calcColumnCardHistories:ArrayCollection = new ArrayCollection();
			var noMatches:ArrayCollection = new ArrayCollection();
			//Loop through the card history for this column
			for(var i:uint = 0; i < cardHistories.length; i++)
			{
				//Take the card history column entry 
				if (cardHistories[i].action = "entered")
				{
					var iEnter:Date = DateHelper.timestampToDate( cardHistories[i].created_at );
					if (iEnter != null)
					{
						if (iEnter.getTime() < this.earliestDay.getTime()) earliestDay = iEnter;
						var hasMatch = false;
						//Loop through the card history looking for when this card left the column
						var calcHistory:Card_History = cardHistories[i];
						calcHistory.entered = iEnter;
						for(var j:uint = 0; j < cardHistories.length; j++)
						{
							if (cardHistories[j].action = "left" &&
								cardHistories[j].card_id == cardHistories[i].card_id)
							{
								//Compare the entry and leaving times, and compute the difference
								var jLeft:Date = DateHelper.timestampToDate( cardHistories[j].created_at );
								if (jLeft != null && iEnter.getTime() < jLeft.getTime())
								{
									var timeDiff:Number = jLeft.getTime() - iEnter.getTime();
									var timeDiffInHours:Number = timeDiff / DateHelper.millisecondsPerHour;
									calcHistory.in_column_hours = timeDiffInHours;
									calcHistory.column_name = column.name;
									calcHistory.left = jLeft;
									calculatedCardHistories.addItem( calcHistory );
									calcColumnCardHistories.addItem( calcHistory );
									hasMatch = true;
									break;
								}
							}
						}
						if (!hasMatch) noMatches.addItem(calcHistory);
					}
				}
			}
			column.calculatedHistories = calcColumnCardHistories;
			column.noMatchHistories = noMatches;
		}

		
	}
}