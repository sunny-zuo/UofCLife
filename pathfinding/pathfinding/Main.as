package {

	import flash.display.MovieClip;

	public class Main extends MovieClip {

		public var doorList: Array;
		public var roomList: Array;
		public static var instance: Main;

		public function Main() {
			// constructor code
			start();
		}

		private function start(): void {

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

			for (var i: int = 0; i < doorList.length; i++) {
				if (i % 2 == 0) {
					doorList[i].linkDoor = doorList[i + 1];
				} else {
					doorList[i].linkDoor = doorList[i - 1];
				}
			}

			//room construction
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
		}

	}

}