package shinydesign.multidb.views.search
{
	import org.robotlegs.mvcs.Mediator;
	
	import shinydesign.components.dualpanel.DeferredDualPanel;
	import shinydesign.multidb.events.SearchInputEvent;
	public class DefferedPanelMediator extends Mediator
	{
		
		[Inject]
		public var view:shinydesign.components.dualpanel.DeferredDualPanel;
		
		override public function onRegister():void
		{
			trace("Mediator >> DefferedDualPanel");
			eventMap.mapListener(eventDispatcher,SearchInputEvent.SEARCH_SUBMITTED,CheckPanel);
			}
		
		private function CheckPanel(event:SearchInputEvent):void{
			trace ("Check Panel: " + view.skin.currentState);
			if(view.skin.currentState=="back")
				view.setState("front");
		} 
		
	}
}