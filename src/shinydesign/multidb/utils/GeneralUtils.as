// ActionScript file

private function isoToDate(value:String):Date {
	var dateStr:String = value;
	dateStr = dateStr.replace(/\-/g, "/");
	dateStr = dateStr.replace("T", " ");
	dateStr = dateStr.replace("Z", " GMT-0000");
	return new Date(Date.parse(dateStr));
}