package shinydesign.multidb.models.vo
{
	import mx.collections.ArrayCollection;
	
	///This VO holds 1 returned record
	[Bindable]
	public class SearchResultRecord
	{
		private var _dbicon:String;
		private var _dbtitle:String;
		private var _author:String;
		private var _created:String;
		private var _resultLevel:int;
		private var _documentURL:String;
		private var _notesURL:String;
		private var _attachments:ArrayCollection=new ArrayCollection();
		private var _fields:ArrayCollection=new ArrayCollection();
		private var _title:String; //First field from the fields vector - used for datagrid
		private var _hasAttachments:Boolean //Helper flag to indicate if there are attachments;
		

		public function get fields():ArrayCollection
		{
			return _fields;
		}

		public function set fields(value:ArrayCollection):void
		{
			_fields = value;
		}

		public function get attachments():ArrayCollection
		{
			return _attachments;
		}

		public function set attachments(value:ArrayCollection):void
		{
			_attachments = value;
		}

		public function get hasAttachments():Boolean
		{
			return _hasAttachments;
		}

		public function set hasAttachments(value:Boolean):void
		{
			_hasAttachments = value;
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		public function get notesURL():String
		{
			return _notesURL;
		}

		public function set notesURL(value:String):void
		{
			_notesURL = value;
		}

		public function get documentURL():String
		{
			return _documentURL;
		}

		public function set documentURL(value:String):void
		{
			_documentURL = value;
		}

		public function get resultLevel():int
		{
			return _resultLevel;
		}

		public function set resultLevel(value:int):void
		{
			_resultLevel = value;
		}

		public function get created():String
		{
			return _created;
		}

		public function set created(value:String):void
		{
			_created = value;
		}

		public function get author():String
		{
			return _author;
		}

		public function set author(value:String):void
		{
			_author = value;
		}

		public function get dbtitle():String
		{
			return _dbtitle;
		}

		public function set dbtitle(value:String):void
		{
			_dbtitle = value;
		}

		public function get dbicon():String
		{
			return _dbicon;
		}

		public function set dbicon(value:String):void
		{
			_dbicon = value;
		}

	}
}