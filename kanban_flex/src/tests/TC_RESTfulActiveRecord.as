package tests
{
	import flash.utils.describeType;
	
	import flexunit.framework.TestCase;
	
	import models.Board;
	import models.Card;
	import models.Column;
	import models.ModelForTesting;
	
	import mx.core.Application;
	import mx.rpc.events.ResultEvent;

	public class TC_RESTfulActiveRecord extends TestCase
	{
		private var modelForTesting:ModelForTesting;
		private var fakeRESTHttpServiceHelper;
		private var dispatchedEvent = true;
		
		public function TC_RESTfulActiveRecord(methodName:String=null)
		{
			super(methodName);
		}
		
		override public function setUp():void {
	    	modelForTesting = new ModelForTesting();
	    	modelForTesting.serverName = "";
	    	fakeRESTHttpServiceHelper = new FakeRESTHttpServiceHelper();
	    	modelForTesting.RESTService = fakeRESTHttpServiceHelper;	    	
	    	modelForTesting.initialize();
	    }
	    
	    override public function tearDown():void {
	    	assertTrue("The RESTfulActiveRecord class should have dispatched a result event.",dispatchedEvent);
	    }
	    
	    public function testServerDetermination() {
	    	assertEquals("The server should be localhost.","http://localhost:3000/", modelForTesting.serverName);
	    	Application.application.parameters.kanbanServer = "a silly server name";
	    	modelForTesting = new ModelForTesting();
	    	assertEquals("The name of the server should come from the Application class.", "a silly server name", modelForTesting.serverName);
	    }
	    
	    public function testFindDispatchesEvent() {
	    	fakeRESTHttpServiceHelper.resultOfSend = new XML("<modelForTesting></modelForTesting>");
	    	dispatchedEvent = false;
	    	modelForTesting.addEventListener(ResultEvent.RESULT, assert_testFindDispatchesEvent);
	    	modelForTesting.find();
	    }
	    
	    public function assert_testFindDispatchesEvent(event:ResultEvent) {
	    	assertFalse(dispatchedEvent);
	    	dispatchedEvent = true;
	    }
		public function testFind_allWithTwoReturned() {
			fakeRESTHttpServiceHelper.resultOfSend = new XML(twoModelsXML());

			modelForTesting.addEventListener(ResultEvent.RESULT, assert_testFind_allWithTwoReturned);
			modelForTesting.find();		
		}
		
		private function assert_testFind_allWithTwoReturned(event:ResultEvent) {
			var results = event.result;
			
			assertEquals("Two items should be returned in the list.", 2, results.length);
			assertEquals("The item in the list should be of type ModelForTesting.", 
							describeType(modelForTesting).@name.toString(), 
							describeType(results.getItemAt(0)).@name.toString());
		}
		
		public function testFind_withNoXMLReturned() {
			fakeRESTHttpServiceHelper.resultOfSend = "";
			modelForTesting.addEventListener(ResultEvent.RESULT, assert_testFind_withNoXMLReturned);
			modelForTesting.find();
		}
		
		private function assert_testFind_withNoXMLReturned(event:ResultEvent) {
			assertNull("nothing should be exposed when result is not xml.", event.result); 
		}
		
		public function testFind_withNoModelsReturned() {
			fakeRESTHttpServiceHelper.resultOfSend = <nil-classes type="array" />;
			modelForTesting.addEventListener(ResultEvent.RESULT, function(event){
				assertNotNull(event.result);
				assertEquals(0, event.result.length);
			});
			modelForTesting.find();
		}
		
		public function testFind_specificOneReturned() {
			fakeRESTHttpServiceHelper.resultOfSend = new XML( (	<ModelForTesting>
																	<created-at type="datetime">2008-05-27T16:22:05Z</created-at>
																	<id type="integer">1</id>
																	<name>Dart</name>
																	<updated-at type="datetime">2008-06-26T16:22:05Z</updated-at>
																</ModelForTesting>).toString() );
			modelForTesting.addEventListener(ResultEvent.RESULT, assert_testFind_specificOneReturned);
			modelForTesting.find(42);
		}
		
		private function assert_testFind_specificOneReturned(event:ResultEvent) {
			var result = event.result;
			
			assertEquals( "A ModelForTesting should have been returned.",
							describeType(modelForTesting).@name.toString(), 
							describeType(result).@name.toString()); 
							
			assertEquals(1, result.id);
			assertEquals("Dart", result.name);
			assertEquals("2008-05-27T16:22:05Z", result.created_at);
			assertEquals("2008-06-26T16:22:05Z", result.updated_at);
		}
		
		public function testUsageOfApplicationParameters() {
			
		}
		
		public function testFind_specificWithNestedItems() {
			// the three lines below are necessary due to a bug
			// in getDefinitionByName - the work around that this  
			// implements it to get classes loaded into VM prior
			// to using them. lines below do this
			var board:Board;
			var column:Column;
			var card:Card;
			
			fakeRESTHttpServiceHelper.resultOfSend = new XML(twoColumnBoardWithCards());
			
			modelForTesting.addEventListener(ResultEvent.RESULT, assert_TestFind_specificWithNestedItems);
			modelForTesting.find(42);
			
		}
		
		private function assert_TestFind_specificWithNestedItems(event:ResultEvent) {			
			var result = event.result;
			
			assertEquals("There should be two columns on the returned board.", 2, result.columns.length);
			assertEquals("The first column should have 1 card on it.", 1, result.columns.getItemAt(0).cards.length);
			assertEquals("The second column should have 2 cards on it.", 2, result.columns.getItemAt(1).cards.length);
		}

		
		public function testXMLGeneratedFromDynamicModel() {
			var modelForTesting = new ModelForTesting();
			modelForTesting.zzz = 3;
			modelForTesting.qqq = "hello";

			modelForTesting.RESTService.method = "POST";
			modelForTesting.RESTService.request = modelForTesting.populateXML();
			
			assertEquals("The XML generated should match our test.", 
				new XML(zzzqqqXML()), modelForTesting.RESTService.request.toString());
		}
		
		private function zzzqqqXML() {
			var xmlString = ( <modelfortesting>
									<zzz>3</zzz>
									<qqq>hello</qqq>
							  </modelfortesting>).toString();
			return xmlString;
		}

		private function twoModelsXML() {
			var xmlString = ( <ModelForTestings type="array">
								<ModelForTesting>
									<created-at type="datetime">2008-06-26T16:22:05Z</created-at>
									<id type="integer">1</id>
									<name>Dart</name>
									<updated-at type="datetime">2008-06-26T16:22:05Z</updated-at>
								</ModelForTesting>
								<ModelForTesting>
									<created-at type="datetime">2008-06-26T16:22:05Z</created-at>
									<id type="integer">2</id>
									<name>ELT</name>
									<updated-at type="datetime">2008-06-26T16:22:05Z</updated-at>
								</ModelForTesting>
							</ModelForTestings>).toString();
			return xmlString;
		}
		
		private function noModelsXML() {
			return ( <nil-classes type="array" />).toString();
		}
		
		private function twoColumnBoardWithCards() {
			var xmlString = ( <board>
  								<created-at type="datetime">2008-06-26T16:22:05Z</created-at>
  								<id type="integer">1</id>
  								<name>Dart</name>
  								<updated-at type="datetime">2008-06-26T16:22:05Z</updated-at>
  								<columns type="array">
    								<column>
      									<board-id type="integer">1</board-id>
      									<created-at type="datetime">2008-07-08T20:29:33Z</created-at>
      									<id type="integer">5</id>
      									<name>test</name>
      									<position type="integer">1</position>
      									<updated-at type="datetime"> 2008-07-25T16:22:18Z </updated-at>
      									<cards type="array">
        									<card>
          										<column-id type="integer"> 5 </column-id>
          										<created-at type="datetime"> 2008-07-15T17:50:43Z </created-at>
          										<description> kjadsfkjsdkjkzbxcvmvxczn,m </description>
          										<id type="integer"> 19 </id>
          										<name> something </name>
          										<updated-at type="datetime"> 2008-07-25T16:22:37Z </updated-at>
        									</card>
      									</cards>
    								</column>
    								<column>
      									<board-id type="integer"> 1 </board-id>
      									<created-at type="datetime"> 2008-07-15T13:04:26Z </created-at>
      									<id type="integer"> 44 </id>
      									<name> goober </name>
      									<position type="integer"> 2 </position>
      									<updated-at type="datetime"> 2008-08-28T15:39:42Z </updated-at>
      									<cards type="array">
        									<card>
          										<column-id type="integer"> 44 </column-id>
          										<created-at type="datetime"> 2008-07-24T00:43:16Z </created-at>
          										<description nil="true"/>
          										<id type="integer"> 21 </id>
          										<name> a new card </name>
          										<updated-at type="datetime"> 2008-08-28T15:39:33Z </updated-at>
        									</card>
        									<card>
          										<column-id type="integer"> 44 </column-id>
          										<created-at type="datetime"> 2008-07-15T17:50:43Z </created-at>
          										<description> kjadsfkjsdkjkzbxcvmvxczn,m </description>
          										<id type="integer"> 19 </id>
          										<name> something </name>
          										<updated-at type="datetime"> 2008-07-25T16:22:37Z </updated-at>
        									</card>
      									</cards>
    								</column>
    							</columns>
    						</board> ).toString();
    
							return xmlString;
		}
	}
}