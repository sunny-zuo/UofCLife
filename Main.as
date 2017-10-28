package {
	import flash.display.MovieClip;
	
	public class Main extends MovieClip {
		private var player: Character; //makes a player from the ball class


		public function Main() {
			// constructor code
			start()
		}

		private function start(): void {
			//makes the player
			player = new Character();
			stage.addChild(player);
			player.x = stage.stageWidth / 2
			player.y = stage.stageWidth / 2
		}

			
		
	}

}