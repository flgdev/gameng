package phys
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import ui.GamePlay;
	
	public class Obj extends MovieClip
	{
		
		public static var bodyList:Array;
		public var body:b2Body = null;
		public var updateNd:Boolean = false;
		public var deleteNd:Boolean = false;
		public var pos:b2Vec2;
		public var angle:Number;
		public var currentMovie:String;
		
		public function Obj() 
		{
			bodyList.push(this);
		}
		
		public function init():void
		{
			deleteNd = false;
			
			if ((parent.parent != Main.gp.clip)&&(parent.name!='scene')) {
				var ang1:Number = rotation;
				var ang2:Number = parent.rotation;
				rotation = 0;
				parent.rotation = 0;
				this.width = parent.width;
				this.height = parent.height;
				rotation = ang1;
				parent.rotation = ang2;
				
				parent.removeChild(this);
				Main.gp.sprs[1].addChild(this);
			}
			
			if (parent.name == 'scene') {
				parent.removeChild(this);
				Main.gp.sprs[1].addChild(this);
			}
			
			makeBody();
		}
		
		public function update():void 
		{
			
		}
		
		public function free():void 
		{
			if (body != null) Main.we.world.DestroyBody(body);
			if (parent != null){ stop(); parent.removeChild(this); }
			bodyList.splice(bodyList.indexOf(this),1);
		}
		
		public function die():void 
		{
			if (body != null) Main.we.world.DestroyBody(body);
			if (parent != null) changeMovie('die');
		}
		
		public function setMoviePos():void 
		{
			if(body != null){
				pos = body.GetPosition();
				angle = body.GetAngle();
			}			
			if(pos != null){
				x = pos.x * Main.we.SCALE + Main.we.cam.x;
				y = pos.y * Main.we.SCALE + Main.we.cam.y;
				rotation = angle / Math.PI * 180;
			}
		}
		
		public function changeMovie(s:String):void
		{
			if (currentMovie == s) return;
			gotoAndPlay(s);
			currentMovie = s;
		}
		
		protected function makeBody():void 
		{
			
		}
		
	}
	
}