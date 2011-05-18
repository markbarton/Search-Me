package shinydesign.multidb.models.vo
{
	public class AttachmentRecord
	{
		//This class represents 1 attachment - a SearchResultRecord may contain an array if these
		private var _name:String;
		private var _linkURL:String;

		public function get linkURL():String
		{
			return _linkURL;
		}

		public function set linkURL(value:String):void
		{
			_linkURL = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

	}
}