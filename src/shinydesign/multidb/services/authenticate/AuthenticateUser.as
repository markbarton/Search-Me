package shinydesign.multidb.services.authenticate
{
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Actor;
	
	import shinydesign.multidb.events.UserEvent;
	import shinydesign.multidb.models.ApplicationConfigModel;
	
	public class AuthenticateUser extends Actor implements IAuthenticate
	{
		
		[Inject]
		public var applicationConfigModel:ApplicationConfigModel;
		//We need the application config model as it will tell us where the endpoint is
		
		private var _username:String;
		private var _password:String;
		
		public function AuthenticateUser()
		{
			trace("Service >> Authenticate User");
			
			super();
		}
		
		public function get username():String
		{
			return _username;
		}

		public function set username(value:String):void
		{
			_username = value;
		}

		public function get password():String
		{
			return _password;
		}

		public function set password(value:String):void
		{
			_password = value;
		}

		public function sendLogin():void
		{
			trace("Service >> Authenticate User >> sendLogin");
			//Attempt to login to the server
			//Currently assume session based authentication
			var service:HTTPService = new HTTPService();
			var responder:Responder = new Responder(handleServiceResult, handleServiceFault);
			var token:AsyncToken;
			service.resultFormat = "e4x";
			service.request="POST";
			service.url = applicationConfigModel.applicationConfig.RemoteDominoServer + applicationConfigModel.applicationConfig.AuthenticationLoginEndPoint;
			//prevent caching    
			var params:Object=new Object;
			params.nocache=Math.round(Math.random()*1000);
			//These will be posted  - values set via the command which has this service injected into it  
			params.username=this.username
			params.password=this.password;
			//Get the user.xml file from your Domino application
			params.RedirectTo=applicationConfigModel.applicationConfig.RemoteDominoServer + applicationConfigModel.applicationConfig.LoginSuccessRedirection;
			token = service.send(params);
			token.addResponder(responder);
		}
		
		
		//We should move this out to a parsing class
		protected function handleServiceResult(event:Object):void{
			trace("Service >> AuthenticateUser >> HandleServiceResult");
			if(event.result.username!=""||event.result.username!="anonymous"){
				dispatch(new UserEvent(UserEvent.USER_LOGGED_IN));
			}
			trace("username="+event.result.username);
			//dispatch(new ApplicationEvent(ApplicationEvent.CONFIG_LOADED,config));
			
		} 
		
		protected function handleServiceFault(event:Object):void
		{
			trace(event);
			
		}
		
		public function isLoggedIn():void
		{
			trace("Service >> Authenticate User >> isLoggedIn");
			
		}
	}
}