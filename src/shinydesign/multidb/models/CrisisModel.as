package shinydesign.multidb.models
{
	import org.robotlegs.mvcs.Actor;
	
	import shinydesign.multidb.events.CrisisDataEvent;
	import shinydesign.multidb.models.vo.CrisisRecords;
	
	public class CrisisModel extends Actor
	{
		private var _crisisRecords:CrisisRecords;
		

		public function get crisisRecords():CrisisRecords
		{
			return _crisisRecords;
		}

		public function set crisisRecords(value:CrisisRecords):void
		{
			_crisisRecords = value;
			dispatch(new CrisisDataEvent(CrisisDataEvent.MODEL_UPDATED));
		}

	}
}