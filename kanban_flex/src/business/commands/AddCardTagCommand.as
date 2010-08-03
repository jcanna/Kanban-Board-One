package business.commands
{
	import business.events.GetCardDetailsEvent;
	import business.events.RefreshTagListEvent;
	
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import model.ModelLocator;
	import models.Tag;
	
	import mx.rpc.events.ResultEvent;
	import mx.controls.Alert;
	
	public class AddCardTagCommand extends SequenceCommand
	{
		var tag:Tag;
		
		public function AddCardTagCommand()
		{
			super();
		}
		
		public override function execute(event:CairngormEvent):void
		{
			card = event.card;
			tag = event.tag;
			if (newTagNotValid(tag.name)) return;
			
			tag.addEventListener(ResultEvent.RESULT, cardTagAddedHandler);
			tag.create();
		}
		
		private function cardTagAddedHandler(event:ResultEvent)
		{
			tag = event.result;
			tag.removeEventListener(ResultEvent.RESULT, cardTagAddedHandler);
			card.tags.addItem(tag);
			ModelLocator.getInstance().currentCardDetails = card;
			ModelLocator.getInstance().statusMessages.addItemAt( "Added Tag '" + tag.name + "' to Card",0 );
			nextEvent = new RefreshTagListEvent();
			executeNextCommand();
		}

		private function newTagNotValid(newTagName:String):Boolean {
            if (newTagName.length == 0) {
				return true;
            }
            if (newTagName == "None") {
            	Alert.show("None is a reserved word and not to be used as an actual Tag.");
				return true;            	
            }
			for  (var index = 0; index < card.tags.length; index++) {
				if (newTagName == card.tags.getItemAt(index).name) {
					return true;
				}	
			}
			return false;
		}
		
	}
}