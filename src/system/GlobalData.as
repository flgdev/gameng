package system
{
	import flash.net.SharedObject;
	
	public class GlobalData 
	{
		
		public var levels:Array;
		public var levelClasses:Array;
		public var score:int;
		public var soundOn: Boolean = true;
		public var musicOn: Boolean = true;
		public var so:SharedObject;
		
		public function GlobalData():void 
		{
			levelClasses = new Array();
			levelClasses[0] = LevelClose;
			levelClasses[1] = LevelOpen;
			levelClasses[2] = LevelClear;
			levels = new Array(); score = 0;
			for (var i:int=0;i<Main.sc.totalLevels; i++) { levels[i] = 0; }
			so = SharedObject.getLocal("swfgame", "/");
			if ((so.data.str != undefined) && (so.data.str.length > 0)){
				var ta:Array = so.data.str.split('|');
				levels = String(ta[0]).split(',');
				score = int(ta[1]);
				musicOn = Boolean(int(ta[2]));
				soundOn = Boolean(int(ta[3]));
			}else {
				for (i = 0; i < levels.length; i++ ) { levels[i] = int(levels[i]); }
				if (levels[0] == 0) { levels[0] = 1; }
				if (levels[1] == 0) { levels[1] = 1; }
				if (levels[2] == 0) { levels[2] = 1; }
			}
		}
		
		public function save():void
		{
			so.data.str = levels.join(',') +
			'|' + score.toString() + 
			'|' + int(Main.ap.musicOn) + 
			'|' + int(Main.ap.soundOn);
			so.flush();
		}
		
	}
	
}