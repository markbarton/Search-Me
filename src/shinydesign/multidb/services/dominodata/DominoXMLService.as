package shinydesign.multidb.services.dominodata
{
	import mx.managers.CursorManager;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Actor;
	
	import shinydesign.multidb.models.ApplicationConfigModel;
	
	
	public class DominoXMLService extends Actor implements IDominoXMLService
	{
		private var _EndPointKey:String;
		private var _params:Object=new Object;
		
		[Inject]
		public var applicationConfigModel:ApplicationConfigModel;
		//We need the application config model as it will tell us where the endpoint is
		
		
		public function get params():Object
		{
			return _params;
		}

		public function set params(value:Object):void
		{
			_params = value;
		}

		public function get EndPointKey():String
		{
			return _EndPointKey;
		}

		public function set EndPointKey(value:String):void
		{
			_EndPointKey = value;
		}

		public function getDominoData(EPKey:String=null):void
		{trace("Service >> DominoData >> getDominoData >>" + EPKey);
			//Add busy cursor
			CursorManager.setBusyCursor();	
			//Get EndPoint from value if passed - else from class property - else we can not continue
			this.EndPointKey=EPKey;
			var endURL:String;
			endURL=	applicationConfigModel.applicationConfig.URLEndPoints.getValue(EPKey);
			
			trace("EndPoint = "+endURL);
			
			//Attempt to login to the server
			//Currently assume session based authentication
			var service:HTTPService = new HTTPService();
			var responder:AsyncResponder = new AsyncResponder(handleServiceResult, handleServiceFault,this.EndPointKey);
			var token:AsyncToken;
			service.resultFormat = "e4x";
			service.url = applicationConfigModel.applicationConfig.RemoteDominoServer + endURL;
			//prevent caching    
				params.nocache=Math.round(Math.random()*1000);
			//These will be posted  - values set via the command which has this service injected into it  
			token = service.send(params);
			token.addResponder(responder);
			
		}
		
		public function handleServiceResult(event:Object,endPointKey:String):void
		{
			CursorManager.removeBusyCursor();
			//Parse the data and then broadcast so the model can be updated with the VO
			trace(event.result.DOCUMENT);
			
			
		}
		
		public function handleServiceFault(event:Object,endPointKey:String):void
		{	trace(event);
		}
	}
}