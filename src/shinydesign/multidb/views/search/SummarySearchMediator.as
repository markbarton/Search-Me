package shinydesign.multidb.views.search
{
	import org.robotlegs.mvcs.Mediator;
	
	import shinydesign.multidb.events.SearchInputEvent;
	import shinydesign.multidb.events.SearchResultEvent;
	import shinydesign.multidb.events.UserEvent;
	import shinydesign.multidb.models.CurrentUserModel;
	import shinydesign.multidb.models.SearchResultModel;
	
	public class SummarySearchMediator extends Mediator
	{
		
		[Inject]
		public var view:SummarySearch;
		[Inject]
		public var resultsModel:SearchResultModel; //Model for search results
		[Inject]
		public var currentUserModel:CurrentUserModel;
		
		override public function onRegister():void
		{
			trace("Mediator >> SummarySearch");
			//Listen for the search input changing
			eventMap.mapListener(view, SearchResultEvent.SEARCH_MODEL_RESULTSSUMMARY_UPDATED, updateSummary);	
			eventMap.mapListener(eventDispatcher,UserEvent.USER_MODEL_UPDATED,updateUser);
			eventMap.mapListener(view,SearchInputEvent.CLOSE_SEARCH_SUMMARY,RelayEvent);
			if(resultsModel.searchResultSummary!=null){
				updateSummary(null);
			}
			if(currentUserModel.currentUser!=null){
				updateUser(null);
			}
			
		}
		
		
		protected function RelayEvent(event:SearchInputEvent):void
		{
			//relaying the event to the framework - proably to be handled via the Main Mediator
			dispatch(event)
		}
		
		private function updateSummary(event:SearchResultEvent):void{
			view.searchSummary=resultsModel.searchResultSummary;
		}
		
		private function updateUser(event:UserEvent):void{
			view.currentUser=currentUserModel.currentUser;
		}
	}
}