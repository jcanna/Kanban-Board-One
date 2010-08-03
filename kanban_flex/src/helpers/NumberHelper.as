package helpers
{
	import mx.formatters.NumberFormatter;
	
	public class NumberHelper
	{

		public static function getFormattedNumber(number:Number, preciseDecimals:int):String
		{
			var nf:NumberFormatter = new NumberFormatter();
			nf.precision = preciseDecimals;
			nf.rounding = "nearest";
			return nf.format(number);		
		}


	}
}