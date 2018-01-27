package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class ConfessionBoard extends MovieClip{
		
		public var xPos:Number;
		public var yPos:Number;
		
		public function ConfessionBoard(xPos:Number, yPos:Number) {
			this.xPos = xPos;
			this.yPos = yPos;
			
			addEventListener(MouseEvent.CLICK, openConfessions);
		}
		
		private function openConfessions(event:MouseEvent):void{
			if(hitTestObject(Main.instance.character)){
				MenuController.generateConfessionPopup();
			}
		}

	}
	
}
