package ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import ui.Change;
	import ui.GamePlay;
	import ui.Movie;
	
	public class LevelIcon extends MovieClip
	{
		public var level:int = -1;
		public var type:Class;
		public var clip:MovieClip;
		
		public function LevelIcon(lvl:int, tp:Class) {
			level = lvl;
			type = tp;
			clip = new tp();
			clip.stop();
			if (clip.stage) init();
			else clip.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function free():void
		{
			clip.removeEventListener(MouseEvent.CLICK, clicked);
		}	
		
		protected function init(e:Event = null):void
		{
			clip.addEventListener(MouseEvent.MOUSE_OVER, changeFrame);
			clip.addEventListener(MouseEvent.MOUSE_OUT, changeFrame);
			TextField(clip.getChildByName('txt')).text = String(level + 1);
			clip.x = Main.sc.levelsOffsetX + (level%Main.sc.levelsPerRow)*(Main.sc.levelsHorizontalSpacing+clip.width);
			clip.y = Main.sc.levelsOffsetY + Math.floor(level/Main.sc.levelsPerRow)*(Main.sc.levelsVerticalSpacing+clip.height);
			if(type!=LevelClose)clip.addEventListener(MouseEvent.CLICK, clicked);
			clip.mouseChildren=false;
			clip.buttonMode=true;
		}
		
		private function changeFrame(e:MouseEvent):void 
		{
			if (e.type == 'mouseOver') clip.gotoAndStop(2);
			if (e.type == 'mouseOut') clip.gotoAndStop(1);
		}
		
		private function clicked(e:MouseEvent):void
		{
			clip.gotoAndStop(1);
			Main.sc.currentLevel = level;
			Main.mm.show(new GamePlay(level), true);
			free();
		}
		
	}
	
}