package ui{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import phys.Hero;
	import phys.Joint;
	import phys.Obj;
	import phys.WorldExt;
	import system.Controller;
	import system.Fps;
	import flash.display.DisplayObjectContainer;
	
	public class GamePlay extends Movie {
		
		public var mui:GamePlayUI;
		public var lwidth:Number;
		public var lheight:Number;
		public var sprs:Array;
		public var level:int;
		
		public function GamePlay(lvl:int) {
			Main.gp = this;
			Main.STAGE.focus = Main.MAIN;
			Obj.bodyList = new Array();
			level = lvl;
			sprs = new Array();
			lwidth = Main.sc.levelsSize[0][level];
			lheight = Main.sc.levelsSize[1][level];
			super(MovieClip);
		}
		
		public function update():void 
		{
			Main.STAGE.focus = Main.MAIN;
			
			var edge:int = 160;
			if (Main.hero.x < edge) {
				Main.we.cam.x += edge - Main.hero.x;
				if (Main.gp.sprs[5].x + edge - Main.hero.x > 0)
					Main.we.cam.x -= Main.gp.sprs[5].x + edge - Main.hero.x;
			}
			if (Main.hero.y < edge) {
				Main.we.cam.y += edge - Main.hero.y;
				if (Main.gp.sprs[5].y + edge - Main.hero.y > 0)
					Main.we.cam.y -= Main.gp.sprs[5].y + edge - Main.hero.y;
			}
			if (Main.hero.x > Main.sc.gameWidth - edge) {
				Main.we.cam.x += Main.sc.gameWidth - edge - Main.hero.x;
				if (-Main.gp.sprs[5].x + edge + Main.hero.x > lwidth)
					Main.we.cam.x += -Main.gp.sprs[5].x + edge + Main.hero.x - lwidth;
			}
			if (Main.hero.y > Main.sc.gameHeight - edge) {
				Main.we.cam.y += Main.sc.gameHeight - edge - Main.hero.y;
				if (-Main.gp.sprs[5].y + edge + Main.hero.y > lheight) 
					Main.we.cam.y += -Main.gp.sprs[5].y + edge + Main.hero.y - lheight;
			}
		}
		
		override public function free():void
		{
			Main.we.free();
			Main.cr.free();
			super.free();
		}		
		
		override protected function init(e:Event = null):void
		{
			super.init();
			Fps.start();
			
			Main.mm.add(new GamePlayUI());
			Main.we = new WorldExt();
			Main.cr = new Controller();
			
			for (var i:int = 5 ; i > 0; i--) {
				sprs[i] = new Sprite();
				clip.addChild(sprs[i]);
			}
			
			var scene:MovieClip;
			switch(level) {
				case 0: scene = new e0(); break;
				//case 1: scene = new e1(); break;
				//case 2: scene = new e2(); break;
				//case 3: scene = new e3(); break;
				//case 4: scene = new e4(); break;
			}
			
			scene.name = 'scene';
			initEpisode(scene);
			if (scene.getChildByName('backgr') != null) {
				sprs[5].addChild(scene.getChildByName('backgr'));
			}
			scene = null;
		}
		
		private function initEpisode(ob:DisplayObjectContainer):void 
		{
			if ((ob is Obj) && (Obj(ob).body == null)) { Obj(ob).init(); }
			for (var i:int = 0; i < ob.numChildren ; i++ ) {
				if ((ob.getChildAt(i) is DisplayObjectContainer)&&(!(ob is Obj))) 
				{ 
					var len:Number = Math.sqrt((ob.getChildAt(i).x) * (ob.getChildAt(i).x) + (ob.getChildAt(i).y) * (ob.getChildAt(i).y));
					var ang:Number = Math.atan2(ob.getChildAt(i).y,ob.getChildAt(i).x);
					ob.getChildAt(i).x = ob.x + len*Math.cos(ang+ob.rotation/180*Math.PI);
					ob.getChildAt(i).y = ob.y + len*Math.sin(ang+ob.rotation/180*Math.PI);
					ob.getChildAt(i).rotation += ob.rotation;
					initEpisode(DisplayObjectContainer(ob.getChildAt(i))); 
				}
			}
		}
		
	}
	
}
