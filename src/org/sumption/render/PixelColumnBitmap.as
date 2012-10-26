/**
 * Created by Dan Sumption - @dansumption
 * Date: 23/10/12
 * Time: 22:16
 */
package org.sumption.render
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import org.sumption.webcam.WebcamInput;

	public class PixelColumnBitmap
	{
		private var bitmapData:BitmapData;
		private var webcamInput:WebcamInput;

		private var shiftRectangle:Rectangle;
		private var shiftDestinationPoint:Point;

		private var copyColumnRectangle:Rectangle;
		private var copyColumnDestinationPoint:Point;

		public function PixelColumnBitmap(webcamInput:WebcamInput, bitmapData:BitmapData)
		{
			this.webcamInput = webcamInput;
			this.bitmapData = bitmapData;
			init();
		}


		private function init():void
		{
			shiftRectangle = new Rectangle(1, 0, bitmapData.width - 1, bitmapData.height);
			shiftDestinationPoint = new Point(0, 0);
			copyColumnRectangle = new Rectangle(Math.floor(webcamInput.width / 2), 0, 1, webcamInput.height);
			copyColumnDestinationPoint = new Point(bitmapData.width - 1, 0);
		}

		public function update():void
		{
			var updatedBitmapData:BitmapData = webcamInput.getUpdatedBitmapData();
			bitmapData.copyPixels(bitmapData, shiftRectangle, shiftDestinationPoint);
			bitmapData.copyPixels(updatedBitmapData, copyColumnRectangle, copyColumnDestinationPoint);
		}
	}
}
