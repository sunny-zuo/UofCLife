package minigame_cheat {
	import flash.display.MovieClip;
	import Controllers.TextController;
	public class PlayerPaper extends MovieClip{
		
		public function PlayerPaper(loadedData:Object) {
			txt_q1.text = TextController.removeASCII(loadedData.results[0].question);
			txt_q2.text = TextController.removeASCII(loadedData.results[1].question);
			txt_q3.text = TextController.removeASCII(loadedData.results[2].question);
		}

	}
	
}
