package shinydesign.multidb.controller.application
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.LoadDataEvent;
	import shinydesign.multidb.services.dominodata.IDominoXMLService;
	
	public class LoadData extends Command
	{
		[Inject]
		public var event:LoadDataEvent;
		
		[Inject]
		public var service:IDominoXMLService;
		
		override public function execute():void
		{
			trace("Command>> LoadData >> " + event.urlEndPointKey);
			service.getDominoData(event.urlEndPointKey);
		}
	}
}