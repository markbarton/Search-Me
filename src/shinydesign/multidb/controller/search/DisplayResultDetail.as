package shinydesign.multidb.controller.search
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.SearchInputEvent;
	import shinydesign.multidb.models.SearchResultModel;
	
	public class DisplayResultDetail extends Command
	{
		[Inject]
		public var event:SearchInputEvent; //Event carries query + urlEndPointKey + searchResult Object
		
		[Inject]
		public var model:SearchResultModel; //Search Result Model needs the currently selected result to be set
		
		override public function execute():void
		{
			trace("Command>> DisplayResultDetail >> ");
			//Update Model
			model.selectedSearchResult=event.searchResult;
			//Main Meditator will respond to the event the model dispatches to change the view - the new view will get selected result from model
		}
	}
}