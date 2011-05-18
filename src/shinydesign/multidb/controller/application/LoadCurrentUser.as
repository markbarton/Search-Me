package shinydesign.multidb.controller.application
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.UserEvent;
	import shinydesign.multidb.services.dominodata.IDominoXMLService;
	import shinydesign.multidb.services.dominodata.user.CurrentUserService;
	
	public class LoadCurrentUser extends Command
	{
		[Inject(name="CurrentUser")]
		public var service:IDominoXMLService;
		
		override public function execute():void
		{
			trace("Command>> LoadCurrentUser >> ");
			service.getDominoData("CurrentUser");
		}
	}
}