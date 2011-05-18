package shinydesign.multidb.services.dominodata.customgridconfig
{
	import mx.managers.CursorManager;
	
	import shinydesign.multidb.events.CustomGridConfigEvent;
	import shinydesign.multidb.models.CustomGridModel;
	import shinydesign.multidb.models.vo.CustomGridColumn;
	import shinydesign.multidb.models.vo.CustomGridColumns;
	import shinydesign.multidb.services.dominodata.DominoXMLService;
	import shinydesign.multidb.services.dominodata.IDominoXMLService;
	import shinydesign.multidb.utils.HashMap;
	
	public class CustomConfigXMLService extends DominoXMLService implements IDominoXMLService
	{
		[Inject]
		public var customGridModel:CustomGridModel;
		
		public function CustomConfigXMLService()
		{
			//TODO: implement function
			super();
		}
		
		//Implement the handleresult method as we want to use our specific parser
		override public function handleServiceResult(event:Object,endPointKey:String):void
		{
			CursorManager.removeBusyCursor();
			trace("Service >> CustomConfigXMLService");
			//Based on the URLEndPointKey we will parse out to serveral methods
			//Possible operations are LoadAllCrisisData, UpdateCrisisRecord
			trace("EndPointKey="+endPointKey);
			if(endPointKey=="CustomGridConfig"){
				//In case anyone else is interested we will dispatch a config loaded event
				dispatch(new CustomGridConfigEvent(CustomGridConfigEvent.CUSTOM_GRID_LOADED));
				
				for each(var grid:XML in event.result.Grid)
				{
					//Hash in custom grid columns VO will hold the individual columns
					var customColumnsObj:CustomGridColumns=new CustomGridColumns();
					customColumnsObj.customGridColumns=new HashMap(false);
					var key:String=grid.Key;
					for each(var column:XML in grid..Column)
					{
						var columnObj:CustomGridColumn=new CustomGridColumn();
						columnObj.DataType=column.DataType;
						columnObj.Heading=column.Heading;
						columnObj.FieldName=column.FieldName;
						var tmpSort:String="";
						tmpSort=column.SortOrder;
						columnObj.SortOrder=parseInt(tmpSort);
						columnObj.Width=column.Width;
						if(column.Editable=="true")
							columnObj.Editable=true;
						else
							columnObj.Editable=false;	
						columnObj.LabelFunctionName=column.LabelFunction;
						customColumnsObj.customGridColumns.put(column.FieldName,columnObj);	
					}
					
					trace(customColumnsObj.customGridColumns.size());
					customGridModel.tmp=customColumnsObj.customGridColumns.size().toString();
					
					//Sort the hash now
					//customColumnsObj.sortColumns();
					//Now we need to update the Custom Grid Model Hash with this CustomColumns Obj
					customGridModel.customDataGrids.put(key,customColumnsObj);
					
					}
				//Dispatch Event indicating model has been updated
				dispatch(new CustomGridConfigEvent(CustomGridConfigEvent.MODEL_UPDATED,customGridModel));
			}
			
		}
	}
}