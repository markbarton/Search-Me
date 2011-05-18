package shinydesign.multidb.models
{
	import org.robotlegs.mvcs.Actor;
	
	import shinydesign.multidb.events.ApplicationEvent;
	import shinydesign.multidb.models.vo.ApplicationConfig;
	import shinydesign.multidb.models.vo.BrowserVariables;
	
	public class ApplicationConfigModel extends Actor
	{
		
		private var _applicationConfig:ApplicationConfig;
		private var _browserVariables:BrowserVariables;
		
		public function get browserVariables():BrowserVariables
		{
			if(this._browserVariables==null)
				this._browserVariables=new BrowserVariables();
			return _browserVariables;
		}

		public function set browserVariables(value:BrowserVariables):void
		{
			trace("Model >> ApplicationConfigModel - set Browser Variables >> Set");
			
			_browserVariables = value;
			dispatch(new ApplicationEvent(ApplicationEvent.CONFIG_MODEL_BROWSER_UPDATED,null,value));
		}

		public function get applicationConfig():ApplicationConfig
		{
			if(this._applicationConfig==null)
				this._applicationConfig=new ApplicationConfig();
			trace("Model >> ApplicationConfigModel >> Get");
			return _applicationConfig;
		}

		public function set applicationConfig(value:ApplicationConfig):void
		{
			trace("Model >> ApplicationConfigModel >> Set");
			
			_applicationConfig = value;
			dispatch(new ApplicationEvent(ApplicationEvent.CONFIG_MODEL_UPDATED,value));
		}

	}
}