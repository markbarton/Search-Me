package shinydesign.multidb.events
{
	import flash.events.Event;
	
	import shinydesign.multidb.models.vo.CrisisRecords;
	import shinydesign.multidb.models.vo.DataCell;
	
	
	//This classes deals with loading and handling the crisis data event
	public class CrisisDataEvent extends Event
	{
		
		public static const LOAD_DATA:String = "loadCrisisData";
		//Data loaded from service
		public static const DATA_LOADED:String = "crisisDataLoaded";
		//Model updated with parsed Data
		public static const MODEL_UPDATED:String = "crisisModelUpdated";
		//Data Cell Modified
		public static const DATAGRID_CELL_CHANGED:String = "crisisDataCellChanged";
		
		public var urlEndPointKey:String;
		public var crisis:CrisisRecords;
		public var dataCell:DataCell; //Used to define the contents of a 
		
		public function CrisisDataEvent(type:String,urlEndPointKey:String=null, crisis:CrisisRecords=null,dataCell:DataCell=null)
		{
			trace("Event >> CrisisDataEvent >> "+ type + ", " + urlEndPointKey);
			this.urlEndPointKey=urlEndPointKey;
			this.crisis=crisis;
			this.dataCell=dataCell;
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new CrisisDataEvent(this.type,this.urlEndPointKey,this.crisis,this.dataCell);
		}
	}
}