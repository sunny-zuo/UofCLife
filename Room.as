package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Room extends MovieClip {
		public var roomWidth:Number;
		public var backGround:MovieClip;
		private var doorArray:Array;
		private var strangerArray:Array;
		private var otherArray:Array;
		private var ID:int;
		
		public function Room(roomWidth:Number, backGroundClass:Class, doorArray:Array, strangerArray:Array, otherArray:Array = null, ID:int = 0) {
			// constructor code
			this.roomWidth = roomWidth;
			this.backGround = backGround;
			this.doorArray = doorArray;
			this.strangerArray = strangerArray;
			this.otherArray = otherArray;
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
			
			if(otherArray != null){
				for (var k:int = 0; k < otherArray.length; k++){
					addOtherToRoom(otherArray[k]);
				}
			}
			
		}
		
		private function addDoorToRoom(door:Door): void {
			//trace(Main.instance.doorList.indexOf(door));
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
		
		private function addOtherToRoom(other:MovieClip):void{
			other.x = other.xPos;
			other.y = other.yPos;
			addChild(other);
		}
	}
}
