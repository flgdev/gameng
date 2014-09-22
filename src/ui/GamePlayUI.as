package ui{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.DisplayObject;
	
	public class GamePlayUI extends Movie {
		
		public function GamePlayUI() {
			Main.gp.mui = this;
			super(GPUI);
			if (Main.ap.soundOn) { clip.setChildIndex(clip.getChildByName('soundo_btn'), 0); }
			if (Main.ap.musicOn) { clip.setChildIndex(clip.getChildByName('musico_btn'), 0); }
		}
		
		public function restart():void 
		{
			Main.we.worldTimer.stop();
			Main.mm.show(new GamePlay(Main.gp.level), true);			
		}
		
		override protected function buttonClick(e:MouseEvent):void 
		{
			switch(e.target.name) {
				case 'restart_btn':
					restart();
				break;
				case 'pause_btn':
					Main.mm.add(new PauseScreen());
				break;
				case 'sound_btn': case 'soundo_btn':
					Main.ap.soundOn = !Main.ap.soundOn;
					clip.setChildIndex(DisplayObject(e.target), 0);
					Main.gd.save();
				break;
				case 'music_btn': case 'musico_btn':
					Main.ap.musicOn = !Main.ap.musicOn;
					clip.setChildIndex(DisplayObject(e.target), 0);
					Main.gd.save();
				break;
				case 'levels_btn':
					Main.mm.show(new LevelSelect(), true);
				break;
			}
		}
		
	}
	
}
