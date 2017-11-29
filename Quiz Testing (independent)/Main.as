package {
	import flash.display.MovieClip;

	public class Main extends MovieClip{
		public function Main() {
			var quizPopup:QuizPopup = new QuizPopup(2, "Geography", "easy");
			addChild(quizPopup);
			quizPopup.x += 360;
			quizPopup.y += 240;
		}
	}
}