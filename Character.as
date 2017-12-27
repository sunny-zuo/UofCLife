package {
	//imports packages
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.events.TouchEvent;
	import flash.events.MouseEvent;

	public class Character extends MovieClip {
		private var mouseDown: Boolean = false; //left and right booleans
		private var characterMovementDirection = "IDLE"
		private var speed: int = 10; //the player speed
		private var xDelta: DeltaAssist;
		private var tempHolder;

		//the animations for the accesories are frames 1 = idle right, 2 = idle left, 3-5 = walk left, 6-8 = walk right

		private var characterAccesories: Array = [1, 1] // an array for accesories 1=hat 2=shirt 3=pants
		private var characterAccesoriesHolder: Array = []
		private var characterBody: Array = []
		private var uncontrolledMove: String = ""

		public var allowCharMove: Boolean = true; //this is a variable that will prevent the character from moving under ANY circumstances
		public var allowPlayerControl: Boolean = true; //variable that determines weather the PLAYER can control the characters movements. Allows for non player movement

		public function Character(): void {
			// constructor code
			//adds evnt lister for when itself is added to stage
			addEventListener(Event.ADDED_TO_STAGE, addedToStage)

		}

		//adds the event listeners once it is added to stage
		private function addedToStage(event: Event): void {
			drawAccesories(characterAccesories[0], characterAccesories[1])
			addEventListener(Event.ENTER_FRAME, eFrame);
			stage.addEventListener(MouseEvent.MOUSE_UP, MouseRelease);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MousePress);
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage)

		}

		//moves the character left and right
		private function eFrame(event: Event): void {
	
			
			if (allowCharMove) {
				if (allowPlayerControl) {
					if (mouseDown) { //updates the characters move state
						if (mouseX < 0) {
							characterMovementDirection = "LEFT"
						} else {
							characterMovementDirection = "RIGHT"
						}
					} else { //if the mouse is up, idle
						characterMovementDirection = "IDLE"
					}
				}

				//moves the charactrer according to the characterMovementDirection
				if (characterMovementDirection == "RIGHT") {
					walkRight(true)
				} else if (characterMovementDirection == "LEFT") {
					walkLeft(true)
				} else {
					if (mouseX < 0) {
						gotoAndStop("idleLeft")
					} else {
						gotoAndStop("idleRight")
					}
				}

				//if the character is moving in a "cutscene"
				if (uncontrolledMove == "left") {
					walkLeft(false)
				} else if (uncontrolledMove == "right") {
					walkRight(false)
				}
			} else {
				
				//Idles the character in a way that it won't turn to face the mouse
				if (currentLabel != "idleLeft") {
					if (currentLabel != "idleRight") {
						if (mouseX < 0) {
							gotoAndStop("idleLeft")
						} else {
							gotoAndStop("idleRight")
						}

					}
				}
			}



			//boundries
			if (x - width / 2 < 0) {
				x = width / 2;
			} else if (x + width / 2 > Main.instance.currentRoom.roomWidth) {
				x = Main.instance.currentRoom.roomWidth - width / 2;
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

		//moves the character to the door
		public function moveCharToDoor(door: Door) {
			
			if (xDelta) {
				xDelta.setActive(false);
			}
			xDelta = new DeltaAssist(this, ["x"]);
			if (door.x >= x) {
				xDelta.setLinear(5, door.x, enterDoor, [door]);
				uncontrolledMove = "right"
			} else {
				xDelta.setLinear(-5, door.x, enterDoor, [door]);
				uncontrolledMove = "left"
			}
		}

		private function walkRight(moveCharacter: Boolean): void {

			if (currentLabel != "walkRight") {
				gotoAndPlay("walkRight")
			}
			if (moveCharacter) {
				x += speed;
			}
		}

		private function walkLeft(moveCharacter: Boolean): void {


			if (currentLabel != "walkLeft") {
				gotoAndPlay("walkLeft")

			}
			if (moveCharacter) {
				x -= speed;
			}
		}

		private function enterDoor(door: Door) {
			Main.instance.objectContainer.removeChild(Main.instance.currentRoom);
			//remove room currently in
			var exitDoor: Door = door.linkDoor;
			//door where character will exit

			Main.instance.currentRoom = exitDoor.parentRoom;
			//set the currentRoom to the new room
			Main.instance.currentRoom.y = Main.stg.stageHeight;
			Main.instance.objectContainer.addChildAt(Main.instance.currentRoom, 0);
			//add the new room

			x = exitDoor.x;

			allowPlayerControl = true;
			//allow the character to move again
			uncontrolledMove = ""
		}

		private function drawAccesories(HatType: Number, PantType: Number): void {
			/*			if (HatType == 1) {
				tempHolder = new Hat1
			} else if (HatType == 2) {
				tempHolder = new Hat2
			}
			tempHolder.y = Main.instance.character.height * -1
			characterAccesoriesHolder[0] = tempHolder
			Main.instance.character.addChild(tempHolder)*/

			this.pant1.gotoAndStop(1)
			/*			this.pant2.gotoAndStop(characterAccesories[1])
			this.pant3.gotoAndStop(characterAccesories[1])
			this.pant4.gotoAndStop(characterAccesories[1])*/

		}

	}

}