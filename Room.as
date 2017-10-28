package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Room extends MovieClip {
		
		private var doorArray:Array;
		public function Room(doorArray:Array) {
			// constructor code
			this.doorArray = doorArray;
			init();
		}
		private function init(): void {
			for (var i:int = 0; i > doorArray.length; i++) {
				addDoorToRoom(doorArray[i]);
			}
		}
		
		private function addDoorToRoom(door:Door): void {
			door.x = door.xPos;
			door.y = door.yPos;
			addChild(door);
			door.parentRoom = this;
		}
	}
}
