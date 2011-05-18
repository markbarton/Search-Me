package shinydesign.multidb.controller.config
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.services.dominodata.IDominoXMLService;
	
	public class LoadCustomGridConfig extends Command
	{
		
		[Inject(name="ConfigXML")]
		public var service:IDominoXMLService;
		
		override public function execute():void
		{
			trace("Command>> loadCustomGridConfig");
			service.getDominoData("CustomGridConfig");
		}
	}
}