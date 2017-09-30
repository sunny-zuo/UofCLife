package  {
	import flash.display.MovieClip;
	public class Main extends MovieClip{

		public function Main() {
			var str:Stranger = new Stranger("bobby", ["wow"]);
			str.x = 300;
			str.y = 300;
			stage.addChild(str);
			
			var tb:TextBox = new TextBox(["hi", "wow"], str);
			stage.addChild(tb);
		}

	}
	
}
