package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public class Door extends MovieClip {

		private var character: Character;
		private var enterSymbol;
		private static var side: int = 1;
		public var xPos:Number;
		public var yPos:Number;
		public var parentRoom:MovieClip;

		public function Door(xPos:Number, yPos:Number) {
			// constructor code
			this.xPos = xPos;
			this.yPos = yPos;
			init()
		}
		private function init(): void {
			addEventListener(Event.ENTER_FRAME, onDoorTouch);
		}

		
		/*When character touches door, a new symbol is created if one does not exist
		If a symbol exists then it is added above the door*/
		private function onDoorTouch(event: Event): void {
			character = Main.instance.character;
			if (this.hitTestObject(character)) {
				if (enterSymbol) {
					this.addChild(enterSymbol);
					enterSymbol.visible = true;
				} else {
					AddDoorSymbol();
				}
				stage.addEventListener(MouseEvent.CLICK, onDoorClick);
			} else {
				if (enterSymbol) {
					enterSymbol.visible = false;
				}
				stage.removeEventListener(MouseEvent.CLICK, onDoorClick);
			}
		}

		private function onDoorClick(event: MouseEvent): void {
			side = 2;
			
		}

		/* Recturns a door symbol*/
		private function AddDoorSymbol(): void {
			enterSymbol = new EnterSymbol()
			enterSymbol.y -= 230;
			this.addChild(enterSymbol);
		}
	}
}