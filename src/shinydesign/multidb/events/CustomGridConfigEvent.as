package shinydesign.multidb.events
{
	import flash.events.Event;
	
	import shinydesign.multidb.models.CustomGridModel;

	//This class is used to dispatch when the custom data grid has been built, loaded etc.
	
	public class CustomGridConfigEvent extends Event
	{
		public static const MODEL_UPDATED:String = "customDataGridModelUpdated";
		public static const LOAD_CUSTOM_GRID_CONFIG:String = "loadCustomDataGridConfig";
		public static const CUSTOM_GRID_LOADED:String = "customDataGridConfigLoaded";
		public static const TOTAL_WIDTH_SET:String="totalWidthSet";
		public var customGridModel:CustomGridModel;
		
		public function CustomGridConfigEvent(type:String,customGridModel:CustomGridModel=null)
		{
			trace("EVENT >> CustomGridConfigEvent >> " + type);
			this.customGridModel=customGridModel;
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new CustomGridConfigEvent(this.type,this.customGridModel);
		}
	}
}