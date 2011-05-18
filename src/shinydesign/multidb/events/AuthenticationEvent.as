package shinydesign.multidb.events
{
	import flash.events.Event;
	
	public class AuthenticationEvent extends Event
	{
		
		//When button in view is clicked
		public static const VIEW_LOGIN_SUBMIT:String = "viewLoginSubmit";
		//When validation has been passed and the Login Service needs to be caled
		public static const LOAD_LOGIN_SERVICE:String = "loadLoginService";
		
		public var username:String;
		public var password:String;
		
		public function AuthenticationEvent(type:String,username:String=null,password:String=null)
		{
			trace("Event >> AuthenticationEvent >> " + type);
			this.username=username;
			this.password=password;
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new AuthenticationEvent(this.type,this.username,this.password);
		}
		
	}
}