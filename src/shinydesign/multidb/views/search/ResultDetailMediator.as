package shinydesign.multidb.views.search
{
	import org.robotlegs.mvcs.Mediator;
	
	import shinydesign.multidb.events.SearchInputEvent;
	import shinydesign.multidb.models.SearchResultModel;
	
	public class ResultDetailMediator extends Mediator
	{
		[Inject]
		public var view:ResultDetail;
		[Inject]
		public var searchModel:SearchResultModel;
		
		override public function onRegister():void
		{
			trace("Mediator >> ResultDetail");
			//Get selected search result from Model and pass to the view
			view.searchRecord=searchModel.selectedSearchResult;
			eventMap.mapListener(view,SearchInputEvent.CLOSE_DISPLAY_DETAIL,RelayEvent);
		}
		
		protected function RelayEvent(event:SearchInputEvent):void
		{
			//relaying the event to the framework
			dispatch(event)
		}
	}
}