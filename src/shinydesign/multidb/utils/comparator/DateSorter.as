package shinydesign.multidb.utils.comparator
{
	import mx.utils.ObjectUtil;

	public class DateSorter implements IComparator
	{
		public function DateSorter()
		{
		}
		
		public function compare(obj1:Object, obj2:Object):int
		{
			
		var d1:Date= new Date(Date.parse(obj1));
		var d2:Date=new Date(Date.parse(obj2));
		return ObjectUtil.dateCompare(d1,d2);
		}
	}
}