package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Room extends MovieClip {
		public var roomWidth:Number;
		public var backGround:MovieClip;
		private var doorArray:Array;
		private var strangerArray:Array;
		
		
		public function Room(roomWidth:Number, backGroundClass:Class, doorArray:Array, strangerArray:Array) {
			// constructor code
			this.roomWidth = roomWidth;
			this.backGround = backGround;
			this.doorArray = doorArray;
			this.strangerArray = strangerArray;
			init(backGroundClass);
		}
		private function init(backGroundClass:Class): void {
			//BACKGROUND
			backGround = new backGroundClass();
			addChild(backGround);
			//add the background to the room
			
			//ROOM
			for (var i:int = 0; i < doorArray.length; i++) {
				addDoorToRoom(doorArray[i]);
			}
			
			//STRANGERS
			for (var j:int = 0; j < strangerArray.length; j++){
				addStrangerToRoom(strangerArray[j]);
			}
		}
		
		private function addDoorToRoom(door:Door): void {
			door.x = door.xPos;
			door.y = door.yPos;
			addChild(door);
			door.parentRoom = this;
		}
		
		private function addStrangerToRoom(stranger:Stranger):void{
			stranger.x = stranger.xPos;
			stranger.y = stranger.yPos;
			addChild(stranger);
		}
	}
}
