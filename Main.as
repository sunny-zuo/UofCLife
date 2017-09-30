package {
	//imports packages
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.events.TouchEvent;
	import flash.events.MouseEvent;


	public class Main extends MovieClip {
		private var player: Ball; //makes a player from the ball class
		private var buttonRight: ButtonRight; //makes button right and left
		private var buttonLeft: ButtonLeft;
		private var left: Boolean = false; //left and right booleans
		private var right: Boolean = false;
		private var speed: int = 10; //the player speed



		public function Main() {
			// constructor code

			makeControls() //makes the player and the controls
			stage.addEventListener(Event.ENTER_FRAME, eFrame);
			buttonRight.addEventListener(MouseEvent.MOUSE_DOWN, rightPress);
			stage.addEventListener(MouseEvent.MOUSE_UP, rightRelease);
			buttonLeft.addEventListener(MouseEvent.MOUSE_DOWN, leftPress);
			stage.addEventListener(MouseEvent.MOUSE_UP, leftRelease);
			
			//touch alternatives
/*			buttonRight.addEventListener(TouchEvent.TAP_BEGIN, rightPress);
			buttonRight.addEventListener(TouchEvent.TAP_END, rightRelease);
			buttonLeft.addEventListener(TouchEvent.TAP_BEGIN, leftPress);
			buttonLeft.addEventListener(TouchEvent.TAP_END, leftRelease);*/

			start()
		}

		private function start(): void {
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			buttonLeft.buttonMode = true;
			buttonRight.buttonMode = true;
		}
	
		//makes the controls and player and adds them to the stage
		private function makeControls(): void { 
			//makes the moement buttons
			buttonRight = new ButtonRight(100,50)
			buttonLeft = new ButtonLeft(100,50);
			stage.addChild(buttonLeft);
			stage.addChild(buttonRight);
			buttonRight.x = stage.stageWidth - (stage.stageWidth / 5)
			buttonLeft.x = stage.stageWidth / 5
			buttonLeft.y = stage.stageHeight / 2
			buttonRight.y = stage.stageHeight / 2

			
			//makes the player
			player = new Ball(30);
			stage.addChild(player);
			player.x = stage.stageWidth / 2
			player.y = stage.stageWidth / 2
		}

		//the event moves the player when right or left == true
		private function eFrame(event: Event): void {
			if (right == true) {
				player.x += speed
			}
			if (left == true) {
				player.x -= speed
			}
		}

		private function rightPress(event: MouseEvent): void {//checks for the right button to be pressed
			right = true;
		}

		private function leftPress(event: MouseEvent): void {//checks for the left button to be pressed
			left = true;
		}

		private function rightRelease(event: MouseEvent): void {//checks for the right button to be released
			right = false;
		}

		private function leftRelease(event: MouseEvent): void {//checks for the left button to be released
			left = false;
		}

		//the future touch input
	/*	private function rightPress(event: TouchEvent): void {
			right = true;
			trace("press")
		}

		private function leftPress(event: TouchEvent): void {
			left = true;
		}

		private function rightRelease(event: TouchEvent): void {
			right = false;
			trace("release")
		}

		private function leftRelease(event: TouchEvent): void {
			left = false;
		}*/		
		
	}

}