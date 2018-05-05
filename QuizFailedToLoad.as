package {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class QuizFailedToLoad extends MovieClip {

		public function QuizFailedToLoad() {
			// constructor code
			init();
		}

		private function init(): void {
			exitButton.addEventListener(MouseEvent.CLICK, exit);
		}

		private function exit(event: MouseEvent): void {
			exitButton.removeEventListener(MouseEvent.CLICK, exit);
			this.parent.removeChild(this);
		}

	}

}