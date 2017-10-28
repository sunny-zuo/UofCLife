package {

	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;


	public class Main extends MovieClip {
		public static var instance: Main;
		public static var stg: Stage;


		public var character: Character;
		private var eduBld: Room;
		private var enterSymbol: MovieClip;
		private var left: Boolean = false;
		private var right: Boolean = false;
		
		
		public var doorList:Array;
		public var roomList:Array;
		public var strangerList:Array;
		
		public var currentRoom:Room;
		
		public var objectContainer:MovieClip;
		//contains all game objects in the game (excluding following menus)

		public function Main() {

			// constructor code
			start()
		}

		private function start(): void {
			instance = this;
			stg = stage;

			objectContainer = new MovieClip();
			stage.addChild(objectContainer);
			
			//VCAM
			addEventListener(Event.ENTER_FRAME, vCam);
			
			//DOOR CONSTRUCTION
			var tempDoor:Door;
			doorList = [];
			
			tempDoor = new Door(GreenDoor, 500, 0);
			doorList.push(tempDoor);
			tempDoor = new Door(GreenDoor, 200, 0);
			doorList.push(tempDoor);
			
			tempDoor = new Door(GreenDoor, 700, 0);
			doorList.push(tempDoor);
			tempDoor = new Door(GreenDoor, 550, 0);
			doorList.push(tempDoor);
			
			//STRANGER CONSTRUCTION
			var tempStranger:Stranger;
			strangerList = []
			
			tempStranger = new Stranger(300, 0, ["Bento Sushi is going down!!!"]);
			strangerList.push(tempStranger);
			
			//ROOM CONSTRUCTION
			var tempRoom:Room;
			roomList = []
			
			tempRoom = new Room(960, Room0, [doorList[0], doorList[2]], [strangerList[0]]);
			roomList.push(tempRoom);
			
			tempRoom = new Room(700, Room1, [doorList[1], doorList[3]], []);
			roomList.push(tempRoom);
			
			//LOAD CURRENT ROOM
			currentRoom = roomList[0];
			currentRoom.y = stg.stageHeight;
			objectContainer.addChild(currentRoom);
			
			//Adds the Character
			character = new Character();
			character.y = 400;
			
			objectContainer.addChild(character);
		}
		
		private function vCam(event:Event):void{
			trace(-character.x + stage.stageWidth/2, stage.stageWidth - currentRoom.roomWidth - 100);
			if(-character.x + stage.stageWidth/2 > 100){
				objectContainer.x += (100 - objectContainer.x)*0.25;
			}
			else if(-character.x + stage.stageWidth/2 < stage.stageWidth - currentRoom.roomWidth - 100){
				objectContainer.x += (stage.stageWidth - currentRoom.roomWidth - 100 - objectContainer.x)*0.25;
			}
			else{
				objectContainer.x += (-character.x + stage.stageWidth/2 - objectContainer.x)*0.25;
			}
			
		}
	}
}