package shinydesign.multidb.models.vo
{
	[Bindable]
	public class FieldRecord
	{
		//This field represents a specific field - a SearchResultRecord will possibly hold a vector of these
		private var _fieldname:String;
		private var _fieldvalue:String;
		
		public function get fieldvalue():String
		{
			return _fieldvalue;
		}

		public function set fieldvalue(value:String):void
		{
			_fieldvalue = value;
		}

		public function get fieldname():String
		{
			return _fieldname;
		}

		public function set fieldname(value:String):void
		{
			_fieldname = value;
		}

	}
}