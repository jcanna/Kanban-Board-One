package tests
{
	import business.commands.SaveCardCommand;
	import business.events.SaveCardEvent;
	
	import flexunit.framework.TestCase;
	
	import models.Card;
	
	public class TC_SaveCardCommand extends TestCase
	{
		private var saveCardCommand:SaveCardCommand;
	    private var card:Card;

		public function TC_SaveCardCommand(methodName:String=null)
		{
			super(methodName);
		}

		override public function setUp():void {
	    	saveCardCommand = new SaveCardCommand();
	    }
	    
	    public function testCardNotValid() {
	    	card = new Card();
	    	assertFalse("Expected no error msg with no name property on card.", saveCardCommand.newCardNotValid(card).length > 0);
	    	card.name = "Not Valid Test Card.";
	    	assertEquals("Expected no error msg when including valid name.", "", saveCardCommand.newCardNotValid(card));
	    	card.name = "";
	    	assertTrue("Expected error msg when including invalid name.", saveCardCommand.newCardNotValid(card).length > 0);
	    }
	    
	    public function testParentNotSelfCheck() {
	    	card = new Card();
	    	card.id = 4;
	    	assertFalse("Expected no error msg with no parent_id property on card.", 
	    				saveCardCommand.parentNotSelfCheck(card).length > 0);
			card.parent_id = 4;
	    	assertTrue("Expected error msg with matching self and parent ids.",
						saveCardCommand.parentNotSelfCheck(card).length > 0);
	    	card.parent_id = 6;
	    	assertEquals("Expected no error msg with different self and parent ids.", "",
				    	saveCardCommand.parentNotSelfCheck(card));
	    }
	    

	}
}