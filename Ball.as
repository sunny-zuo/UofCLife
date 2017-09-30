package  {
	import flash.display.Sprite;
	import flash.events.Event;


	
	public class Ball extends Sprite{
		public var radius:Number;
		public var color:uint;
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var mass:Number = 1;

		public function Ball(radius:Number = 40, color:uint = 0x0000ff) {
			// constructor code
			this.radius = radius;
			this.color = color;
			graphics.beginFill(color);
			graphics.drawCircle(0,0,radius);
			graphics.endFill();

		}


	}
	
}
