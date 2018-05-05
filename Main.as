package {

	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.*;
	import flash.net.registerClassAlias;
	import flash.desktop.NativeApplication;
	import flash.net.SharedObject;


	public class Main extends MovieClip {
		public static var instance: Main;
		public static var stg: Stage;

		public static var itemList: ItemList;

		public static var sharedObjectName: String = "xks3as28s9q-dskjadg894" //random string that's the name of the shared object file. Change if you need to reset achievement data.
		private var savedData: SharedObject;
		private var version: Number

		public var achievementFront: AchievementFront = new AchievementFront();

		public var time: TimeController = new TimeController();

		public var character: Character;
		private var cat: Cat;
		public var inventory: Inventory;
		private var eduBld: Room;
		private var enterSymbol: MovieClip;
		private var left: Boolean = false;
		private var right: Boolean = false;
		
		private var stageHeight:Number = 540

		public var initComplete: Boolean = false;

		private var inventoryButton: InventoryButton;
		private var achievementButton: AchievementButton;

		public var doorList: Array;
		public var roomList: Array;
		public var strangerList: Array;

		public var currentRoom: Room;

		public var currentRoomNum:int = 0;

		public var menuContainer: MovieClip;


		public var objectContainer: MovieClip;
		//contains all game objects in the game (excluding following menus)
		public function Main() {
			// constructor code
			savedData = SharedObject.getLocal("save");
			instance = this;
			stg = stage;

			objectContainer = new MovieClip();
			stage.addChild(objectContainer);

			menuContainer = new MovieClip();
			stage.addChild(menuContainer);
			
			start();
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, appDeactivated); //runs when app is closed
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, appActivated); //runs when app is opened
		}

		private function start(): void {
			
			menuContainer.removeChildren();
			objectContainer.removeChildren();
			
			//DOOR CONSTRUCTION
			var tempDoor: Door;
			doorList = [];

			//WASHROOM MALE
			doorList[0] = new Door(GreenDoor, 350, 0, 1);
			doorList[1] = new Door(GreenDoor, 1600, 0, 0);

			//WASHROOM FEMALE
			doorList[2] = new Door(GreenDoor, 500, 0, 2);
			doorList[3] = new Door(GreenDoor, 800, 0, 0);

			//BENTO SUSHI
			doorList[4] = new Door(GreenDoor, 2175, 0, 3);
			doorList[5] = new Door(GreenDoor, 200, 0, 0);

			//CLASSROOM
			doorList[6] = new Door(GreenDoor, 3000, 0, 4);
			doorList[7] = new Door(GreenDoor, 150, 0, 0);

			//STAIRS
			//doorList[8] = new Door(GreenDoor, 3750, 0);
			//doorList[9] = new Door(GreenDoor, 0, 0);

			if (savedData.data.doorList != undefined) {
				for (var i: int = 0; i < doorList.length; i++) {
					if (doorList[i] != savedData.data.doorList[i]) {
						savedData.data.doorList[i] = doorList[i];
					}
				}
			} else {
				savedData.data.doorList = doorList;
			}

			doorList = savedData.data.doorList;
			for (var ii: int = 0; ii < doorList.length; ii++) {
				if (ii % 2 == 0) {
					doorList[ii].linkDoor = doorList[ii + 1];
				} else {
					doorList[ii].linkDoor = doorList[ii - 1];
				}
			}

			//The Confession Board
			var confessionBoard: ConfessionBoard = new ConfessionBoard(2600, -200);
			inventory = new Inventory();
			inventory.startGUI();

			//STRANGER CONSTRUCTION
			var tempStranger: Stranger;
			strangerList = []

			tempStranger = new Stranger(1, 1000, 0, ["Accept this gift!", [MenuController.generateDecisionBox, "fcn_sayDialog", [], "fcn_skipToSayDialog", [4], tempStranger], "Have this garbage! Haha loser...", [inventory.addItem, "_2", 1],
				["fcn_skipToSayDialog", -1], "Why do you not want...", ["fcn_skipToSayDialog", -1]
			]);
			strangerList[0] = tempStranger;

			tempStranger = new Stranger(2, 2000, 0, ["I wonder what this sushi place is called", "If only they would kindly pay us", "Then we can put a sign on the store", "Don't you agree?", [MenuController.generateDecisionBox, "fcn_sayDialog", [], "fcn_skipToSayDialog", [8], tempStranger], "You're a sensible young man", "Now if only #$&@% Sushi staff are as sensible as you...", ["fcn_skipToSayDialog", -1], "WHAT?!?!?!", "Its a reasonable price for advertisement...", ["fcn_skipToSayDialog", -1]]);

			strangerList[1] = tempStranger;

			tempStranger = new Stranger(3, 1550, 0, ["Geography is for nerds like me!", "I dare thee to a geography duel!", [MenuController.generateDecisionBox, "fcn_generateQuiz", [1, "Geography", "easy", 10, "multiple", 100], "fcn_skipToSayDialog", [4], tempStranger],
				["fcn_clearDialog"], "Fight me scrub", ["fcn_skipToSayDialog", -1]
			]);
			//tempStranger = new Stranger(3, 1550, 0, [["fcn_addQuizDialog"]]);

			time.addTimeEvent(
				tempStranger, [0, 10, 8, -1, -1], [
					["WALKTO", 150],
					["GOTOROOM", 0, 3000],
					["WALKTO", 1600],
					["GOTOROOM", 1, 1600]
				]); //activate every hour at 30 min

			strangerList[2] = tempStranger;

			tempStranger = new Stranger(4, 2000, 0, ["Hi I am the neighborhood bully.", "Give me $5", "Thank you very much.", [inventory.removeItem, "_1", 5]]);
			strangerList[3] = tempStranger;

			tempStranger = new Stranger(5, 100, 0, ["Hello I am the owner of this sushi place", [MenuController.generateShop, 'Bento Sushi', ['_3', '_4'],
				[2, 1]
			]])
			strangerList[4] = tempStranger;

			if (savedData.data.strangerList != undefined) {
				for (var iii: int = 0; iii < strangerList.length; iii++) {
					if (strangerList[iii] != savedData.data.strangerList[iii]) {
						savedData.data.strangerList[iii] = strangerList[iii];
					}
				}
			} else {
				savedData.data.strangerList = strangerList;
			}

			//ROOM CONSTRUCTION
			var tempRoom: Room;
			roomList = []

			tempRoom = new Room(0, 4000, EducationBuilding, [doorList[0], doorList[2], doorList[4], doorList[6]], [strangerList[0], strangerList[1]], [confessionBoard]);
			roomList.push(tempRoom);

			tempRoom = new Room(1, 1800, WashroomMale, [doorList[1]], []);
			roomList.push(tempRoom);


			tempRoom = new Room(2, 1000, WashroomFemale, [doorList[3]], []);
			roomList.push(tempRoom);

			tempRoom = new Room(3, 800, BentoSushi, [doorList[5]], [strangerList[4]]);
			roomList.push(tempRoom);

			tempRoom = new Room(4, 1700, EducationClassroom0, [doorList[7]], [strangerList[2]]);
			roomList.push(tempRoom);

			//tempRoom = new Room(1200, Stairs, [doorList[9]], []);
			//roomList.push(tempRoom);

			if (savedData.data.roomList != undefined) {
				for (var iv: int = 0; iv < roomList.length; iv++) {
					if (roomList[iv] != savedData.data.roomList[iv]) {
						savedData.data.roomList[iv] = roomList[iv];
					}
				}
			} else {
				savedData.data.roomList = roomList;
			}

			//Adds the Character
			if (savedData.data.characterPos == undefined) {
				var tempPos: Array = new Array();
				tempPos.push(2200);
				tempPos.push(545);
				savedData.data.characterPos = tempPos;
			}

			menuContainer.addChild(inventory);

			inventoryButton = new InventoryButton();
			inventoryButton.x = 11;
			inventoryButton.y = 11;
			menuContainer.addChild(inventoryButton);
			achievementButton = new AchievementButton();
			achievementButton.x = 76;
			achievementButton.y = 11;
			menuContainer.addChild(achievementButton);
			
			//generates room and character
			currentRoom = roomList[savedData.data.currentRoom];
			currentRoom.y = stageHeight;
			objectContainer.addChildAt(currentRoom, 0);
			currentRoomNum = savedData.data.currentRoom

			character = new Character();
			character.x = Number(savedData.data.characterPos[0]);
			character.y = Number(savedData.data.characterPos[1])
			objectContainer.addChild(character);
			

			inventory.inventory[0] = [ItemList._1[0], 15];
			//trace(inventory.inventory[1])

			//VCAM
			addEventListener(Event.ENTER_FRAME, vCam);
			savedData.flush();
			initComplete = true;
		}

		private function appDeactivated(event: Event) {
			//code runs when the app is closed by the user
			savedData.data.characterPos[0] = character.x;
			savedData.data.characterPos[1] = character.y;
			savedData.data.currentRoom = currentRoomNum;
			
			trace("after deactivated, x = " + savedData.data.characterPos[0] + " and y = " + savedData.data.characterPos[1])
			
			menuContainer.removeChildren();
			objectContainer.removeChildren();
			
			removeEventListener(Event.ENTER_FRAME, vCam);
			
			savedData.flush();
		}

		private function appActivated(event: Event) {
			if (savedData.data.currentRoom == undefined) {
				savedData.data.currentRoom = 0;
			}
			//code runs when the app is opened by the user
			
			start();
			
			trace("after activated, x = " + character.x + " and y = " + character.y)
		}

		private function vCam(event: Event): void {
			//trace(getQualifiedClassName(currentRoom.backGround));
			//trace(-character.x + stage.stageWidth/2, stage.stageWidth - currentRoom.roomWidth - 100);
			if (-character.x + stage.stageWidth / 2 > 100) {
				objectContainer.x += (100 - objectContainer.x) * 0.25;
			} else if (-character.x + stage.stageWidth / 2 < stage.stageWidth - currentRoom.roomWidth - 100) {
				objectContainer.x += (stage.stageWidth - currentRoom.roomWidth - 100 - objectContainer.x) * 0.25;
			} else {
				objectContainer.x += (-character.x + stage.stageWidth / 2 - objectContainer.x) * 0.25;
			}

			clock.text = " seconds: " + time.getTime(0) + " minutes: " + time.getTime(1) + " hours: " + time.getTime(2) + " days: " + time.getTime(3);

		}

	}
}