package shinydesign.multidb.controller.search
{
	import org.robotlegs.mvcs.Command;
	
	import shinydesign.multidb.events.SearchInputEvent;
	import shinydesign.multidb.models.ApplicationConfigModel;
	import shinydesign.multidb.services.dominodata.IDominoXMLService;
	
	public class ExecuteQuery extends Command
	{
		[Inject]
		public var event:SearchInputEvent; //Event carries query + urlEndPointKey
		
		[Inject(name="SearchResultsXML")]
		public var service:IDominoXMLService;
		
		[Inject]
		public var appModel:ApplicationConfigModel;
		
		override public function execute():void
		{
			trace("Command>> ExecuteQuery >> " + event.urlEndPointKey);
			trace("Command has been passed the following query : "+event.searchString);
			service.params.query=event.searchString;
			trace("Search Mail = "+ appModel.applicationConfig.SearchMail);
			//Special flag to the multi db search tool to search users mail files
			if(appModel.applicationConfig.SearchMail==true){
				service.params.groupid="MAIL";		
			}
			else{
				service.params.groupid="1";	
			}
			service.getDominoData(event.urlEndPointKey);
		}
	}
}