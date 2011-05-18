package shinydesign.multidb.controller.search
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.SearchResultEvent;
	import shinydesign.multidb.models.SearchResultModel;
	
	public class UpdateModel extends Command
	{
		[Inject]
		public var event:SearchResultEvent;
		
		[Inject]
		public var model:SearchResultModel;
		
		override public function execute():void
		{
			trace("Command>> UpdateModel Search >> ");
			model.searchResultSummary=event.searchSummary;
			model.searchResultRecords=event.searchResults;
		}
	}
}