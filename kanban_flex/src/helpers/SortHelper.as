package helpers
{
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	public class SortHelper
	{
		public static function sortAlphaBy(col:ArrayCollection, fieldName:String):ArrayCollection
		{
			if (col == null) return null;
            //Create a Sort object to sort all of the cards.
            var sortA:Sort = new Sort();
            var sortByName:SortField = new SortField(fieldName, true, false,false);
            sortA.fields=[sortByName];
            col.sort=sortA;
            // Refresh the collection view to show the sort.
            col.refresh();
            return col;	
		}		
	}


}