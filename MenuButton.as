package  {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	
	public class MenuButton extends SimpleButton {
		
		
		public function MenuButton() {
			// constructor code
			this.addEventListener(MouseEvent.CLICK, onClick)
		}
		private function onClick(event:MouseEvent):void {
			
		}
	}
	
}
