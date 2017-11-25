package {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class QuizPopup extends MovieClip {

		private var questionCount: int;
		private var topic: String;
		private var difficulty: String;
		private var qType: String;
		
		private var currentQuestion:int = 0;
		private var correctAnswer:int;
		
		private var correctCount:int = 0;
		private var incorrectCount:int = 0;
		
		private var loadedData: Object;

		private var questionBoxList: Array;

		private var questionAPI: QuestionAPI = new QuestionAPI();

		private var timer: Timer = new Timer(1000);

		public function QuizPopup(questionCount: int, subject: String, difficulty: String, qType: String = "multiple") {
			// constructor code
			this.questionCount = questionCount;
			this.topic = subject;
			this.difficulty = difficulty;
			this.qType = qType;
			init();
		}

		private function init() {
			questionAPI.fetchQuestions(questionCount, topic, difficulty, qType);
			questionBoxList = new Array();
			questionBoxList[0] = answer0.answerText;
			questionBoxList[1] = answer1.answerText;
			questionBoxList[2] = answer2.answerText;
			questionBoxList[3] = answer3.answerText;

			timer.addEventListener(TimerEvent.TIMER, generateQuestions);
			timer.start();
			
			answer0.addEventListener(MouseEvent.CLICK, answer0picked)
			answer1.addEventListener(MouseEvent.CLICK, answer1picked)
			answer2.addEventListener(MouseEvent.CLICK, answer2picked)
			answer3.addEventListener(MouseEvent.CLICK, answer3picked)
		}
		private function generateQuestions(event: Event) {
			if (timer != null) {
				timer.removeEventListener(TimerEvent.TIMER, generateQuestions);
				timer = null;
			}
			if (loadedData == null) {
				loadedData = questionAPI.loadedData;
			}
			questionText.text = loadedData.results[currentQuestion].question;
			correctAnswer = Math.floor(Math.random() * 4);
			questionBoxList[correctAnswer].text = loadedData.results[currentQuestion].correct_answer;
			
			var answerPlaced:int = 0;
			for (var i:int = 0; i < 4; i++) {
				if (questionBoxList[i].text != loadedData.results[currentQuestion].correct_answer) {
					questionBoxList[i].text = loadedData.results[currentQuestion].incorrect_answers[answerPlaced];
					answerPlaced++
				}
			}
		}
		
		private function answer0picked(event:MouseEvent) {
			if (correctAnswer == 0) {
				correctCount++;
				currentQuestion++;
				generateQuestions();
			}
			if (correctAnswer != 0) {
				incorrectCount++;
				currentQuestion++;
				generateQuestions();
			}
		}
		
		private function answer1picked(event:MouseEvent) {
			if (correctAnswer == 1) {
				correctCount++;
				currentQuestion++;
				generateQuestions();
			}
			if (correctAnswer != 1) {
				incorrectCount++;
				currentQuestion++;
				generateQuestions();
			}
		}
		
		private function answer2picked(event:MouseEvent) {
			if (correctAnswer == 2) {
				correctCount++;
				currentQuestion++;
				generateQuestions();
			}
			if (correctAnswer != 2) {
				incorrectCount++;
				currentQuestion++;
				generateQuestions();
			}
		}
		
		private function answer3picked(event:MouseEvent) {
			if (correctAnswer == 3) {
				correctCount++;
				currentQuestion++;
				generateQuestions();
			}
			if (correctAnswer != 3) {
				incorrectCount++;
				currentQuestion++;
				generateQuestions();
			}
		}

	}

}