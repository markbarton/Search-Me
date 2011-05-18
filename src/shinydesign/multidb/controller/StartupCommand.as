package shinydesign.multidb.controller
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.ApplicationEvent;
	import shinydesign.multidb.services.BrowserService;
	
	public class StartupCommand extends Command
	{
		[Inject]
		public var service:BrowserService;
			
		override public function execute():void
		{	
			//logger.debug("Startup = dispatching Application Event - LOAD_CONFIG");
			trace("Command>> StartupCommand");
			service.CheckBrowserReady();
			} 
	}
} 