/**
 * Created by Dan Sumption - @dansumption
 * Date: 23/10/12
 * Time: 22:13
 */
package
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import org.sumption.output.SaveJpegs;

	import org.sumption.render.PixelColumnBitmap;
	import org.sumption.webcam.WebcamInput;

	public class TimeCamera extends Sprite
	{
		private var bitmapData:BitmapData;
		private var bitmap:Bitmap;
		private var pixelColumnBitmap:PixelColumnBitmap;
		private var framesGrabbed:int;
		private var saveJpegs:SaveJpegs;

		public function TimeCamera()
		{
			init();
		}

		private function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			layoutStage();

			stage.addEventListener(Event.RESIZE, layoutStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}


		private function layoutStage(event:Event = null):void
		{
			if (bitmapData)
			{
				bitmapData.dispose();
				removeChild(bitmap);
			}

			framesGrabbed = 0;
			var webcamInput:WebcamInput = new WebcamInput();
			bitmapData = new BitmapData(stage.stageWidth, webcamInput.height);
			pixelColumnBitmap = new PixelColumnBitmap(webcamInput, bitmapData);
			bitmap = new Bitmap(bitmapData);
			addChild(bitmap);
			setChildIndex(bitmap, 0);
			bitmap.y = (stage.stageHeight - bitmapData.height)/2;
			stage.frameRate = webcamInput.fps;
			saveJpegs = new SaveJpegs();
			CONFIG::DEBUG
			{
				trace('debug mode');
				webcamInput.showCam();
				addChild(webcamInput);
			}

		}

		private function onEnterFrame(event:Event):void
		{
			pixelColumnBitmap.update();
			framesGrabbed++;
			if (framesGrabbed == stage.stageWidth)
			{
				saveJpegs.saveBitmap(bitmapData);
				framesGrabbed = 0;
			}
		}
	}
}
