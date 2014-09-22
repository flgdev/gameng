package ui{
	import flash.events.Event;
	
	public class Change extends Movie {
		
		private var showNext:Movie = null;
		
		public function Change(sn:Movie) {
			showNext = sn;
			super(ChangeClip);
		}
		
		override protected function init(e:Event = null):void
		{
			super.init();
			clip.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void 
		{
			if (clip.currentFrame == 10) {
				Main.mm.show(showNext, false);
			}
			if (clip.currentFrame == clip.totalFrames) {
				clip.removeEventListener(Event.ENTER_FRAME, update);
				Main.mm.remove(this);
			}
		}
		
	}
	
}
