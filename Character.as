package {
	//imports packages
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.events.TouchEvent;
	import flash.events.MouseEvent;

	public class Character extends MovieClip {
		private var mouseDown: Boolean = false; //left and right booleans
		//private var right: Boolean = false;
		private var speed: int = 10; //the player speed

		public function Character():void {
			// constructor code
			//draws a circle for the character
			graphics.beginFill(0xFFFF00);
			graphics.drawCircle(0,0,25);
			graphics.endFill();
			//adds evnt lister for when itself is added to stage
			addEventListener(Event.ADDED_TO_STAGE, addedToStage)

		}
		
		//adds the event listeners once it is added to stage
		private function addedToStage(event: Event): void {
			addEventListener(Event.ENTER_FRAME, eFrame);
			stage.addEventListener(MouseEvent.MOUSE_UP, MouseRelease);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MousePress);
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
		}

		//moves the character left and right
		private function eFrame(event: Event): void {
			if(mouseDown){
				if (mouseX < 0) {
					x -= speed;
				}
				if (mouseX > 0) {
					x += speed;
				}
			}
			
		}

		//sets left and right to false when mouse is released
		private function MouseRelease(event: MouseEvent): void { //checks for the right button to be pressed
			mouseDown = false;
		}

		//checks if the mouse if left or right of the character then sets the appropiate irection to true
		private function MousePress(event: MouseEvent): void { //checks for the left button to be pressed
			mouseDown = true;
		}



	}

}