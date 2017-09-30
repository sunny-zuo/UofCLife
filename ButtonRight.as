package  {
	
	import flash.display.MovieClip;
	
	
	public class ButtonRight extends MovieClip {
		private var Width:Number;
		private var Height:Number;
		
		public function ButtonRight(Width:Number = 20, Height:Number = 20) {
			// constructor code
			graphics.beginFill(0x00FF00)
			graphics.drawRect(x,y,x + Width, y + Height)
			graphics.endFill()
		}
	}
	
}
