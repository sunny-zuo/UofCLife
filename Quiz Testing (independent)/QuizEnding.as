package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class QuizEnding extends MovieClip{
		
		private var questionsCorrect:int;
		private var questionsIncorrect:int;
		private var passingPercentage:int;
		private var obtainedPercentage:int;
		
		public var readyToClose:Boolean = false;

		public function QuizEnding(questionsCorrect:int, questionsIncorrect:int, passingPercentage:int) {
			// constructor code
			this.questionsCorrect = questionsCorrect;
			this.questionsIncorrect = questionsIncorrect;
			this.passingPercentage = passingPercentage;
			obtainedPercentage = (questionsCorrect/(questionsCorrect+questionsIncorrect)) * 100;
			init();
		}
		
		private function init():void {
			trace(obtainedPercentage)
			this.quizPercentage.text = "You scored " + obtainedPercentage + "%";
			if (obtainedPercentage >= passingPercentage) {
				this.quizResult.text = "Congrats, you passed the quiz!";
			}
			else {
				this.quizResult.text = "You failed!";
			}
			exit_btn.addEventListener(MouseEvent.CLICK, closeQuiz);
		}
		
		private function closeQuiz(event:MouseEvent) {
			readyToClose = true;
		}

	}
	
}
