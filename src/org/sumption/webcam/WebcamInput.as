/**
 * Created by Dan Sumption - @dansumption
 * Date: 23/10/12
 * Time: 22:13
 */
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
		public static const CONSTRAINED_WIDTH:int = 320;
		public static const CONSTRAINED_HEIGHT:int = 240;
		public static const CONSTRAINED_FPS:int = 15;
		public static const IS_CONSTRAINED:Boolean = true;

		
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
			_cam.setMode(width, height, fps);
			trace('Camera set to ' + width + 'x' + height + ' @' + fps + 'fps');
			_vid = new Video(width, height);
			_vid.attachCamera(_cam);
			bitmapData = new BitmapData(width, height, false);
		}


		override public function get width():Number
		{
			if (!_cam || IS_CONSTRAINED)
				return CONSTRAINED_WIDTH;
			return _cam.width;
		}

		override public function get height():Number
		{
			if (!_cam || IS_CONSTRAINED)
				return CONSTRAINED_HEIGHT;
			return _cam.height;
		}

		public function get fps():int
		{
			if (!_cam || IS_CONSTRAINED)
				return CONSTRAINED_FPS;
			return _cam.fps;
		}

		public function getUpdatedBitmapData():BitmapData
		{
			bitmapData.draw(_vid, new Matrix(-1, 0, 0, 1, bitmapData.width, 0));
			return bitmapData;
		}

		CONFIG::DEBUG
		{
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
		}
	}
}