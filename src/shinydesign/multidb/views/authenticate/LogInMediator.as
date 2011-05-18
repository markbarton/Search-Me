package shinydesign.multidb.views.authenticate
{
	import mx.events.ValidationResultEvent;
	import mx.validators.StringValidator;
	
	import org.robotlegs.mvcs.Mediator;
	
	import shinydesign.multidb.events.AuthenticationEvent;
	 
	public class LogInMediator extends Mediator
	{
		[Inject]
		public var view:LogIn;
		
		public var stringVal:StringValidator = new StringValidator();
		
		override public function onRegister():void
		{
			trace("Mediator >> LogIn");
			//Listen for the login button
			eventMap.mapListener(view, AuthenticationEvent.VIEW_LOGIN_SUBMIT, AttemptLogin)
		}
		
		
		public function AttemptLogin(event:AuthenticationEvent):void{
		//Validate First
			trace("Mediator >> Login >> Attempting to Login");	
			var valResult:ValidationResultEvent; 
			//stringVal.source = view.username; 
			stringVal.property = "text"; 
			valResult=stringVal.validate();
			trace(valResult);
			
			if(valResult.type!="invalid"){
				//Validation Passed therefore dispatch the Login Requiest
		//		dispatch(new AuthenticationEvent(AuthenticationEvent.LOAD_LOGIN_SERVICE,view.username.text,view.password.text));
			}
		}
	}
}