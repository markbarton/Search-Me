package shinydesign.multidb.events
{
	import flash.events.Event;
	
	//This event is used for loading remote data
	//It requires a URL endpoint which is then used to extract the corect endpoint from the config document
	public class LoadDataEvent extends Event
	{
		
		public static const LOAD_DATA:String = "loadData";
		public var urlEndPointKey:String;
		
		public function LoadDataEvent(type:String, urlEndPointKey:String=null)
		{
			this.urlEndPointKey=urlEndPointKey;
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadDataEvent(this.type,this.urlEndPointKey);
		}
	}
}