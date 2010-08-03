package tests
{
	import flexunit.framework.TestCase;
	
	import model.ModelLocator;
	
	import models.Board;
	import models.Card;
	import models.Column;
	import models.ModelForTesting;
	
	import mx.collections.ArrayCollection;
	
	public class TC_ModelLocatorMethods extends TestCase
	{
		private var modelLocator:ModelLocator;

		public function TC_ModelLocatorMethods(methodName:String=null)
		{
			super(methodName);
		}

		override public function setUp():void {
	    	modelLocator = ModelLocator.getInstance();
	    }
	    
	    public function testSelectedIndex() {
	    	var model1:ModelForTesting = new ModelForTesting();
	    	var model2:ModelForTesting = new ModelForTesting();
	    	model2.id = 666;
	    	var model3:ModelForTesting = new ModelForTesting();
			var arr:ArrayCollection = new ArrayCollection();
			arr.addItem(model1);
			arr.addItem(model1);
			arr.addItem(model2);
			arr.addItem(model3);
	    	assertEquals(-1, modelLocator.selectedIndex(null,arr));
	    	assertEquals(2, modelLocator.selectedIndex(model2,arr));
	    	assertEquals(-1, modelLocator.selectedIndex(model3,arr));
	    }
	    
	    public function testBoardListWithBlankOption() {
	    	var board = new Board();
	    	board.name = "BoardListItem";
	    	var testBoards:ArrayCollection = new ArrayCollection();
	    	testBoards.addItem(board);
	    	testBoards.addItem(board);
	    	modelLocator.boards = testBoards;
	    	assertEquals("Expected 2 + Blank board returned in list.", 
	    				3,modelLocator.boardListWithBlankOption(modelLocator.boards).length);
	    	assertEquals("Expected Blank board to be first in list.", 
	    				" ", modelLocator.boards[0].name);
	    	//Test to see that we do not add an 'additional' blank line a second time.
	    	assertEquals("Expected 2 + Blank board returned in list after hitting method a second time.", 
	    				3,modelLocator.boardListWithBlankOption(modelLocator.boards).length);
	    	assertFalse("Expected a non-Blank board in second position in list.", 
	    				" " == modelLocator.boards[1].name);
	    }
	    
	    public function testCardListWithBlankOption() {
	    	var card = new Card();
	    	card.name = "BlankCardListItem";
	    	
	    	var cards:ArrayCollection = new ArrayCollection();
	    	cards.addItem(card);
	    	cards.addItem(card);
	    	
	    	assertEquals("Expected 2 + Blank card returned in list.",
	    				3,modelLocator.allCardListWithBlankOption(cards).length);
	    	assertEquals("Expected Blank card to be first in list.", 
	    				" ", cards[0].name);
	    	//Test to see that we do not add an 'additional' blank line a second time.
	    	assertEquals("Expected 2 + Blank card returned in list after hitting method a second time.", 
	    				3,modelLocator.allCardListWithBlankOption(cards).length);
	    	assertFalse("Expected a non-Blank board in second position in list.",
	    				" " == cards[1].name);
	    }

		public function testCardBoardSelected() {
	    	var board1 = new Board();
	    	board1.id = 666;
	    	var board2 = new Board();
	    	board2.id = 777;
	    	var testBoards:ArrayCollection = new ArrayCollection();
	    	testBoards.addItem(board1);
	    	testBoards.addItem(board2);
	    	modelLocator.boards = testBoards;
	    	var column1 = new Column();
	    	column1.id = 22;
	    	var column2 = new Column();
	    	column2.id = 33;
	    	column2.board_id = 777;
	    	var testColumns:ArrayCollection = new ArrayCollection();
	    	testColumns.addItem( column1 );
	    	testColumns.addItem( column2 );
	    	var card = new Card();
			assertTrue("Expected index to be zero for blank card.", 
						modelLocator.cardBoardSelected( card, testColumns ) == 0);
	    	card.column_id = 22;
			assertTrue("Expected index to be zero for card column id that has no corresponding column.", 
						modelLocator.cardBoardSelected( card, testColumns ) == 0);
	    	card.column_id = 33;
			assertTrue("Expected index to be one for complete match through card to column to second board.", 
						modelLocator.cardBoardSelected( card, testColumns ) == 1);

		}


	}
}