package  {
	
	import flash.display.MovieClip;
	
	
	public class ButtonLeft extends MovieClip {
		
		
		public function ButtonLeft(Width:Number = 20, Height:Number = 20) {
			// constructor code
			graphics.beginFill(0x00FF00)
			graphics.drawRect(x,y,x + Width, y + Height)
			graphics.endFill()
		}
	}
	
}
