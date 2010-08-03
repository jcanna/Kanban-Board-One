package helpers
{
	import model.ModelLocator;
	
	import models.Card;
	import models.Column;
	
	import mx.collections.ArrayCollection;
	
	
	public class StringHelper
	{
		public static function removePlural(plural) {
			var endsInS = new RegExp("s$");
			if (!plural.match(endsInS))
				return plural;
				
			var endsInIES = new RegExp("ies$");
			if (plural.match(endsInIES))
				return plural.replace(endsInIES, "y");
				
			var endsInES = new RegExp("es$");
			if (plural.match(endsInES)) {
				var shouldEndInES = new RegExp("sh|ch|[zx]$");
				var esTest = plural.substring(0, plural.length - 2);
				if (esTest.match(shouldEndInES)) {
					return plural.substring(0, plural.length - 2);				
				} else {
					return plural.substring(0, plural.length - 1);
				}
			}
				
			return plural.substring(0, plural.length - 1); 
		}
		
		public static function addPlural(singular) {
			var endsInS = new RegExp("s$");
			if (singular.match(endsInS))
				return singular;
				
			var shouldEndInES = new RegExp("sh|ch|[zx]$")	
			if (singular.match(shouldEndInES))
				return singular + "es";
				
			var shouldEndInIES = new RegExp("y$");
			if (singular.match(shouldEndInIES))
				return singular.replace(shouldEndInIES, "ies");
				
			return singular + "s";
		}
		
		public static function searchInCards(cards:ArrayCollection, searchCriteria:String):ArrayCollection
		{
			var searchResults:ArrayCollection = new ArrayCollection();
			var criteriaSearchIgnoreCase = new RegExp(searchCriteria,"i");
			for each (var card:Card in cards)
			{
				if (card.name.match(criteriaSearchIgnoreCase) || card.description.match(criteriaSearchIgnoreCase))
				{
					searchResults.addItem(card);
				}
			}
			return searchResults;
		}
		
		public static function toUpperFirstLetter(string) {
			var firstChar:String = string.substr(0, 1);
			firstChar = firstChar.toUpperCase();
			var restOfString = string.substr(1, string.length);
			return firstChar + restOfString;
		}
		
		public static function toLowerFirstLetter(string) {
			var firstChar:String = string.substr(0, 1);
			firstChar = firstChar.toLowerCase();
			var restOfString = string.substr(1, string.length);
			return firstChar + restOfString;			
		}
		
		public static function removeSpaces(string:String):String {
			var myPattern:RegExp = /\s/g; //replace all hyphens with underscores
			return string.replace(myPattern,"");
		}

		//Display a User's full name
		public static function fullName(item:Object):String {
			return item.first_name + " " + item.last_name;
		}

		//Display card information
		public static function searchCardName(item:Object):String {
			var columnName:String = item.hasOwnProperty("column_name") ? item.column_name : "No Column";
			return item.name + " (" + columnName + ")"; 
		}

		public static function cardWithColumnName(card:Card):String {
			if (ModelLocator.getInstance().allColumns != null && card.column_id != 0) {
				for each (var column:Column in ModelLocator.getInstance().allColumns) {
					if (card.column_id == column.id)
						return card.name + " (" + column.name + ")";
				}
			}
			return card.name + " (No Column)";
		}

	}
}