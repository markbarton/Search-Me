package shinydesign.multidb.services.dominodata.crisis
{
	import shinydesign.multidb.events.CrisisDataEvent;
	import shinydesign.multidb.models.vo.CrisisRecord;
	import shinydesign.multidb.models.vo.CrisisRecords;
	import shinydesign.multidb.services.dominodata.DominoXMLService;
	import shinydesign.multidb.services.dominodata.IDominoXMLService;
	
	public class CrisisXMLService extends DominoXMLService implements IDominoXMLService
	{
		public function CrisisXMLService()
		{
			super();
		}
		
		//Implement the handleresult method as we want to use our specific parser
		override public function handleServiceResult(event:Object,endPointKey:String):void
		{
			//Based on the URLEndPointKey we will parse out to serveral methods
			//Possible operations are LoadAllCrisisData, UpdateCrisisRecord
			trace("Service >> CrisisXMLService");
			trace("EndPointKey="+endPointKey);
			if(endPointKey=="LoadAllCrisisData"){
				//Array Collection in records will hold individual crisis record
				var records:CrisisRecords=new CrisisRecords();
				
				for each(var record:XML in event.result.DOCUMENT)
				{
					var crisisRecord:CrisisRecord=new CrisisRecord();
					crisisRecord.ARRDEP=record.ARRDEP;
					crisisRecord.BOOKNO=record.BOOKNO;
					crisisRecord.CONSULTANT=record.CONSULTANT;
					crisisRecord.EXCEPTIONALCLIENT=record.EXCEPTIONALCLIENT;
					crisisRecord.UNID=record.UNID;
					crisisRecord.CREATED=record.CREATED;
					records.crisisRecords.addItem(crisisRecord);
				}
				//Dispatch Event with crisisRecords so command cna update model
				dispatch(new CrisisDataEvent(CrisisDataEvent.DATA_LOADED,endPointKey,records));
			}
			
		}
		
		
	}
}