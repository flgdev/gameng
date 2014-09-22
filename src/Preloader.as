package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	
	/*
function loading(e:Event):void{
	var total:Number = this.stage.loaderInfo.bytesTotal;
	var loaded:Number = this.stage.loaderInfo.bytesLoaded;
	prog.text = Math.floor((loaded/total)*100)+ "%";
	if (total == loaded){
		this.removeEventListener(Event.ENTER_FRAME, loading);
	}
}

this.addEventListener(Event.ENTER_FRAME, loading);
	 */
	public class Preloader extends MovieClip 
	{
		
		public var mov:MovieClip;
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			mov = new loadr();
			mov.x = 320;
			mov.y = 240;
			addChild(mov);
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			//var total:Number = this.stage.loaderInfo.bytesTotal;
			//var loaded:Number = this.stage.loaderInfo.bytesLoaded;
			//prog.text = Math.floor((loaded / total) * 100) + "%";
			
			var loadedBytes:int = Math.round(e.target.bytesLoaded  / 1024);
			var totalBytes:int = Math.round(e.target.bytesTotal / 1024);
			var percent:int = (e.target.bytesLoaded / e.target.bytesTotal) * 100;
			TextField(mov.getChildByName('info')).text = String(loadedBytes + " of " + totalBytes + "KB Loaded\n" + percent + "% Complete");
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			removeChild(mov);
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}