package ui{
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class PauseScreen extends Movie {
		
		public function PauseScreen() { super(PauseClip); }
		
		override public function free():void
		{
			Main.mm.remove(this);
			Main.we.worldTimer.start();
			super.free();
		}
		
		override protected function init(e:Event = null):void
		{
			super.init();
			Main.we.worldTimer.stop();
			clip.addEventListener(MouseEvent.CLICK, resume);
		}
		
		private function resume(e:MouseEvent = null):void {free();}
		
	}
	
}
