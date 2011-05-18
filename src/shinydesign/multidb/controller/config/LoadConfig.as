package shinydesign.multidb.controller.config
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.ApplicationEvent;
	import shinydesign.multidb.services.IConfigService;
	
	public class LoadConfig extends Command
	{
		[Inject]
		public var event:ApplicationEvent;
		
		[Inject]
		public var service:IConfigService;
		
		override public function execute():void
		{
			trace("Command>> loadConfig");
			service.loadConfig();
		}
	}
}