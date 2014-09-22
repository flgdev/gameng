package phys
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import ui.GamePlay;
	
	public class Joint extends Obj
	{
		
		[Inspectable(type="List", enumeration="Distance,Revolute,Prismatic,Pulley,Gear,Mouse,Weld,Friction,Line", defaultValue="Distance")]
		public var type:String = "Distance";
		private var bodyA:b2Body;
		private var bodyB:b2Body;
		public var joint:b2RevoluteJoint;
		
		public function Joint() 
		{
			super();
		}
		
		override public function init():void 
		{
			super.init();
		}
		
		override public function update():void 
		{
			
		}
		
		override protected function makeBody():void 
		{	
			//return;
			Main.we.world.QueryPoint(getbody, new b2Vec2(x / Main.we.SCALE, y / Main.we.SCALE));
			if (bodyB == null) { bodyB = Main.we.world.GetGroundBody(); }
			makeBodyEnd();
		}
		
		private function getbody(fixture:b2Fixture):Boolean 
		{
			if (bodyA == null) { bodyA = fixture.GetBody(); return true; }
			if (bodyA != null) { bodyB = fixture.GetBody(); }
			return false;
		}
		
		public override function setMoviePos():void 
		{
			if(joint != null){
				pos = joint.GetAnchorA();
				angle = joint.GetJointAngle();
			}					
			super.setMoviePos();
		}
		
		private function makeBodyEnd():void
		{
			var jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			jointDef.collideConnected = false;
			jointDef.enableMotor = true;
			jointDef.motorSpeed = 0;
			jointDef.maxMotorTorque = 100;
			jointDef.Initialize(bodyA, bodyB, new b2Vec2(x / Main.we.SCALE,y / Main.we.SCALE));
			joint = Main.we.world.CreateJoint(jointDef) as b2RevoluteJoint;
			bodyA = null; bodyB = null;
		}
		
		
		
	}
	
}