/**
 * Created by Dan Sumption - @dansumption
 * Date: 26/10/12
 * Time: 14:16
 */
package org.sumption.output
{
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	import org.bytearray.JPEGEncoder;

	import org.sumption.utils.StringUtils;

	public class SaveJpegs
	{
		private var jpegEncoder:JPEGEncoder;
		private var parentDirectory:File;
		private var counter:int;
		private static const PAD_LENGTH:int = 6;
		private static const IMAGE_QUALITY:int = 60;
		private static const FILE_EXTENSION:String = '.jpg';
		private static const FILE_PREFIX:String = 'screenshot_';

		public function SaveJpegs()
		{
			parentDirectory = File.desktopDirectory;
			jpegEncoder = new JPEGEncoder(IMAGE_QUALITY);
		}

		public function saveBitmap(source:BitmapData):void
		{
			var fileName:String = FILE_PREFIX + StringUtils.padInt(counter, PAD_LENGTH) + FILE_EXTENSION;
			counter++;

			var outputFile:File = parentDirectory.resolvePath(fileName);

			if (outputFile.exists)
				throw new Error("Output file " + fileName + " already exists");
			var jpegByteArray:ByteArray = jpegEncoder.encode(source);

			var stream:FileStream = new FileStream();
			stream.open(outputFile, FileMode.WRITE);
			stream.writeBytes(jpegByteArray);
			stream.close();

		}
	}
}
