package shinydesign.multidb.models.vo
{
		import shinydesign.multidb.utils.HashMap;
	
	//Holds a collection of custom grid columns - will be populated via a service parsing the inbound column definitions
	public class CustomGridColumns
	{
		private var _customGridColumns:HashMap;
		private var _totalWidth:int;
		
		public function get totalWidth():int
		{
			return _totalWidth;
		}

		public function set totalWidth(value:int):void
		{
			_totalWidth = value;
			
		}

		public function get customGridColumns():HashMap
		{
			return _customGridColumns;
		}

		public function set customGridColumns(value:HashMap):void
		{
			
			_customGridColumns = value;
		}
		
		public function sortColumns():void{
			var sortArray:Array=new Array();
			for ( var key:* in _customGridColumns.getEntries() )
			{
				sortArray.push(key);
			}
			// sort the indexed array based on the "order" property
			sortArray.sortOn("SortOn", Array.NUMERIC);
			
			
		}

	}
}