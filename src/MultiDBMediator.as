package
{
	import org.robotlegs.mvcs.Mediator;
	
	import shinydesign.components.dualpanel.DeferredDualPanel;
	import shinydesign.multidb.events.SearchInputEvent;
	import shinydesign.multidb.events.SearchResultEvent;
	import shinydesign.multidb.events.UserEvent;

	public class MultiDBMediator extends Mediator
	{
		[Inject]
		public var view:MultiSearchV5;
		
		override public function onRegister():void
		{
			trace("Mediator>> MultiDatabaseSearch");
			//Listen for the require authentication to change the state
			//adding an event listener to the Context for framework events
			eventMap.mapListener( eventDispatcher,UserEvent.AUTHENTICATE_USER, authenticateUser );
			eventMap.mapListener( eventDispatcher,UserEvent.USER_LOGGED_IN, handleLogin );
			eventMap.mapListener( eventDispatcher,SearchResultEvent.SEARCH_RESULTS_LOADED, handleResults );
			eventMap.mapListener( eventDispatcher,SearchInputEvent.DISPLAY_SEARCH_SUMMARY, handleSummary );
			eventMap.mapListener( eventDispatcher,SearchResultEvent.SEARCH_MODEL_SELECTEDRESULTSET, handleDetail );
			eventMap.mapListener(eventDispatcher,SearchInputEvent.CLOSE_DISPLAY_DETAIL,function():void{view.resultsPanel.setState("front");});
			eventMap.mapListener(eventDispatcher,SearchInputEvent.CLOSE_SEARCH_SUMMARY,function():void{view.currentState="results"});
			
			//adding an event listener to the view component being mediated
			//addEventListenerTo( myCustomComponent, MyCustomEvent.DID_SOME_STUFF, handleDidSomeStuff)
		} 
		
		protected function authenticateUser(event:UserEvent):void
		{
			//setting a property on the view component from the
			//strongly typed event payload. The view component
			//will likely manage its own state based on this
			//new data.
			trace("Mediator>> MultiDatabaseSearch>> handleLogin");
			//Makeing the Login view visible by change the application state = login
			view.currentState="login";
		}
		
		protected function handleLogin(event:UserEvent):void{
			
			view.currentState="loggedIn";
		}
		
		protected function handleResults(event:SearchResultEvent):void{
			trace("Changing currentstate = results");
			view.currentState="results";
		}
		protected function handleSummary(event:SearchInputEvent):void{
			trace("Changing currentstate = searchSummary");
			view.currentState="searchSummary";
			view.summarySearch.visible=true;
			
		}
		
		protected function handleDetail(event:SearchResultEvent):void{
			trace("Changing currentstate = searchDetail");
			view.resultsPanel.setState("back");
		}
		
		
	}
}