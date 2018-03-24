package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Door extends MovieClip {

		private var enterSymbol;
		public var xPos: Number;
		public var yPos: Number;
		public var parentRoom: Room;
		public var linkDoor:Door;
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
			if (Main.instance.character){
				if (this.x + 200 >= Main.instance.character.x && this.x - 200 <= Main.instance.character.x) {
				//if character is within 200 pixels of the door, show the symbol
					if (enterSymbol) { //if the symbol exists, add it as a child, make it visible, and mark the character as close to the door
						this.addChild(enterSymbol);
						enterSymbol.visible = true;
						characterIsCloseToDoor = true
					}
					else {
						addDoorSymbol(); //if the symbol doesn't exist, create it
					}
				}
				else {
					if (enterSymbol) {
						enterSymbol.visible = false;
						characterIsCloseToDoor = false
					}
				}
			}
		}
		/* Returns a door symbol*/
		private function addDoorSymbol(): void {
			enterSymbol = new EnterSymbol()
			enterSymbol.y -= 250;
			this.addChild(enterSymbol);
		}
		
		//moves the character to the door if the character is close to the door and the player taps the door
		private function onDoorClick(event:MouseEvent):void {
			if(characterIsCloseToDoor) {
				Main.instance.character.allowPlayerControl = false; //prevents the player from moving
				Main.instance.character.moveCharToDoor(this); //moves the player to the door automatically using delta
				
				
			}
		}
	}
}
