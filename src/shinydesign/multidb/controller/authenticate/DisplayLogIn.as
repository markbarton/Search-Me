package shinydesign.multidb.controller.authenticate
{
	
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.CustomGridConfigEvent;
	import shinydesign.multidb.events.UserEvent;
	import shinydesign.multidb.models.ApplicationConfigModel;
	import shinydesign.multidb.services.IConfigService;
	import shinydesign.multidb.views.authenticate.LogIn;

	public class DisplayLogIn extends Command
	{
		[Inject]
		public var event:CustomGridConfigEvent;
		
		[Inject]
		public var applicationConfigModel:ApplicationConfigModel;
		
		override public function execute():void
		{
			trace("Command>> DisplayLogin");
			
			//We only need tp authenticate if the config says so
			if(applicationConfigModel.applicationConfig.AuthenticateUser==true){
				trace("Going to authenticate user");
				//To do this we need to present a LogIn View which will then submit to the Authenticate Service
				dispatch(new UserEvent(UserEvent.AUTHENTICATE_USER));	
			}else{
				trace("No Need to Authenticate");
				dispatch(new UserEvent(UserEvent.USER_LOGGED_IN));
						
			}
		}
	}
}