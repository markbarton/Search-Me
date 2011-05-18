package shinydesign.multidb.services
{
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import org.robotlegs.mvcs.Actor;
	
	import shinydesign.multidb.events.ApplicationEvent;
	import shinydesign.multidb.models.ApplicationConfigModel;
	import shinydesign.multidb.models.vo.ApplicationConfig;
	import shinydesign.multidb.models.vo.BrowserVariables;
	
	public class BrowserService extends Actor
	{
		[Inject]
		public var appModel:ApplicationConfigModel;
		
		public function BrowserService()
		{
			trace("Service >> Browser Service");
		}
		
		public function CheckBrowserReady():void{
			if (ExternalInterface.available)
			{
				try
				{
					// This calls the isContainerReady() method, which in turn calls
					// the container to see if it
					// is ready to receive calls from the SWF.
					var containerReady:Boolean = isContainerReady();
					if (containerReady)
					{
						readOptions();
						
					}
					else
					{
						// If the container is not ready, set up a Timer to call the
						// container at 100ms intervals. Once the container responds that
						// it's ready, the timer will be stopped.
						var readyTimer:Timer = new Timer(100);
						readyTimer.addEventListener(TimerEvent.TIMER, timerHandler);
						readyTimer.start();
					}
				}
				catch (error:SecurityError)
				{
					trace("A SecurityError occurred: " + error.message + "\n");
					throw error;
				}
				catch (error:Error)
				{
					trace("An Error occurred: " + error.message + "\n");
					throw error;
				}
			}
			else
			{
				trace("External interface is not available for this container.");
			}
		}
		
		
		// ------- Private Methods -------
		
		/**
		 *This method exposes the various Actionscript methods that the host web page can call 
		 *If you need an Actionscript method to be availble then it needs to be added here 
		 */	
		
		private function setupCallbacks():void{
			
			
		}
		
		//This is where this service is reading from an external Javascript function
		//In this case we are looping through an object array so we can hold serveral properties
		//In this case we want the Query String if there is one.
		
		public function readOptions():void{
			var config:BrowserVariables=appModel.browserVariables;
			var listOptions:Object=new Object;
			listOptions=(ExternalInterface.call("listOptions"));
		
			if(listOptions.hasOwnProperty("query")){
				if(listOptions.query!=""){
					//Update Query Value on the Browser Variables Object on the Application Config Model
					//Get config from Model
						config.Query=listOptions.query;
					//Dispatch Event
						
					dispatch(new ApplicationEvent(ApplicationEvent.QUERY_STRING_SET,null,config));
				}
			}
			
			if(listOptions.hasOwnProperty("configLocation")){
				if(listOptions.configLocation!=""){
					//Update Config Location Value on the Browser Variables Object on the Application Config Model
					//Get config from Model
					config.ConfigLocation=listOptions.configLocation;
				}
			}
			
			//Send Event we are ready
			dispatch(new ApplicationEvent(ApplicationEvent.BROWSER_READY));	
		}
		
		/**
		 * Calls the container's isReady() function, to check if the container is loaded
		 * and ready to communicate with the SWF file.
		 * @return 	Whether the container is ready to communicate with ActionScript.
		 */
		private function isContainerReady():Boolean
		{
			var result:Boolean = ExternalInterface.call("isReady");
			return result;
		}
		
		/**
		 * Handles the timer event; this function is called by the timer each
		 * time the elapsed time has been reached.
		 * The net effect is that on regular intervals this function checks
		 * to see if the container is ready to receive communication.
		 * @param event		The event object for the Timer event.
		 */
		private function timerHandler(event:TimerEvent):void
		{
			// check if the container is now ready
			var isReady:Boolean = isContainerReady();
			if (isReady)
			{
				// If the container has become ready, we don't need to check anymore,
				// so stop the timer.
				Timer(event.target).stop();
				// Set up the ActionScript methods that will be available to be
				// called by the container.
				setupCallbacks();
			}
		}
	}
}