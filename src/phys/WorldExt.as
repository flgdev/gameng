package phys
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import Box2D.Dynamics.b2DebugDraw;
	import system.Fps;
	
	public class WorldExt 
	{
		private var debugOn:Boolean = Boolean(0);
		public var world:b2World;
		public var worldTimer:Timer;
		public var SCALE:Number = 30;
		private var contactcallback:ContactHandler;
		private var debug_sprite:Sprite;
		public var cam:b2Vec2;
		public var bodyA:b2Body;
		public var bodyB:b2Body;
		
		public function WorldExt():void {
			cam = new b2Vec2(0,0);
			world = new b2World(new b2Vec2(0, 10), true);
			contactcallback = new ContactHandler();
			world.SetContactListener(contactcallback);
			//contactcallback.callback = callback;
			if(debugOn){
				debug_sprite = new Sprite();
				DebugDraw();
			}
			worldTimer = new Timer(33);
			worldTimer.addEventListener(TimerEvent.TIMER, updateWorld);
			worldTimer.start();
		}
		
		private function updateWorld(e:TimerEvent):void {
			Fps.step(); // считаем
			//trace("fps: "+Fps.fps+", delta: "+Fps.delta);//Math.round(1 / Fps.delta)
			Main.gp.mui.u['fps_lbl'].text = 'FPS: ' + String(Fps.fps);
			world.Step(1 / SCALE, 10, 10);
			if(Obj.bodyList!= null)
			for (var j:int = Obj.bodyList.length-1;j>-1;j--)
			{
				Obj.bodyList[j].setMoviePos();
				if (Obj.bodyList[j] is Joint) { 
					if (Main.cr.isPressed('up')) Joint(Obj.bodyList[j]).joint.SetMotorSpeed(Joint(Obj.bodyList[j]).joint.GetMotorSpeed()-1); 
					if (Main.cr.isPressed('down')) Joint(Obj.bodyList[j]).joint.SetMotorSpeed(Joint(Obj.bodyList[j]).joint.GetMotorSpeed() + 1); 
					if (Joint(Obj.bodyList[j]).joint.GetMotorSpeed() > 10) Joint(Obj.bodyList[j]).joint.SetMotorSpeed(10);
					if (Joint(Obj.bodyList[j]).joint.GetMotorSpeed() < -10) Joint(Obj.bodyList[j]).joint.SetMotorSpeed(-10);
				}
				if (Obj.bodyList[j].updateNd) { Obj.bodyList[j].update(); }
				if (Obj.bodyList[j].deleteNd) { Obj.bodyList[j].die(); }
			}
			Main.gp.update();
			if (debugOn) {
				debug_sprite.x = Main.we.cam.x;
				debug_sprite.y = Main.we.cam.y;
				Main.mm.clip.setChildIndex(debug_sprite, Main.mm.clip.numChildren - 1);
				world.DrawDebugData();
			}
			Main.gp.sprs[5].x = cam.x;
			Main.gp.sprs[5].y = cam.y;
			world.ClearForces();
		}
		
		public function free():void 
		{
			var i:int;
			worldTimer.stop();
			for (i = 0; i < Obj.bodyList.length; i++) {
				Obj.bodyList[i].free();
			}
		}
		
		private function DebugDraw():void
		{
			var debug_draw:b2DebugDraw = new b2DebugDraw();
			debug_sprite.x = 0;
			debug_sprite.y = 0;
			Main.mm.clip.addChild(debug_sprite);
			debug_draw.SetSprite(debug_sprite);
			debug_draw.SetFillAlpha(0.5);
			debug_draw.SetAlpha(1);
			debug_draw.SetDrawScale(SCALE);
			debug_draw.SetFlags(b2DebugDraw.e_shapeBit);
			world.SetDebugDraw(debug_draw);
		}
		
	}
	
}