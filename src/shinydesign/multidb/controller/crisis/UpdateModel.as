package shinydesign.multidb.controller.crisis
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.CrisisDataEvent;
	import shinydesign.multidb.models.CrisisModel;
	
	public class UpdateModel extends Command
	{
		[Inject]
		public var event:CrisisDataEvent;
		
		[Inject]
		public var model:CrisisModel;
		
		override public function execute():void
		{
			trace("Command>> UpdateModel >> " + event.urlEndPointKey);
			model.crisisRecords=event.crisis;
		}
	}
}