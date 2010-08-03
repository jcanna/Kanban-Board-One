package tests
{
	import flexunit.framework.TestCase;
	
	import helpers.FlexIntrospectionHelper;

	public class TC_FlexIntrospectionHelper extends TestCase
	{
		public function TC_FlexIntrospectionHelper(methodName:String=null)
		{
			super(methodName);
		}
		
				
		public function testGenerateValidPropertyName() {
			assertEquals("created_at", FlexIntrospectionHelper.generateValidPropertyName("created-at"));
			assertEquals("created_At", FlexIntrospectionHelper.generateValidPropertyName("Created-At"));
			assertEquals("multiple_words_in_variable", FlexIntrospectionHelper.generateValidPropertyName("Multiple-words-in-variable"));	
		}
	}
}