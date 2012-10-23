package org.sumption.webcam
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;

	public final class WebcamInput extends Sprite
	{
		public static const APPLE_WEBCAM_NAME:String = "USB Video Class Video";
		public static const WEBCAM_WIDTH:int = 640;
		public static const WEBCAM_HEIGHT:int = 480;
		
		private var _cam:Camera;
		private var _vid:Video;
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		

		public function WebcamInput()
		{
			init();
		}
		
		private function init():void
		{
			_cam = Camera.getCamera();
			_cam.setMode(_cam.width, _cam.height, 24);
			_vid = new Video(WEBCAM_WIDTH, WEBCAM_HEIGHT);
			_vid.attachCamera(_cam);
			bitmapData = new BitmapData(WEBCAM_WIDTH, WEBCAM_HEIGHT, false);
		}
		
		public function getUpdatedBitmapData():BitmapData
		{
			bitmapData.draw(_vid, new Matrix(-1, 0, 0, 1, bitmapData.width, 0));
			return bitmapData;
		}
		
		public function showCam():void
		{
			bitmap = new Bitmap(bitmapData);
			addChild(bitmap);
		}
		
		public function hideCam():void
		{
			removeChild(bitmap);
			bitmap = null;
		}

		public function setBitmapScale (xScale:Number, yScale:Number):void
		{
			bitmap.scaleX = xScale;
			bitmap.scaleY = yScale;
		}
		
		override public function get width():Number
		{
			return _vid.width;
		}
		
		override public function get height():Number
		{
			return _vid.height;
		}
	}
}