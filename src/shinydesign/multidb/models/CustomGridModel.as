package shinydesign.multidb.models
{
	import org.robotlegs.mvcs.Actor;
	
	import shinydesign.multidb.utils.HashMap;
	
	//This class will hold a hash of Custom Data Grids
	
	public class CustomGridModel extends Actor
	{
		private var _customDataGrids:HashMap=new HashMap;
		public var tmp:String;
		
		public function get customDataGrids():HashMap
		{
			return _customDataGrids;
		}

		public function set customDataGrids(value:HashMap):void
		{
			_customDataGrids = value;
		}

	}
}