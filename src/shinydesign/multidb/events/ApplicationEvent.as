package shinydesign.multidb.events
{
	import flash.events.Event;
	
	import shinydesign.multidb.models.vo.ApplicationConfig;
	import shinydesign.multidb.models.vo.BrowserVariables;
	
	public class ApplicationEvent extends Event
	{
		///Main Application Events
		
		public static const BROWSER_READY:String="browserReady";
		public static const QUERY_STRING_SET:String="queryStringSet";
		public static const LOAD_CONFIG:String = "loadConfig";
		public static const CONFIG_LOADED:String = "configLoaded";
		public static const CONFIG_MODEL_BROWSER_UPDATED:String="configModelBrowserUpdated";
		public static const CONFIG_MODEL_UPDATED:String = "configModelUpdated";
		
		public var applicationConfig:ApplicationConfig;
		public var browserVariables:BrowserVariables;
		
		public function ApplicationEvent(type:String, applicationConfig:ApplicationConfig = null,browserVariables:BrowserVariables=null)
		{
			trace("Event >> ApplicationEvent >> " + type);
			this.applicationConfig=applicationConfig;
			this.browserVariables=browserVariables;
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new ApplicationEvent(this.type,this.applicationConfig,this.browserVariables);
		}
	}
}