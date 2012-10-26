/**
 * Created by Dan Sumption - @dansumption
 * Date: 26/10/12
 * Time: 14:26
 */
package org.sumption.utils
{
	public class StringUtils
	{
		public static function padInt(value:uint, length:uint, padCharacter:String = '0'):String
		{
			if (padCharacter.length != 1)
				throw new Error("padCharacter must be a single character only");
			var returnValue:String = value.toString();
			while (returnValue.length < length)
				returnValue = padCharacter + returnValue;
			return returnValue;
		}
	}
}
