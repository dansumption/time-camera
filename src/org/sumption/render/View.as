/**
 * Created by Dan Sumption - @dansumption
 * Date: 28/10/12
 * Time: 10:28
 */
package org.sumption.render
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import org.sumption.webcam.WebcamInput;

	public class View
	{
		private var parent:DisplayObjectContainer;
		private var bitmapData:BitmapData;
		private var bitmap:Bitmap;
		private var pixelColumnBitmap:PixelColumnBitmap;
		private var framesGrabbed:int;

		public function View(parent:DisplayObjectContainer)
		{
			this.parent = parent;
			init();
		}

		private function get stage():Stage
		{
			return parent.stage;
		}

		private function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			layoutStage();

			stage.addEventListener(Event.RESIZE, layoutStage);
			parent.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}


		private function layoutStage(event:Event = null):void
		{
			if (bitmapData)
			{
				bitmapData.dispose();
				parent.removeChild(bitmap);
			}

			framesGrabbed = 0;
			var webcamInput:WebcamInput = new WebcamInput();
			bitmapData = new BitmapData(stage.stageWidth, webcamInput.height);
			pixelColumnBitmap = new PixelColumnBitmap(webcamInput, bitmapData);
			bitmap = new Bitmap(bitmapData);
			parent.addChild(bitmap);
			parent.setChildIndex(bitmap, 0);
			bitmap.y = (stage.stageHeight - bitmapData.height)/2;
			stage.frameRate = webcamInput.fps;
			CONFIG::DEBUG
			{
				trace('debug mode');
				webcamInput.showCam();
				parent.addChild(webcamInput);
			}

		}

		private function onEnterFrame(event:Event):void
		{
			pixelColumnBitmap.update();
			framesGrabbed++;
			if (framesGrabbed == stage.stageWidth)
			{
				// saveJpegs.saveBitmap(bitmapData);
				framesGrabbed = 0;
			}
		}

	}
}
