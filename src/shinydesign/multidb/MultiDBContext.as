package shinydesign.multidb
{
	import flash.display.DisplayObjectContainer;
	import flash.system.Security;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Context;
	
	import shinydesign.components.dualpanel.DeferredDualPanel;
	import shinydesign.multidb.controller.*;
	import shinydesign.multidb.controller.application.*;
	import shinydesign.multidb.controller.authenticate.*;
	import shinydesign.multidb.controller.config.*;
	import shinydesign.multidb.controller.crisis.*;
	import shinydesign.multidb.controller.search.*;
	import shinydesign.multidb.events.*;
	import shinydesign.multidb.models.*;
	import shinydesign.multidb.services.*;
	import shinydesign.multidb.services.authenticate.*;
	import shinydesign.multidb.services.dominodata.*;
	import shinydesign.multidb.services.dominodata.crisis.*;
	import shinydesign.multidb.services.dominodata.customgridconfig.*;
	import shinydesign.multidb.services.dominodata.searchresults.*;
	import shinydesign.multidb.services.dominodata.user.CurrentUserService;
	import shinydesign.multidb.views.authenticate.*;
	import shinydesign.multidb.views.crisis.*;
	import shinydesign.multidb.views.search.*;
	 
	 
	public class MultiDBContext extends Context
	{
		override public function startup():void
		{
			//Commands first
			trace("Context>> Start");
			trace("Security = " + Security.sandboxType);
			commandMap.mapEvent( ContextEvent.STARTUP, StartupCommand, ContextEvent, true );
			//Browser Config Loaded, User Logged In
			commandMap.mapEvent(ApplicationEvent.BROWSER_READY,LoadConfig,ApplicationEvent)
			commandMap.mapEvent(ApplicationEvent.CONFIG_LOADED,LoadCurrentUser,ApplicationEvent)
			commandMap.mapEvent(ApplicationEvent.CONFIG_LOADED,LoadCustomGridConfig,ApplicationEvent)
				
			//Once we have the configs loaded we can then authenticate user (if required)
			commandMap.mapEvent(CustomGridConfigEvent.MODEL_UPDATED,DisplayLogIn,CustomGridConfigEvent , true)
			commandMap.mapEvent(AuthenticationEvent.LOAD_LOGIN_SERVICE,AttemptLogin,AuthenticationEvent , true)
			commandMap.mapEvent(LoadDataEvent.LOAD_DATA,LoadData,LoadDataEvent, true)
			//Map Load Crisis Dataevent to command
			commandMap.mapEvent(CrisisDataEvent.LOAD_DATA,CrisisLoadData,CrisisDataEvent,true)
			//commandMap.mapEvent(CrisisDataEvent.DATA_LOADED,UpdateModel,CrisisDataEvent,true)
			//Search Commands
			commandMap.mapEvent(SearchInputEvent.SEARCH_SUBMITTED,	ExecuteQuery,SearchInputEvent,false)
			commandMap.mapEvent(SearchResultEvent.SEARCH_RESULTS_LOADED,shinydesign.multidb.controller.search.UpdateModel,SearchResultEvent,false)
			commandMap.mapEvent(SearchInputEvent.DISPLAY_RESULT_DETAIL,DisplayResultDetail,SearchInputEvent,false)
				
			//map model
			injector.mapSingleton(ApplicationConfigModel);
			injector.mapSingleton(CrisisModel);
			injector.mapSingleton(CustomGridModel);
			injector.mapSingleton(SearchResultModel);
			injector.mapSingleton(CurrentUserModel);
			
			//map services
			injector.mapSingleton(BrowserService);
			injector.mapSingletonOf( IConfigService, ConfigService );
			injector.mapSingletonOf( IAuthenticate, AuthenticateUser );
			//Named services are injected into commands which call the services
			injector.mapSingletonOf( IDominoXMLService, CrisisXMLService, 'CrisisXML' );
			injector.mapSingletonOf( IDominoXMLService, CustomConfigXMLService, 'ConfigXML' );
			injector.mapSingletonOf( IDominoXMLService, SearchResultsXMLService, 'SearchResultsXML' );
			injector.mapSingletonOf( IDominoXMLService, CurrentUserService, 'CurrentUser' );
			
			
			// Configure Views - if this becomes too big, extract into ConfigureViewsCommand
			mediatorMap.mapView(LogIn, LogInMediator);
			mediatorMap.mapView(CrisisDataGrid, CrisisDataGridMediator);
			mediatorMap.mapView(SearchInput, SearchInputMediator);
			mediatorMap.mapView(ResultsGrid, ResultsGridMediator,null,true,false);
			mediatorMap.mapView(SummarySearch, SummarySearchMediator);
			mediatorMap.mapView(ResultDetail, ResultDetailMediator);
			mediatorMap.mapView(shinydesign.components.dualpanel.DeferredDualPanel,DefferedPanelMediator);
			
			mediatorMap.mapView( MultiSearchV5, MultiDBMediator );
			//Start the Application (triggers the StartupCommand)
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
			trace("Context>> Finish");
			
		}
	}
}