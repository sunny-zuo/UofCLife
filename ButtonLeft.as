package  {
	
	import flash.display.MovieClip;
	
	
	public class ButtonLeft extends MovieClip {
		
		
		public function ButtonLeft() {
			// constructor code
			graphics.beginFill(0x00FF00)
			graphics.drawRect(this.x,this.y,this.x + 20, this.y + 20)
			graphics.endFill()
		}
	}
	
}
