package
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import org.sumption.visualisers.PixelColumnBitmap;
	import org.sumption.webcam.WebcamInput;

	[SWF(backgroundColor="#FFFFFF", frameRate="24")]
	public class TimeCamera extends Sprite
	{
		private var bitmapData:BitmapData;
		private var bitmap:Bitmap;
		private var pixelColumnBitmap:PixelColumnBitmap;

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

			bitmapData = new BitmapData(stage.stageWidth, WebcamInput.WEBCAM_HEIGHT);
			pixelColumnBitmap = new PixelColumnBitmap(bitmapData);
			bitmap = new Bitmap(bitmapData);
			addChild(bitmap);
			setChildIndex(bitmap, 0);
			bitmap.y = (stage.stageHeight - bitmapData.height)/2;
		}

		private function onEnterFrame(event:Event):void
		{
			pixelColumnBitmap.update();
		}
	}
}
