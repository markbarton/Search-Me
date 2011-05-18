package shinydesign.multidb.controller.crisis
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.CrisisDataEvent;
	import shinydesign.multidb.services.dominodata.IDominoXMLService;
	
	public class CrisisLoadData extends Command
	{
		[Inject]
		public var event:CrisisDataEvent;
		
		[Inject(name="CrisisXML")]
		public var service:IDominoXMLService;
		
		override public function execute():void
		{
			trace("Command>> CrisisLoadData >> " + event.urlEndPointKey);
			service.getDominoData(event.urlEndPointKey);
		}
	
	}
}