package shinydesign.multidb.utils
{
	// imports
	import flash.filters.GlowFilter;

	public class CustomLoaderMC extends BasePreloader
	{
		// UIMovieClip class from Flash, via lobs folder
		private var ldr:LoaderRing;
		
		public function CustomLoaderMC()
		{
			// filters are cool
			var filter:GlowFilter = new GlowFilter(0xD75F0F,1,12,12,1.8,2);
			
			// new instance of Flash UIMovieClip
			ldr = new LoaderRing();
			// update colors - snazzy
			ldr.ringColor = 0xD75F0F;
			// apply filters
			ldr.filters = [filter];
			// offset x and y, centering the Flash Component
			ldr.x = ldr.width/2;
			ldr.y = ldr.height/2;
			//add child to display list
			this.addChild(ldr);
			
			// hookup properties from super class
			this.onUpdate = updateLoader;
			this.onInit = init;
			
			super();
		}
		
		// on init function  - reset percentage label
		public function init():void{
			ldr.updateText("0%");
		}
		
		// on progress function - update percentage label
		public function updateLoader(perc:Number):void{
			ldr.updateText(perc + "%");
			
			// if progress bar was precent, you would update that here.
			//progressBar.scaleX = perc/100;
		}
		
	}
}