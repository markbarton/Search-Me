package shinydesign.multidb.models.vo
{
	public class CrisisRecord
	{
		private var _UNID:String;
		private var _BOOKNO:String;
		private var _CONSULTANT:String;
		private var _EXCEPTIONALCLIENT:String;
		private var _ARRDEP:String;
		private var _CREATED:String;
		
		public function CrisisRecord()
		{
		}

		public function get CREATED():String
		{
			return _CREATED;
		}

		public function set CREATED(value:String):void
		{
			_CREATED = value;
		}

		public function get ARRDEP():String
		{
			return _ARRDEP;
		}

		public function set ARRDEP(value:String):void
		{
			_ARRDEP = value;
		}

		public function get EXCEPTIONALCLIENT():String
		{
			return _EXCEPTIONALCLIENT;
		}

		public function set EXCEPTIONALCLIENT(value:String):void
		{
			_EXCEPTIONALCLIENT = value;
		}

		public function get CONSULTANT():String
		{
			return _CONSULTANT;
		}

		public function set CONSULTANT(value:String):void
		{
			_CONSULTANT = value;
		}

		public function get BOOKNO():String
		{
			return _BOOKNO;
		}

		public function set BOOKNO(value:String):void
		{
			_BOOKNO = value;
		}

		public function get UNID():String
		{
			return _UNID;
		}

		public function set UNID(value:String):void
		{
			_UNID = value;
		}

	}
}