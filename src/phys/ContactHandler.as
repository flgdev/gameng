package phys 
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	public class ContactHandler extends b2ContactListener {

		public var callback:Function;
		
		override public function BeginContact(contact:b2Contact):void 
		{			
			//callback(contact.GetFixtureA().GetBody(),contact.GetFixtureB().GetBody(),contact);
			super.BeginContact(contact);
		}
	
		override public function EndContact(contact:b2Contact):void 
		{
			super.EndContact(contact);
		}
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void 
		{
			super.PostSolve(contact, impulse);
		}
		
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void 
		{
			super.PreSolve(contact, oldManifold);
		}

	}
	
}
