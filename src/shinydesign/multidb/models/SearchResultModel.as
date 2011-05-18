package shinydesign.multidb.models
{
	import org.robotlegs.mvcs.Actor;
	
	import shinydesign.multidb.events.SearchResultEvent;
	import shinydesign.multidb.models.vo.SearchResultRecord;
	import shinydesign.multidb.models.vo.SearchResultRecords;
	import shinydesign.multidb.models.vo.SearchResultSummary;
	
	public class SearchResultModel extends Actor
	{
		private var _searchResultRecords:SearchResultRecords;
		private var _searchResultSummary:SearchResultSummary;
		private var _selectedSearchResult:SearchResultRecord;
		
		
		public function get selectedSearchResult():SearchResultRecord
		{
			return _selectedSearchResult;
		}

		public function set selectedSearchResult(value:SearchResultRecord):void
		{
			_selectedSearchResult = value;
			dispatch(new SearchResultEvent(SearchResultEvent.SEARCH_MODEL_SELECTEDRESULTSET));
		}

		public function get searchResultSummary():SearchResultSummary
		{
			return _searchResultSummary;
		}

		public function set searchResultSummary(value:SearchResultSummary):void
		{
			_searchResultSummary = value;
			dispatch(new SearchResultEvent(SearchResultEvent.SEARCH_MODEL_RESULTSSUMMARY_UPDATED));
			
		}

		public function get searchResultRecords():SearchResultRecords
		{
			return _searchResultRecords;
		}

		public function set searchResultRecords(value:SearchResultRecords):void
		{
			_searchResultRecords = value;
			dispatch(new SearchResultEvent(SearchResultEvent.SEARCH_MODEL_RESULTS_UPDATED));
		}

	}
}