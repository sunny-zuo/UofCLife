package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Door extends MovieClip {

		private var enterSymbol;
		private static var side: int = 1;
		public var xPos: Number;
		public var yPos: Number;
		public var parentRoom: MovieClip;
		private var doorArt: MovieClip;
		private var characterIsCloseToDoor:Boolean = false;
		

		public function Door(doorType: Class, xPos: Number, yPos: Number) {
			// constructor code
			this.xPos = xPos;
			this.yPos = yPos;
			//character = Main.instance.character;
			init(doorType)
		}
		private function init(doorType: Class): void {
			doorArt = new doorType();
			addChild(doorArt);
			
			addEventListener(MouseEvent.CLICK, onDoorClick);
			addEventListener(Event.ENTER_FRAME, onDoorTouch);
			
		}

		/*When character touches door, a new symbol is created if one does not exist
		If a symbol exists then it is added above the door*/
		private function onDoorTouch(event: Event): void {
			if (Main.instance.character)
				if (this.x + 200 >= Main.instance.character.x && this.x - 200 <= Main.instance.character.x) {
					if (enterSymbol) {
						this.addChild(enterSymbol);
						enterSymbol.visible = true;
						characterIsCloseToDoor = true
					} 
					else {
						addDoorSymbol();
					}
				}
				else {
					if (enterSymbol) {
						enterSymbol.visible = false;
						characterIsCloseToDoor = false
					}
				}
		}
		/* Recturns a door symbol*/
		private function addDoorSymbol(): void {
			enterSymbol = new EnterSymbol()
			enterSymbol.y -= 250;
			this.addChild(enterSymbol);
		}
		
		private function onDoorClick(event:MouseEvent):void {
			if(characterIsCloseToDoor) {
				Main.instance.character.allowCharMove = false;
				Main.instance.character.moveCharTo(x);
				
				
			}
		}
	}
}