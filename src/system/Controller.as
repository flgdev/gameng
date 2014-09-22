package system
{
	import Box2D.Dynamics.b2Body;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import phys.Obj;
	import ui.PauseScreen;
	
	public class Controller 
	{
		
		private var buttons:Dictionary;
		
		public function Controller() {
			buttons = new Dictionary();
			Main.STAGE.addEventListener(KeyboardEvent.KEY_DOWN, keyHandle);
			Main.STAGE.addEventListener(KeyboardEvent.KEY_UP, keyHandleUp);
			Main.STAGE.addEventListener(Event.DEACTIVATE, pause);
		}
		
		public function free():void 
		{
			Main.STAGE.removeEventListener(KeyboardEvent.KEY_DOWN, keyHandle);
			Main.STAGE.removeEventListener(KeyboardEvent.KEY_UP, keyHandleUp);
			Main.STAGE.removeEventListener(Event.DEACTIVATE, pause);			
		}
		
		private function keyHandleUp(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case 37:
					buttons['left'] = false;
					if(Main.hero.currentMovie=='run')Main.hero.changeMovie('breath');
				break;
				
				case 38:
					buttons['up'] = false;
				break;
				
				case 39:
					buttons['right'] = false;
					if(Main.hero.currentMovie=='run')Main.hero.changeMovie('breath');
				break;
				
				case 40:
					buttons['down'] = false;
				break;
			}
		}
		
		public function pause(e:Event):void 
		{
			if (!Main.we.worldTimer.running) return;
			Main.mm.add(new PauseScreen());
		}
		
		private function keyHandle(e:KeyboardEvent):void 
		{
			switch(e.keyCode) {
				case 37:
					buttons['left'] = true;
					if(Main.hero.currentMovie!='run')Main.hero.changeMovie('run');
				break;
				
				case 38:
					buttons['up'] = true;
					if ((Main.hero.currentMovie == 'breath')||(Main.hero.currentMovie == 'run')) { 
						Main.hero.changeMovie('breath'); 
						Main.hero.body.GetLinearVelocity().y = -8; 
					}
				break;
				
				case 39:
					buttons['right'] = true;
					if(Main.hero.currentMovie!='run')Main.hero.changeMovie('run');
				break;
				
				case 40:
					buttons['down'] = true;
				break;
				
				case 80:
					if (Main.we.worldTimer.running) {
						Main.mm.add(new PauseScreen());
					}else {
						Main.mm.remove(Main.mm.list[Main.mm.list.length - 1]);
					}
				break;
				
				case 82:
					Main.gp.mui.restart();
				break;
			}
		}
		
		public function isPressed(s:String):Boolean 
		{
			return buttons[s];
		}
		
	}
	
}