package shinydesign.multidb.utils
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import shinydesign.multidb.events.ApplicationEvent;
       
	//This class is used for working with the browser
	//It will register various methods with Javascript as well as get any initial settings
	//This will include any default parameters
	
	public class BrowserUtils extends EventDispatcher
	{
			
		public function BrowserUtils()
		{
		}
		
		public function init():void{
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
						//Send Event we are ready
						dispatchEvent(new ApplicationEvent(ApplicationEvent.BROWSER_READY));
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