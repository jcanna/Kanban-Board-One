package tests
{
	import flexunit.framework.TestCase;
	
	import helpers.StringHelper;
	
	public class TC_StringHelper extends TestCase
	{
		public function TC_StringHelper(methodName:String=null)
		{
			super(methodName);
		}
				
		public function testAddPlural() {
			assertEquals("beaches", StringHelper.addPlural("beach"));
			assertEquals("fillies", StringHelper.addPlural("filly"));
			assertEquals("boards", StringHelper.addPlural("board"));
			assertEquals("stories", StringHelper.addPlural("story"));
			
			assertEquals("When adding a plural to a plural the plural should be returned.", 
						"stories", StringHelper.addPlural("stories"));
		}
		
		public function testRemovePlural() {
			assertEquals("beach", StringHelper.removePlural("beaches"));
			assertEquals("filly", StringHelper.removePlural("fillies"));
			assertEquals("board", StringHelper.removePlural("boards"));
			assertEquals("story", StringHelper.removePlural("stories"));	
			
			assertEquals("When removeing a plural from a singular the singular should be returned.",
						"board", StringHelper.removePlural("board"));	
		}
	}
}