package shinydesign.multidb.views.search
{
	import flash.events.KeyboardEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import shinydesign.multidb.events.ApplicationEvent;
	import shinydesign.multidb.events.SearchInputEvent;
	import shinydesign.multidb.events.UserEvent;
	import shinydesign.multidb.models.ApplicationConfigModel;
	import shinydesign.multidb.models.CurrentUserModel;
	
	public class SearchInputMediator extends Mediator
	{
		[Inject]
		public var view:SearchInput;
		[Inject]
		public var appConfigModel:ApplicationConfigModel;
		[Inject]
		public var currentUserModel:CurrentUserModel;
		
		override public function onRegister():void
		{
			trace("Mediator >> SearchInput");
			//Listen for the search input changing
			eventMap.mapListener(view, SearchInputEvent.SEARCH_SUBMITTED, RelayEvent);	
			eventMap.mapListener(view, SearchInputEvent.DISPLAY_SEARCH_SUMMARY, RelayEvent);	
			eventMap.mapListener(view,KeyboardEvent.KEY_DOWN,checkKey);
			eventMap.mapListener(eventDispatcher,ApplicationEvent.QUERY_STRING_SET,RunWithQueryString);
			eventMap.mapListener(eventDispatcher,UserEvent.USER_MODEL_UPDATED,DisplayAdminButton);
			//Need to check if the query has already been set
			if(appConfigModel.browserVariables.Query!=null)
			{ 
				view.search.text=appConfigModel.browserVariables.Query;
				dispatch(new SearchInputEvent(SearchInputEvent.SEARCH_SUBMITTED,view.search.text,"SearchResults"));	
			}
			if(currentUserModel.currentUser!=null)
			DisplayAdminButton(null);
		}
		//If an Admin then display the search summary button
		protected function DisplayAdminButton(event:UserEvent):void{
			if(currentUserModel.isMember("Admin")){
				view.summaryButton.visible=true;
			}
		}
	
		//If a query string is passed into the application perform the search straight away by setting the input value on the view and dispath event
		protected function RunWithQueryString(event:ApplicationEvent):void{
			view.search.text=event.browserVariables.Query;
			dispatch(new SearchInputEvent(SearchInputEvent.SEARCH_SUBMITTED,view.search.text,"SearchResults"));
		}
		
		protected function RelayEvent(event:SearchInputEvent):void
		{
			//relaying the event to the framework + Unique Identifier for loading external data
			event.urlEndPointKey="SearchResults";
			dispatch(event)
		}
		
		protected function checkKey(event:KeyboardEvent):void
		{
			if(event.charCode == 13)
				dispatch(new SearchInputEvent(SearchInputEvent.SEARCH_SUBMITTED,view.search.text,"SearchResults"));
		}
	}
}