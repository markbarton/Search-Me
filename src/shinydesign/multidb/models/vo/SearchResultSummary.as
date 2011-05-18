package shinydesign.multidb.models.vo
{
	[Bindable]
	public class SearchResultSummary
	{
		private var _numberResults:int; //Number of results for this search (i.e. if paging this will be a subset of the total)
		private var _errorString:String; //If there was an error it will be held ghere
		private var _endCount:int; // For paging this is the end count
		private var _startCount:int; //For paging this is the start counter
		private var _totalCount:int; //Total numner of documents found
		private var _cacheDocUNID:String; //UNID of the cache document for paging resutls
		private var _query:String; //Query used for these resutls
		private var _log:String;
		
		public function get log():String
		{
			return _log;
		}

		public function set log(value:String):void
		{
			_log = value;
		}

		public function get query():String
		{
			return _query;
		}

		public function set query(value:String):void
		{
			_query = value;
		}

		public function get cacheDocUNID():String
		{
			return _cacheDocUNID;
		}

		public function set cacheDocUNID(value:String):void
		{
			_cacheDocUNID = value;
		}

		public function get totalCount():int
		{
			return _totalCount;
		}

		public function set totalCount(value:int):void
		{
			_totalCount = value;
		}

		public function get startCount():int
		{
			return _startCount;
		}

		public function set startCount(value:int):void
		{
			_startCount = value;
		}

		public function get endCount():int
		{
			return _endCount;
		}

		public function set endCount(value:int):void
		{
			_endCount = value;
		}

		public function get errorString():String
		{
			return _errorString;
		}

		public function set errorString(value:String):void
		{
			_errorString = value;
		}

		public function get numberResults():int
		{
			return _numberResults;
		}

		public function set numberResults(value:int):void
		{
			_numberResults = value;
		}

	}
}