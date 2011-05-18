package shinydesign.multidb.services.authenticate
{
	public interface IAuthenticate
	{
		function sendLogin():void;
		//Is the user logged
		function isLoggedIn():void;
		function get username():String;
		function set username(value:String):void;
		function get password():String;
		function set password(value:String):void;
		
	}
	
}