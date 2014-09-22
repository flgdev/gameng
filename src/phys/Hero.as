package phys
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import ui.GamePlay;
	
	public class Hero extends Form
	{
		
		private var speedLimit:Number = 4;
		private var horAcc:Number = 0.4;
		
		public function Hero() 
		{
			super();
			Main.hero = this;
			updateNd = true;
		}
		
		override public function update():void 
		{
			//if ((currentMovie == 'breath') && (Math.abs(body.GetLinearVelocity().y) < 0.01)  && (clip.y>440)) changeMovie('breath');
			
			var vec:b2Vec2;
			if (Main.cr.isPressed('right') == true) { 
				vec = body.GetLinearVelocity();
				vec.x += horAcc;
				scaleX = 1;
				if (vec.x > speedLimit) vec.x = speedLimit;
			}
			
			if (Main.cr.isPressed('left') == true) { 
				vec = body.GetLinearVelocity();
				vec.x -= horAcc;
				scaleX = -1;
				if (vec.x < -speedLimit) vec.x = -speedLimit;
			}
			
		}
		
	}
	
}