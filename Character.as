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
		private var xDelta: DeltaAssist;
		private var tempHolder;
		
		//the animations for the accesories are frames 1 = idle right, 2 = idle left, 3-5 = walk left, 6-8 = walk right
		
		private var characterAccesories:Array = [2,1] // an array for accesories 1=hat 2=shirt 3=pants
		private var characterAccesoriesHolder:Array = []
		private var characterBody:Array = [] 
		
		public var allowCharMove:Boolean = true;

		public function Character(): void {
			// constructor code
		//adds evnt lister for when itself is added to stage
			addEventListener(Event.ADDED_TO_STAGE, addedToStage)

		}

		//adds the event listeners once it is added to stage
		private function addedToStage(event: Event): void {
			drawAccesories(characterAccesories[0],characterAccesories[1])
			addEventListener(Event.ENTER_FRAME, eFrame);
			stage.addEventListener(MouseEvent.MOUSE_UP, MouseRelease);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, MousePress);
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
			
		}

		//moves the character left and right
		private function eFrame(event: Event): void {
			if (allowCharMove) {
				if (mouseDown) {
					if (mouseX < 0) {
						walkLeft()
					}
					else {
						walkRight()
					}
				} else {
					if (mouseX < 0) {
						gotoAndStop("idleLeft")
						characterAccesoriesHolder[1].gotoAndStop("idleLeft")
						
					} else {
						gotoAndStop("idleRight")
						characterAccesoriesHolder[1].gotoAndPlay("idleRight")
					}
				}
			}
			if(x - width/2 < 0){
				x = width/2;
			}
			else if(x + width/2 > Main.instance.currentRoom.roomWidth){
				x = Main.instance.currentRoom.roomWidth - width/2;
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

		public function moveCharToDoor(door: Door) {
			if (xDelta) {
				xDelta.setActive(false);
			}
			xDelta = new DeltaAssist(this, ["x"]);
			if (door.x >= x) {
				xDelta.setLinear(5, door.x, enterDoor, [door]);
			} else {
				xDelta.setLinear(-5, door.x, enterDoor, [door]);
			}
		}
		
		private function walkRight():void {
			if(currentLabel != "walkRight") {
				characterAccesoriesHolder[1].gotoAndPlay("walkRight")
				gotoAndPlay("walkRight")
			}
			x += speed;
		}
		
		private function walkLeft():void {
			if(currentLabel != "walkLeft") {
				characterAccesoriesHolder[1].gotoAndPlay("walkLeft")
				gotoAndPlay("walkLeft")
			}
			x -= speed;
		}
		
		private function enterDoor(door:Door){
			Main.instance.objectContainer.removeChild(Main.instance.currentRoom);
			//remove room currently in
			var exitDoor:Door = door.linkDoor;
			//door where character will exit
			
			Main.instance.currentRoom = exitDoor.parentRoom;
			//set the currentRoom to the new room
			Main.instance.currentRoom.y = Main.stg.stageHeight;
			Main.instance.objectContainer.addChildAt(Main.instance.currentRoom, 0);
			//add the new room
			
			x = exitDoor.x;
			
			allowCharMove = true;
			//allow the character to move again
		}
		
		private function drawAccesories(HatType:Number, PantType:Number):void {
			if (HatType == 1) {
				tempHolder = new Hat1
			} else if(HatType == 2) {
				tempHolder = new Hat2
			}
			tempHolder.y = Main.instance.character.height*-1
			characterAccesoriesHolder[0] = tempHolder
			Main.instance.character.addChild(tempHolder)
			
			if(PantType == 1) {
				tempHolder = new Pant1
			}
			
			tempHolder.y = 0//Main.instance.character.height*-1
			characterAccesoriesHolder[1] = tempHolder
			Main.instance.character.addChild(tempHolder)
		}

	}

}