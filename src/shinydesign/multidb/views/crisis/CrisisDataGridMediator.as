package shinydesign.multidb.views.crisis
{
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.events.DataGridEvent;
	import mx.utils.ObjectUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	import shinydesign.multidb.events.CrisisDataEvent;
	import shinydesign.multidb.events.CustomGridConfigEvent;
	import shinydesign.multidb.events.CustomDataGridEvent;
	import shinydesign.multidb.models.CrisisModel;
	import shinydesign.multidb.models.CustomGridModel;
	import shinydesign.multidb.models.vo.CrisisRecord;
	import shinydesign.multidb.models.vo.CustomGridColumn;
	import shinydesign.multidb.utils.GridBuilder;
	
	import spark.components.Label;
	
	public class CrisisDataGridMediator extends Mediator
	{
		[Inject]
		public var view:CrisisDataGrid;
		
		[Inject]
		public var crisisModel:CrisisModel;
		[Inject]
		public var customGridModel:CustomGridModel;
		
		[Bindable]
		public  var dataGrid:DataGrid;
		public var dataCollection:ArrayCollection;
		
		private var gridBuilder:GridBuilder;
		
		override public function onRegister():void
		{
			trace("Mediator >> CrisisDataGridMediator");
			BuildGrid();	
			
			//Listent for the Crisis Model Updated
			eventMap.mapListener(eventDispatcher,CrisisDataEvent.MODEL_UPDATED,updateGrid);	
				
			//Listen for the grid changing
			eventMap.mapListener(view, CrisisDataEvent.DATAGRID_CELL_CHANGED, UpdateData);
			
			//Listen for the filter input
			//eventMap.mapListener(view,shinydesign.multidb.events.CustomDataGridEvent.FILTER_CHANGED,doFilter);
			
		}
		
		private function BuildGrid():void{
			//Build Grid from configuration
			gridBuilder=new GridBuilder(this.customGridModel);
			dataGrid=gridBuilder.returnDataGrid("CrisisData");
			//Set data provider here - once the data is loaded the binding will update the grid
			dataGrid.dataProvider = this.dataCollection;
			view.addElement(dataGrid);
			//Load All Crisis Data
			dispatch(new CrisisDataEvent(CrisisDataEvent.LOAD_DATA,"LoadAllCrisisData"));
			
		}
		
		private function UpdateData(event:CrisisDataEvent):void{
			trace(ObjectUtil.toString(event.dataCell));
		}
		
		private function updateGrid(event:CrisisDataEvent):void{
			this.dataCollection=crisisModel.crisisRecords.crisisRecords;
			dataGrid.dataProvider=this.dataCollection;
		}
		
		
		private function doFilter(event:Event):void{ 
			//Set the filter function on data provider
			this.dataCollection.filterFunction=processFilter;
			
			//Assign Filter function to Grid Data Source
			this.dataCollection.refresh();
			
			
		}
		
		//Filter function
		private function processFilter(item:Object):Boolean {
			var matched:Boolean=false;
			
			//Needs to be a visible item rather than any other additional values which are in the VO
			for each(var id:String in gridBuilder.fieldNames) {
				var value:Object = item[id];
				if(value!=null){
					if(value.match(new RegExp("^"+ view.search.text + ".","i")))
						matched=true;
					if(value.toString().toLowerCase()==view.search.text.toLowerCase())
						matched=true;
					//if(item.label.match(new RegExp("^"+ view.search.text + ".","i")))
					//	matched=true;
				}
				//if(item.label.toString().toLowerCase()==view.search.text.toLowerCase())
					//matched=true;
			}
			
			
			return matched;
		}
	}
}