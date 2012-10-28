/**
 * Created by Dan Sumption - @dansumption
 * Date: 23/10/12
 * Time: 22:13
 */
package
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Worker;
	import flash.system.WorkerDomain;
	import flash.system.WorkerState;
	import flash.utils.ByteArray;

	import org.sumption.output.SaveJpegs;
	import org.sumption.render.View;

	public class TimeCamera extends Sprite
	{

		private var view:View;

		public function TimeCamera()
		{
			trace (Worker.isSupported);
			// init();
		}

		/*
		* Use this app as both the main worker (responsible for painting display, collecting webcam input etc), and
		* the background worker (responsible for converting & saving the webcam output to JPEGs, screen-by-screen.
		* This is not the most effective way of doing things (as it means having 2 copies of the entire app, rather
		* than reducing each worker just to the functionality required by that worker), but keeps the project
		* self-contained, with no need to embed or load a separate SWF for the JPEG conversion.
		 */
		private function init():void
		{
			trace('init');
			var swfBytes:ByteArray = this.loaderInfo.bytes;
			trace('got swf');

			// Check to see if this is the primordial worker
			if (Worker.current.isPrimordial)
			{
				trace('primordial worker');
				view = new View(this);
				var bgWorker:Worker = WorkerDomain.current.createWorker(swfBytes);
				bgWorker.addEventListener(Event.WORKER_STATE, workerStateHandler);

				// set up communication between workers using
				// setSharedProperty(), createMessageChannel(), etc.
				// ... (not shown)

				bgWorker.start();
			}
			else // entry point for the background worker
			{
				trace('background worker');
				// set up communication between workers using getSharedProperty()
				// ... (not shown)

				var saveJpegs:SaveJpegs = new SaveJpegs();
			}
		}

		private function workerStateHandler(event:Event):void
		{
			var bgWorker:Worker = event.target as Worker;
			if (bgWorker && bgWorker.state == WorkerState.RUNNING)
			{
				trace("Background worker started");
			}
		}

	}
}
