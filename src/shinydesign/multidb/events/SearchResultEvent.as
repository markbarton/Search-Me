package shinydesign.multidb.events
{
	import flash.events.Event;
	
	import shinydesign.multidb.models.vo.SearchResultRecords;
	import shinydesign.multidb.models.vo.SearchResultSummary;

	public class SearchResultEvent extends Event
	{
		public static const SEARCH_MODEL_RESULTSSUMMARY_UPDATED:String = "searchModelResultsSummaryUpdated";
		public static const SEARCH_MODEL_RESULTS_UPDATED:String = "searchModelResultsUpdated";
		public static const SEARCH_RESULTS_LOADED:String = "searchResultsLoaded";
		public static const SEARCH_MODEL_SELECTEDRESULTSET:String = "searchModelSelectedResultSet";
		
		
		public var searchResults:SearchResultRecords;
		public var searchSummary:SearchResultSummary;
		public function SearchResultEvent(type:String,searchResults:SearchResultRecords=null,searchSummary:SearchResultSummary=null)
		{
			trace("EVENT >> SearchResultEvent >> " + type);
			this.searchResults=searchResults;
			this.searchSummary=searchSummary;
			super(type, bubbles, cancelable);
		}
	
	
	override public function clone() : Event
	{
		return new SearchResultEvent(this.type,this.searchResults,this.searchSummary);
	}
	}
}