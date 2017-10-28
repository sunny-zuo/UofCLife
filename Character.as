package {
	//imports packages
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.events.TouchEvent;
	import flash.events.MouseEvent;

	public class Character extends MovieClip {
		private var left: Boolean = false; //left and right booleans
		private var right: Boolean = false;
		private var speed: int = 10; //the player speed

		public function Character():void {
			// constructor code
			graphics.beginFill(0x00FF00);
			graphics.drawCircle(x,y,25);
			graphics.endFill();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage)

		}
		
		private function addedToStage(event: Event): void {
			addEventListener(Event.ENTER_FRAME, eFrame);
			stage.addEventListener(MouseEvent.MOUSE_UP, MouseRelease);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MousePress);
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
		}

		private function eFrame(event: Event): void {
			if (right == true) {
				this.x += speed
			}
			if (left == true) {
				this.x -= speed
			}
		}


		private function MouseRelease(event: MouseEvent): void { //checks for the right button to be pressed
			right = false;
			left = false;
		}

		private function MousePress(event: MouseEvent): void { //checks for the left button to be pressed
			if (mouseX < 100) {
				left = true
			}
			if (mouseX > 200) {
				right = true
			}
		}



	}

}