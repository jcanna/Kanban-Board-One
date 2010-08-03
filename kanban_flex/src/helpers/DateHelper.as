package helpers
{
	public class DateHelper
	{
		import mx.controls.DateField;

		public static const millisecondsPerHour:int = 1000 * 60 * 60;
		public static const millisecondsPerDay:int  = 1000 * 60 * 60 * 24;


		//For converting database timestamps like "2008-10-31T16:24:40Z" to Flex <Date>
		public static function timestampToDate(string:String):Date {
			if (string == null || string.length < 18) return null;
			var date:Date = DateField.stringToDate(string.substr(0,10), "YYYY-MM-DD");
			if (date != null)
				date.setHours(new Number(string.substr(11,2)),new Number(string.substr(14,2)),new Number(string.substr(17,2)));
			return date;
		}


	}
}