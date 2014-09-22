package phys
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import ui.GamePlay;
	
	public class Form extends Obj
	{
		
		[Inspectable(type="Number", defaultValue="1")]
		public var alpha1:Number = 1;
		
		[Inspectable(type="Number", defaultValue="1")]
		public var density:Number = 1;
		
		[Inspectable(type="Number", defaultValue="0.1")]
		public var friction:Number = 0.1;
		
		[Inspectable(type="Number", defaultValue="65535")]
		public var maskBits:int = 65535;
		
		[Inspectable(type="Number", defaultValue="1")]
		public var categoryBits:int = 1;
		
		[Inspectable(type="Number", defaultValue="0.1")]
		public var restitution:Number = 0.1;
		
		[Inspectable(type="Number", defaultValue="0")]
		public var wsize:Number = 0;
		
		[Inspectable(type="Number", defaultValue="0")]
		public var hsize:Number = 0;
		
		[Inspectable(type="Number", defaultValue="0")]
		public var id:Number = 0;
		
		[Inspectable(type="List", enumeration="Static,Kinematic,Dynamic", defaultValue="Dynamic")]
		public var type:String = "Dynamic";
		
		[Inspectable(type="List", enumeration="Box,Circle", defaultValue="Box")]
		public var mode:String = "Box";
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var isSensor:Boolean = false;

		[Inspectable(type="Boolean", defaultValue="false")]
		public var fixedRotation:Boolean = false;
		
		[Inspectable(type="Boolean", defaultValue="true")]
		public var allowSleep:Boolean = true;
		
		[Inspectable(type="Boolean", defaultValue="false")]
		public var isBullet:Boolean = false;
		
		public function Form() 
		{
			super();
		}
		
		override public function init():void 
		{
			super.init();
			alpha = alpha1;
		}
		
		override public function update():void 
		{
			
		}
		
		override protected function makeBody():void 
		{
			var ang:Number = rotation;
			rotation = 0;
			if (wsize == 0) wsize = width;
			if (hsize == 0) hsize = height;
			rotation = ang;
			var my_body:b2BodyDef = new b2BodyDef();
			my_body.fixedRotation = fixedRotation;
			my_body.allowSleep = allowSleep;
			my_body.position.Set(x / Main.we.SCALE, y / Main.we.SCALE);
			my_body.angle = rotation/180*Math.PI;
			
			if (type == 'Static') my_body.type = b2Body.b2_staticBody;
			if (type == 'Kinematic') my_body.type = b2Body.b2_kinematicBody;
			if (type == 'Dynamic') my_body.type = b2Body.b2_dynamicBody;
			
			var my_fixture:b2FixtureDef = new b2FixtureDef();
			my_fixture.filter.categoryBits = categoryBits; 
			my_fixture.filter.maskBits = maskBits;
			my_fixture.density = density;
			my_fixture.friction = friction;
			my_fixture.restitution = restitution;
			
			if (mode == "Box"){
				var my_box:b2PolygonShape = new b2PolygonShape();
				my_box.SetAsBox(wsize / 2 / Main.we.SCALE, hsize / 2 / Main.we.SCALE);
				my_fixture.shape = my_box;
			}else {
				var my_cir:b2CircleShape = new b2CircleShape(wsize / 2 / Main.we.SCALE);
				my_fixture.shape = my_cir;
			}

			var world_body:b2Body = Main.we.world.CreateBody(my_body);
			world_body.SetUserData(this);
			world_body.CreateFixture(my_fixture);
			body = world_body;
		}
		
	}
	
}