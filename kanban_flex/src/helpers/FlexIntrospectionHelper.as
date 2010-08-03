package helpers
{
	import mx.collections.ArrayCollection;
	
	
	public class FlexIntrospectionHelper
	{
		public static function generateValidPropertyName(propertyName:String) {

			var myPattern:RegExp = /-/g; //replace all hyphens with underscores
			return StringHelper.toLowerFirstLetter(propertyName.replace(myPattern,"_"));

		}

		public static function generateValidClassName(className:String) {

			if (className.indexOf("-") > -1) 
			{
				var peices:Array = className.split("-");
				var newName:String = "";
				for each (var peice:String in peices)
				{
					newName += StringHelper.toUpperFirstLetter(peice) + "_";
				}
				return newName.substr(0,newName.length-1);
			}
			return StringHelper.toUpperFirstLetter(className);

		}

	}
}