package shinydesign.multidb.models.vo
{
	[Bindable]
	public class DataCell
	{
		//Fieldname normally
		private var _Cell_ID:String;
		//UNID normally
		private var _Row_ID:String;
		private var _OldValue:String;
		private var _NewValue:String;
		
		
		public function DataCell()
		{
		}

		public function get NewValue():String
		{
			return _NewValue;
		}

		public function set NewValue(value:String):void
		{
			_NewValue = value;
		}

		public function get OldValue():String
		{
			return _OldValue;
		}

		public function set OldValue(value:String):void
		{
			_OldValue = value;
		}

		public function get Row_ID():String
		{
			return _Row_ID;
		}

		public function set Row_ID(value:String):void
		{
			_Row_ID = value;
		}

		public function get Cell_ID():String
		{
			return _Cell_ID;
		}

		public function set Cell_ID(value:String):void
		{
			_Cell_ID = value;
		}

	}
}