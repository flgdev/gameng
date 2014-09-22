package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import phys.Hero;
	import system.*;
	import ui.*;
	import phys.WorldExt;
	
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		static public var mm:MovieManager;
		static public var sc:SetupClass;
		static public var gd:GlobalData;
		static public var ap:AudioPlayer;
		static public var we:WorldExt;
		static public var gp:GamePlay;
		static public var cr:Controller;
		static public var hero:Hero;
		static public var STAGE:Stage;
		static public var MAIN:Main;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			STAGE = this.stage;
			STAGE.stageFocusRect = false;
			MAIN = this;
			sc = new SetupClass();
			gd = new GlobalData();
			mm = new MovieManager( this );
			ap = new AudioPlayer();
			gp = null;
			hero = null;
			//mm.show(new MainMenu(), true);
			Main.mm.show(new GamePlay(0), true);
		}
		
	}
	
}