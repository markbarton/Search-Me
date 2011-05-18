package shinydesign.multidb.utils
{
	import mx.controls.DataGrid;
	import mx.controls.Label;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.ClassFactory;
	import mx.formatters.DateFormatter;
	
	import shinydesign.components.stretchdatagrid.StretchDataGrid;
	import shinydesign.multidb.models.CustomGridModel;
	import shinydesign.multidb.models.vo.CustomGridColumn;
	import shinydesign.multidb.models.vo.CustomGridColumns;
	import shinydesign.multidb.utils.comparator.*;
	//Builds a datagrid from given definition key
	public class GridBuilder
	{
		public var customGridModel:CustomGridModel;
		
		//List of field names so we can filter on them in the grid
		public  var fieldNames:Array=new Array();
		
		public function GridBuilder( customGridModel:CustomGridModel):void{
			this.customGridModel=customGridModel;
		}
		
		
		//User defined width - could be more than calculated width ignored if less
		private var _width:int;
		
		public function get width():int
		{
			return _width;
		}

		public function set width(value:int):void
		{
			_width = value;
		}

		public function returnDataGrid(key:String):DataGrid{
			//Based on key extract CustomGridColumns from Model
			trace(customGridModel.customDataGrids.size());
			var Columns:CustomGridColumns=customGridModel.customDataGrids.getValue(key);
			trace(Columns.customGridColumns.size());
			//The Columns can now be looped through to build
			//This field is used to hold the cumlative column widths
			 var overallWidth:Array=new Array;
			var dataGridColumns:Array=new Array();
			var dataGridCol:DataGridColumn;
			//Returned sorted enteries from HashMap
			var tmpArray:Array=Columns.customGridColumns.sortedEntries("SortOrder",Array.NUMERIC);
			var totalWidth:int;
			
			for each(var column:CustomGridColumn in tmpArray){	
				dataGridCol=new DataGridColumn();
				dataGridCol.headerText = column.Heading;
				dataGridCol.headerRenderer = new ClassFactory(mx.controls.Label);
				dataGridCol.showDataTips=true;
				var tmpWidth:String=column.Width;
				dataGridCol.width=parseInt(tmpWidth);
				totalWidth+=dataGridCol.width;
				dataGridCol.dataField=column.FieldName;
				if(column.LabelFunctionName!="")
				dataGridCol.labelFunction=this[column.LabelFunctionName];
				else
				dataGridCol.labelFunction=standardLabel;
				dataGridCol.editable=column.Editable;
				dataGridCol.wordWrap=true;
				
				//Based on the datatype use a custom comparator
				if(column.DataType=="date"){
					dataGridCol.sortCompareFunction = sorterProxy ( column.FieldName, new DateSorter() );
				trace("Using the Date Compare function");
				}
				dataGridColumns.push(dataGridCol);
				this.fieldNames.push(column.FieldName);
			}
			var dataGrid:DataGrid=new DataGrid;
			dataGrid.id=key;
			dataGrid.columns = dataGridColumns;
			//dataGrid.percentWidth=100;
			dataGrid.percentHeight=100;
			dataGrid.editable=true;
			dataGrid.variableRowHeight=true;
			//Update CustomGrid with total width;
			Columns.totalWidth=totalWidth;
			//dataGrid.columnWidths=overallWidth;
			return dataGrid;
			}
		
		private function standardLabel(item:Object, column:DataGridColumn):String{
			return(item[column.dataField]);
		
		}
		
		private function partial( func : Function, ...boundArgs ) : Function {
			return function( ...dynamicArgs ) : * {
				return func.apply(null, boundArgs.concat(dynamicArgs))
			}
		}		
			
		private function StandardDate(item:Object, column:DataGridColumn):String{
			///This label function will display a date 
			// The datafield on the column defines the item we need to format
			var dateFormater:DateFormatter=new DateFormatter();
			dateFormater.formatString="MMM. D, YYYY ";
			
			return dateFormater.format(item[column.dataField]);
		}
		
		public static function sorterProxy(field:String, comparisonStrategy:IComparator):Function
		{
			return function ( obj1:Object, obj2:Object ) : int
			{
				return comparisonStrategy.compare ( obj1[field], obj2[field] );
			}
		}

	
	}
	
}