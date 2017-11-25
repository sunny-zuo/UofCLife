package {

	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.*;


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
			
			//WASHROOM MALE
			doorList[0] = new Door(GreenDoor, 350, 0);
			doorList[1] = new Door(GreenDoor, 1600, 0);
			
			//WASHROOM FEMALE
			doorList[2] = new Door(GreenDoor, 500, 0);
			doorList[3] = new Door(GreenDoor, 800, 0);
			
			//BENTO SUSHI
			doorList[4] = new Door(GreenDoor, 2175, 0);
			doorList[5] = new Door(GreenDoor, 200, 0);
			
			//CLASSROOM
			doorList[6] = new Door(GreenDoor, 3000, 0);
			doorList[7] = new Door(GreenDoor, 150, 0);
			
			//STAIRS
			//doorList[8] = new Door(GreenDoor, 3750, 0);
			//doorList[9] = new Door(GreenDoor, 0, 0);
			
			for(var i:int = 0; i < doorList.length; i++){
				if(i % 2 == 0){
					doorList[i].linkDoor = doorList[i+1];
				}else{
					doorList[i].linkDoor = doorList[i-1];
				}
			}
			
			//STRANGER CONSTRUCTION
			var tempStranger:Stranger;
			strangerList = []
			
			tempStranger = new Stranger(2000, 0, ["Bento Sushi is going down!!!"]);
			strangerList.push(tempStranger);
			
			tempStranger = new Stranger(1550, 0, ["Geography is for nerds like me!", "I dare thee to a geography duel!"]);
			strangerList.push(tempStranger);
	
			//ROOM CONSTRUCTION
			var tempRoom:Room;
			roomList = []
			
			tempRoom = new Room(4000, EducationBuilding, [doorList[0], doorList[2], doorList[4], doorList[6]], [strangerList[0]]);
			roomList.push(tempRoom);
			
			tempRoom = new Room(1800, WashroomMale, [doorList[1]], []);
			roomList.push(tempRoom);
		
			
			tempRoom = new Room(1000, WashroomFemale, [doorList[3]], []);
			roomList.push(tempRoom);
			
			tempRoom = new Room(800, BentoSushi, [doorList[5]], []);
			roomList.push(tempRoom);
			
			tempRoom = new Room(1700, EducationClassroom0, [doorList[7]], [strangerList[1]]);
			roomList.push(tempRoom);
			
			//tempRoom = new Room(1200, Stairs, [doorList[9]], []);
			//roomList.push(tempRoom);
			
			//LOAD CURRENT ROOM
			currentRoom = roomList[0];
			currentRoom.y = stg.stageHeight;
			objectContainer.addChild(currentRoom);
			
			//Adds the Character
			character = new Character();
			character.y = 545
			
			objectContainer.addChild(character);
		}
		
		private function vCam(event:Event):void{
			//trace(getQualifiedClassName(currentRoom.backGround));
			//trace(-character.x + stage.stageWidth/2, stage.stageWidth - currentRoom.roomWidth - 100);
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