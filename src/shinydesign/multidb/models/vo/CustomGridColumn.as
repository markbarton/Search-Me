package shinydesign.multidb.models.vo
{
	public class CustomGridColumn
	{
		//This class defines a data grid column
		private var _Heading:String;
		private var _DataType:String;
		private var _Width:String;
		private var _FieldName:String;
		private var _Editable:Boolean;
		private var _SortOrder:int;
		private var _LabelFunctionName:String
		

		public function get LabelFunctionName():String
		{
			return _LabelFunctionName;
		}

		public function set LabelFunctionName(value:String):void
		{
			_LabelFunctionName = value;
		}

		public function get SortOrder():int
		{
			return _SortOrder;
		}

		public function set SortOrder(value:int):void
		{
			_SortOrder = value;
		}

		public function get Editable():Boolean
		{
			return _Editable;
		}

		public function set Editable(value:Boolean):void
		{
			_Editable = value;
		}

		public function get FieldName():String
		{
			return _FieldName;
		}

		public function set FieldName(value:String):void
		{
			_FieldName = value;
		}

		public function get Width():String
		{
			return _Width;
		}

		public function set Width(value:String):void
		{
			_Width = value;
		}

		public function get DataType():String
		{
			return _DataType;
		}

		public function set DataType(value:String):void
		{
			_DataType = value;
		}

		public function get Heading():String
		{
			return _Heading;
		}

		public function set Heading(value:String):void
		{
			_Heading = value;
		}

	}
}