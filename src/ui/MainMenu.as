package ui{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ui.Movie;
	
	public class MainMenu extends Movie {
		
		public function MainMenu() { super(MainMenuClip); }
		
		override protected function buttonClick(e:MouseEvent):void 
		{
			switch(e.target.name) {
				case 'play_btn':
					Main.mm.show(new LevelSelect(), true);
				break;
			}
		}	
		
	}
	
}
