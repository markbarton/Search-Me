package shinydesign.multidb.events
{
	import flash.events.Event;
	
	import shinydesign.multidb.models.vo.SearchResultRecord;
	
	public class SearchInputEvent extends Event
	{
		public static const SEARCH_STRING_CHANGED:String = "searchStringChanged";
		public static const SEARCH_SUBMITTED:String = "searchSubmitted";
		public static const DISPLAY_SEARCH_SUMMARY:String = "displaySearchSummary";
		public static const DISPLAY_RESULT_DETAIL:String = "displayResultDetail";
		public static const CLOSE_DISPLAY_DETAIL:String="closeDisplayDetail";
		public static const CLOSE_SEARCH_SUMMARY:String="closeSearchSummary";
		
		public var searchString:String;
		public var urlEndPointKey:String; //Required for generic load Domino Data
		public var searchResult:SearchResultRecord; //Used when double clicking on a datagrid
		public function SearchInputEvent(type:String,searchString:String=null,urlEndPointKey:String=null,searchResult:SearchResultRecord=null)
		{
			trace("EVENT >> SearchInputEvent >> " + type);
			
			this.searchString=searchString;
			this.urlEndPointKey=urlEndPointKey;
			this.searchResult=searchResult;
			super(type, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new SearchInputEvent(this.type,this.searchString,this.urlEndPointKey,this.searchResult);
		}
	
	}
	
	
}