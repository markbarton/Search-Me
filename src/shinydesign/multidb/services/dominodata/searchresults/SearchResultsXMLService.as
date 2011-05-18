package shinydesign.multidb.services.dominodata.searchresults
{
	import mx.managers.CursorManager;
	
	import shinydesign.multidb.events.SearchResultEvent;
	import shinydesign.multidb.models.vo.AttachmentRecord;
	import shinydesign.multidb.models.vo.FieldRecord;
	import shinydesign.multidb.models.vo.SearchResultRecord;
	import shinydesign.multidb.models.vo.SearchResultRecords;
	import shinydesign.multidb.models.vo.SearchResultSummary;
	import shinydesign.multidb.services.dominodata.DominoXMLService;
	import shinydesign.multidb.services.dominodata.IDominoXMLService;
	
	public class SearchResultsXMLService extends DominoXMLService implements IDominoXMLService
	{
		public function SearchResultsXMLService()
		{
			super();
		}
		
		//Implement the handleresult method as we want to use our specific parser
		override public function handleServiceResult(event:Object,endPointKey:String):void
		{
			CursorManager.removeBusyCursor()
			//Based on the URLEndPointKey we will parse out to serveral methods
			//Possible operations are LoadAllCrisisData, UpdateCrisisRecord
			trace("Service >> SearchResultsXMLService");
			trace("EndPointKey="+endPointKey);
			if(endPointKey=="SearchResults"){
				//Now parse the results we expect ResultSummary + SearchResults
				
				//ResultSummary
				var searchSummary:SearchResultSummary=new SearchResultSummary();
				for each(var item:XML in event.result.resultinfo){
					searchSummary.cacheDocUNID=item.cachedoc;
					searchSummary.endCount=parseInt(item.endcount);
					searchSummary.errorString=item.error;
					searchSummary.numberResults=parseInt(item.numberresults);
					searchSummary.query=item.query;
					searchSummary.startCount=parseInt(item.startcount);
					searchSummary.totalCount=parseInt(item.totalcount);
					searchSummary.log=item.log;
				}
				
				//Array Collection in records will hold individual crisis record
				var records:SearchResultRecords=new SearchResultRecords();
				
				for each(var record:XML in event.result.searchresult)
				{
					var searchRecord:SearchResultRecord=new SearchResultRecord();
					searchRecord.author=record.author;
					searchRecord.created=record.created;
					searchRecord.dbicon=record.dbicon;
					searchRecord.dbtitle=record.dbtitle;
					searchRecord.documentURL=record.documentURL;
					searchRecord.notesURL=record.notesURL;
					searchRecord.resultLevel=parseInt(record.resultlevel);
					
					//Fields - we need the first field to be the subject
					for each(var field:XML in record..field){
						var fieldRecord:FieldRecord=new FieldRecord();
						fieldRecord.fieldname=field.@name;
						if(searchRecord.title=="" || searchRecord.title==null)
						searchRecord.title=field;	
						fieldRecord.fieldvalue=field;
						searchRecord.fields.addItem(fieldRecord);
					}
					
					//Attachments
					//Default no attachments
					searchRecord.hasAttachments=false;
					for each(var attachment:XML in record..attachment){
						var attachmentRecord:AttachmentRecord=new AttachmentRecord();
						attachmentRecord.linkURL=attachment;
						attachmentRecord.name=attachment.@name;
						searchRecord.attachments.addItem(attachmentRecord);
						searchRecord.hasAttachments=true;
					}
					//Fields & Attachments to do
					records.searchRecords.addItem(searchRecord);
				}
				//Dispatch Event with crisisRecords so command cna update model
				dispatch(new SearchResultEvent(SearchResultEvent.SEARCH_RESULTS_LOADED,records,searchSummary));
			} 
			
		}
		
	}
}