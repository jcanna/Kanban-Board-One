package business.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import helpers.SortHelper;
	
	import model.ModelLocator;
	
	import models.Card;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class LoadAllCardsCommand implements ICommand 
	{
		var __model:ModelLocator=ModelLocator.getInstance();
		var card:Card;
		
	    public function execute(event:CairngormEvent):void
		{
			card = new Card();
			card.addEventListener(ResultEvent.RESULT, cardListHandler);
			card.find("all");
		}
		
		private function cardListHandler(event:ResultEvent) {
			card.removeEventListener(ResultEvent.RESULT, cardListHandler);
			var cards:ArrayCollection = event.result as ArrayCollection;
			__model.allCards = SortHelper.sortAlphaBy(cards, "name");
			__model.statusMessages.addItemAt( "All Parent Cards Refreshed...",0 );
		}
	}
}