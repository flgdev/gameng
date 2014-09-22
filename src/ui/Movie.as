package ui
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;

	public class Movie extends MovieClip
	{
		public var u:Dictionary;
		public var clip:MovieClip;
		
		public function Movie(mc:Class)
		{
			clip = new mc();
			if (clip.stage) init();
			else clip.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function free():void {
			for (var i:int = 0; i < clip.numChildren; i++) {
				if (clip.getChildAt(i) is SimpleButton) 
					SimpleButton(clip.getChildAt(i)).removeEventListener(MouseEvent.CLICK, buttonClick);
			}
			for (var prop:* in u) {
				delete u[prop];
			}
		}
		
		protected function init(e:Event = null):void {
			clip.removeEventListener(Event.ADDED_TO_STAGE, init);
			u = new Dictionary();
			for (var i:int = 0; i < clip.numChildren; i++){
				if (clip.getChildAt(i) is TextField){
					TextField(clip.getChildAt(i)).selectable = false;
					u[(clip.getChildAt(i) as DisplayObject).name] = (clip.getChildAt(i) as DisplayObject);
				}
				if (clip.getChildAt(i) is SimpleButton) 
					SimpleButton(clip.getChildAt(i)).addEventListener(MouseEvent.CLICK, buttonClick);
			}
		}
		
		protected function buttonClick(e:MouseEvent):void {}
		
	}
	
}