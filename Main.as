package {
	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;


	public class Main extends MovieClip {


		public var character: Character = new Character();
		private var eduBld: Room;
		private var enterSymbol: MovieClip;
		private var left: Boolean = false;
		private var right: Boolean = false;
		public static var instance: Main;

		public function Main() {
			instance = this;
			// constructor code
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp);

			character.y = 400;

			eduBld = new Room();
			stage.addChild(eduBld);
			addChild(character);
		}

		private function onEnterFrame(event: Event) {
			if (left) {
				character.x -= 5;
			}
			if (right) {
				character.x += 5;
			}
		}

		private function onMouseClick(event: MouseEvent): void {
			//stage.remove
		}

		private function onDown(event: KeyboardEvent) {
			if (event.keyCode == 65) {
				left = true;
			}
			if (event.keyCode == 68) {
				right = true;
			}

		}
		private function onUp(event: KeyboardEvent) {
			if (event.keyCode == 65) {
				left = false;
			}
			if (event.keyCode == 68) {
				right = false;
			}

		}
	}
}