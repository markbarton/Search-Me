package shinydesign.multidb.controller.authenticate
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.AuthenticationEvent;
	import shinydesign.multidb.services.authenticate.IAuthenticate;
	
	public class AttemptLogin extends Command
	{
		
		[Inject]
		public var event:AuthenticationEvent;
		
		[Inject]
		public var service:IAuthenticate;
		
		override public function execute():void
		{
			trace("Command>> AttemptLogin");
			service.username=event.username;
			service.password=event.password;
			service.sendLogin();
		}
	}
}