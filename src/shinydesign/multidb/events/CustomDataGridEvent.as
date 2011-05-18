package shinydesign.multidb.events
{
	import flash.events.Event;
	
	import shinydesign.multidb.models.vo.DataCell;
	//This event is used for capturing wen a data cell has been changed
	
	public class CustomDataGridEvent extends Event
	{
		
		public static const DATA_CHANGED:String = "dataChanged";
		public var dataCell:DataCell;
		
		public function CustomDataGridEvent(type:String,dataCell:DataCell=null)
		{
			this.dataCell=dataCell;
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new CustomDataGridEvent(this.type,this.dataCell);
		}
	}
}