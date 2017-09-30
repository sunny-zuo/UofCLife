package  {
	import flash.display.MovieClip;
	public class DuncanTest extends MovieClip{

		public function DuncanTest() {
			var str:Stranger = new Stranger(["wow"], "Jerry", true, false, 10000);
			str.x = 500;
			str.y = 400;
			stage.addChild(str);
		}
		
	}
	
}
