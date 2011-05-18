/**
 * BasePreloader replaces default Flex loader with your very own awesome custom loader
 * This class was mostly copied and pasted from www.foxarc.com/blog/article/44.htm
 * Thanks eFox!!!!
 * 
 * Usage:
 * 1. Extend this class and build what ever you want.
 * 2. hookup two properties
 * 		1. onInit, Function: called on init of preloader;
 * 		2. onUpdate, Function: called on download progress; Returns: Percentage value as a whole number (Number)
 * Tip: Make sure the loader does not change width by any animations sliding to the left or right.
 *		Place an invisible background object behind all elements in their extreme left and right coordinates.
 * Sample:
 * --------------------------------------------------------------
package
{
	import com.hdi.loaders.BasePreloader;
	public class CustomLoader extends BasePreloader
	{
		public function CustomLoader()
		{
			
			//build all your graphics, textFields
			//import an swf or a Flash UIMovieClip Component Class
			
			// hook up Funcitons
			this.onUpdate = updateLoader;
			this.onInit = init;
			
			super();
		}
		
		public function init():void{
			// reset download percent lable to 0% and what ever else you want
		}
		
		public function updateLoader(perc:Number):void{
			// display perc value in label and advance your progress bar.
			// perc is a whole number so your progress will have to be like this
			// progressBar.scaleX = perc/100;
		}
	}
}
 * ----------------------------------------------------------------
 **/

package shinydesign.multidb.utils
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.ProgressEvent;
  import flash.display.MovieClip;
  import mx.events.FlexEvent;
  import mx.preloaders.IPreloaderDisplay;
  import mx.preloaders.Preloader;
  
  public class BasePreloader extends MovieClip implements IPreloaderDisplay
  {

 	private var _preloader:Preloader;
	public var onUpdate:Function = null;
	public var onInit:Function = null;
 
    public function BasePreloader(){
		super();
		//trace("loader started");
     
    }
    
    public function get backgroundAlpha():Number{
		return 0;
    }
    
    public function set backgroundAlpha(value:Number):void{
    }
    
    public function get backgroundColor():uint{
		return 0;
    }
    
    public function set backgroundColor(value:uint):void{
    }
    
    public function get backgroundImage():Object{
		return null;
    }
    
    public function set backgroundImage(value:Object):void{
    }
    
    public function get backgroundSize():String{
 		return null;
    }
    
    public function set backgroundSize(value:String):void{
    }
    
    public function set preloader(obj:Sprite):void{
		_preloader = obj as Preloader;
		_preloader.addEventListener(ProgressEvent.PROGRESS, progressEventHandler);
		_preloader.addEventListener(FlexEvent.INIT_COMPLETE,initCompleteEventHandler);
    }
    
    public function get stageHeight():Number{
		return 0;
    }
    
    public function set stageHeight(value:Number):void{
    }
    
    public function get stageWidth():Number{
		return 0;
    }
    
    public function set stageWidth(value:Number):void{
    }
    
   public function initialize():void{
		this.x = stage.stageWidth/2 - this.width/2;
		this.y = stage.stageHeight/2 - this.height/2;
		if(onInit != null){
			onInit();
		}
    }
    
    private function progressEventHandler(eo:ProgressEvent):void{
    	if(onUpdate != null){
      		onUpdate(Math.round((eo.bytesLoaded / eo.bytesTotal )*100));
     	}
    }
    
    private function initCompleteEventHandler(eo:FlexEvent):void{
     	dispatchEvent(new Event(Event.COMPLETE));
    }
  }
}