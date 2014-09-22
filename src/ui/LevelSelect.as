package ui
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LevelSelect extends Movie
	{
		
		public function LevelSelect() { super(LevelSelectClip); }

		override protected function init(e:Event = null):void
		{
			super.init();
			var level:LevelIcon;
			for (var i:int=0; i<Main.sc.totalLevels; i++) {
				level=new LevelIcon(i, Main.gd.levelClasses[Main.gd.levels[i]]);
				clip.addChild(level.clip);
			}
		}

		override protected function buttonClick(e:MouseEvent):void
		{
			switch(e.target.name) {
				case 'menu_btn':
					Main.mm.show(new MainMenu(), true);
				break;
				case 'more_btn':
					
				break;
			}
		}	

	}
	
}