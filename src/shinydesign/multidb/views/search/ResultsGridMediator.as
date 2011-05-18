package shinydesign.multidb.views.search
{
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;
	import mx.events.ListEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import shinydesign.components.stretchdatagrid.StretchDataGrid;
	import shinydesign.multidb.events.SearchInputEvent;
	import shinydesign.multidb.events.SearchResultEvent;
	import shinydesign.multidb.models.CustomGridModel;
	import shinydesign.multidb.models.SearchResultModel;
	import shinydesign.multidb.models.vo.SearchResultRecord;
	import shinydesign.multidb.utils.GridBuilder;
	
		
	public class ResultsGridMediator extends Mediator
	{
		[Inject]
		public var view:ResultsGrid;
		[Inject]
		public var customGridModel:CustomGridModel;  //Model for custom grids
		[Inject]
		public var resultsModel:SearchResultModel; //Model for search results
		 
		public  var dataGrid:DataGrid; //The data grid thats going to be displayed
		[Bindable]
		public var dataCollection:ArrayCollection; //The arraycollection thats going to be set as the dataprovider for the grid
		
		private var gridBuilder:GridBuilder;
		
		override public function onRegister():void
		{
			trace("Mediator >> ResultsGrid");
			//Build Grid First
			BuildGrid();
			//Listen for SearchInput to clear down the dataCollection first
			eventMap.mapListener(eventDispatcher,SearchInputEvent.SEARCH_SUBMITTED,clearGrid);
				//Listen for results Model being Updated
			eventMap.mapListener(eventDispatcher,SearchResultEvent.SEARCH_MODEL_RESULTS_UPDATED,updateGrid);
			//Listen for a doubleclick on the datagrid
			eventMap.mapListener(view,ListEvent.ITEM_DOUBLE_CLICK,displayResultsSummary);
			//Check to see if we have any results already
			if(resultsModel.searchResultRecords.searchRecords!=null)
			{
				if(resultsModel.searchResultRecords.searchRecords.length!=0)
					updateGrid(null);
			}
		}
		
		private function BuildGrid():void{
			//Build Grid from configuration
			gridBuilder=new GridBuilder(this.customGridModel);
			//Build Data Grid
			dataGrid=gridBuilder.returnDataGrid("ResultsData");
			//Set data provider here - once the data is loaded the binding will update the grid
			dataGrid.dataProvider = this.dataCollection;
			//Set dataTip function
			dataGrid.dataTipFunction=dataTipsFunction;
			//Add Double click event stuff
			dataGrid.doubleClickEnabled=true;
			//Add event listener for the double click
			dataGrid.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, displayResultsSummary);
			dataGrid.id="ResultsViewGrid";
			
			//Output Grid to View
			view.addElement(dataGrid);
			
		}
		
		private function clearGrid(event:SearchInputEvent):void{
			//called when the search input is submitted - we need to clear the grid
			this.dataCollection=null;
			dataGrid.dataProvider=this.dataCollection;
		}
		
		private function updateGrid(event:SearchResultEvent):void{
			//Called when the model is updated
			this.dataCollection=resultsModel.searchResultRecords.searchRecords;
			dataGrid.dataProvider=this.dataCollection;
		}
		
		private function displayResultsSummary(event:ListEvent):void{
			//Dispatch to the framework along with searchResult Object
			var searchResult:SearchResultRecord=event.currentTarget.selectedItem;
			dispatch(new SearchInputEvent(SearchInputEvent.DISPLAY_RESULT_DETAIL,"","",searchResult));
		}
		
		private function dataTipsFunction(searchResult:SearchResultRecord):String{
			var returnString:String="";
			returnString+="Title: "+searchResult.title +"\n"
			returnString+="Created: "+searchResult.created +"\n";
			returnString+="Author: "+searchResult.author+"\n\n";
			returnString+="Double click row for more information";
			return returnString;
		}
		
	}
}