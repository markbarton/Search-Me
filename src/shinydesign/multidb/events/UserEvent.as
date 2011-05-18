package shinydesign.multidb.events
{
	import flash.events.Event;
	
	public class UserEvent extends Event
	{
		//This event contains everything to do with the user
		public static const AUTHENTICATE_USER:String = "authenticateUser";
		public static const USER_FAILED_LOGIN:String = "userFailedLogin";
		public static const USER_LOGGED_IN:String = "userLoggedIn";
		public static const USER_LOGGED_OUT:String = "userLoggedOut";
		public static const USER_MODEL_UPDATED:String="userModelUpdated";
		
		public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			trace("Event >> UserEvent >> " + type);
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new UserEvent(this.type);
		}
	}
}