package {
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class QuizPopup extends MovieClip {

		private var questionCount: int; //the number of total questions
		private var topic: String; //the topic the quiz will be on
		private var difficulty: String; //the difficulty the questions will have. easy, medium or hard
		private var qType: String; //type of question. leave empty as current setup doesn't support true/false questions
		
		private var currentQuestion:int = 0; //the question we are on right now (starts at 0)
		private var correctAnswer:int; //the answer number that is correct
		
		private var correctCount:int = 0; //how many questions were correct
		private var incorrectCount:int = 0; //how many questions were incorrect
		
		private var loadedData: Object; //data obtained from API

		private var questionBoxList: Array; //array that stores text boxes

		private var questionAPI: QuestionAPI = new QuestionAPI(); //links with QuestionAPI

		private var timer: Timer = new Timer(1000); //timer so that it waits a second before filling in question/answer text boxes

		public function QuizPopup(questionCount: int, subject: String, difficulty: String, qType: String = "multiple") {
			// constructor code
			this.questionCount = questionCount; //converts the parameters given into local variables
			this.topic = subject;
			this.difficulty = difficulty;
			this.qType = qType;
			init();
		}

		private function init() {
			questionAPI.fetchQuestions(questionCount, topic, difficulty, qType); //runs the fetchQuestions function which gets the questions
			questionBoxList = new Array(); //fills the array with answer text boxes
			questionBoxList[0] = answer0.answerText;
			questionBoxList[1] = answer1.answerText;
			questionBoxList[2] = answer2.answerText;
			questionBoxList[3] = answer3.answerText;

			timer.addEventListener(TimerEvent.TIMER, generateQuestions); //adds a event listener to trigger a function after a second is over
			timer.start(); //starts timer
			
			answer0.addEventListener(MouseEvent.CLICK, answer0picked) //event listener for a click on each answer box, and runs a specific function
			answer1.addEventListener(MouseEvent.CLICK, answer1picked)
			answer2.addEventListener(MouseEvent.CLICK, answer2picked)
			answer3.addEventListener(MouseEvent.CLICK, answer3picked)
		}
		private function generateQuestions(event: Event) {
			if (timer != null) { //if the timer is there, remove it
				timer.removeEventListener(TimerEvent.TIMER, generateQuestions);
				timer = null;
			}
			if (loadedData == null) { //if data is already saved locally, don't
				loadedData = questionAPI.loadedData; //else, save it locally
			}
			questionText.text = loadedData.results[currentQuestion].question; //sets the question textbox to the current question
			correctAnswer = Math.floor(Math.random() * 4); //picks a number between 0 and 3 to be the correct answer
			questionBoxList[correctAnswer].text = loadedData.results[currentQuestion].correct_answer; //fills the answer box that was picked with the answer
			
			var answerPlaced:int = 0; //next incorrect answer to fill
			for (var i:int = 0; i < 4; i++) {
				if (questionBoxList[i].text != loadedData.results[currentQuestion].correct_answer) { //if answer is not the correct answer, then fill it (box is empty/filled with old info)
					questionBoxList[i].text = loadedData.results[currentQuestion].incorrect_answers[answerPlaced]; //places the answer
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