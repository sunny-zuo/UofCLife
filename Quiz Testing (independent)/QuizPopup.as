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

		private var currentQuestion: int = 0; //the question we are on right now (starts at 0)
		private var correctAnswer: int; //the answer number that is correct

		private var correctCount: int = 0; //how many questions were correct
		private var incorrectCount: int = 0; //how many questions were incorrect

		private var loadedData: Object; //data obtained from API

		private var questionBoxList: Array; //array that stores text boxes

		private var questionAPI: QuestionAPI = new QuestionAPI(); //links with QuestionAPI
		private var correctSymbol: CorrectSymbol = new CorrectSymbol();
		private var incorrectSymbol: IncorrectSymbol = new IncorrectSymbol();

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

			answer0.addEventListener(MouseEvent.CLICK, answer0picked); //event listener for a click on each answer box, and runs a specific function
			answer1.addEventListener(MouseEvent.CLICK, answer1picked);
			answer2.addEventListener(MouseEvent.CLICK, answer2picked);
			answer3.addEventListener(MouseEvent.CLICK, answer3picked);

			addEventListener(Event.ENTER_FRAME, waitForLoad);
		}

		private function waitForLoad(event: Event): void {
			if (questionAPI.loadDone) {
				loadedData = questionAPI.loadedData;
				generateQuestions();
				removeEventListener(Event.ENTER_FRAME, waitForLoad);
			}
		}

		private function generateQuestions() {
			questionText.text = loadedData.results[currentQuestion].question; //sets the question textbox to the current question
			questionText.text = questionText.text.replace(/&#039;/g, "\'")
			questionText.text = questionText.text.replace(/&#034;/g, "\"")
			questionText.text = questionText.text.replace(/&quot;/g, "\"")
			questionText.text = questionText.text.replace(/&uuml;/g, "ü")
			questionText.text = questionText.text.replace(/&ouml;/g, "ö")

			correctAnswer = Math.floor(Math.random() * 4); //picks a number between 0 and 3 to be the correct answer

			questionBoxList[correctAnswer].text = loadedData.results[currentQuestion].correct_answer; //fills the answer box that was picked with the answer
			questionBoxList[correctAnswer].text = questionBoxList[correctAnswer].text.replace(/&#039;/g, "\'")
			questionBoxList[correctAnswer].text = questionBoxList[correctAnswer].text.replace(/&#034;/g, "\"")
			questionBoxList[correctAnswer].text = questionBoxList[correctAnswer].text.replace(/&quot;/g, "\"")
			questionBoxList[correctAnswer].text = questionBoxList[correctAnswer].text.replace(/&uuml;/g, "ü")
			questionBoxList[correctAnswer].text = questionBoxList[correctAnswer].text.replace(/&ouml;/g, "ö")

			var answerPlaced: int = 0; //next incorrect answer to fill
			for (var i: int = 0; i < 4; i++) {
				if (questionBoxList[i].text != loadedData.results[currentQuestion].correct_answer) { //if answer is not the correct answer, then fill it (box is empty/filled with old info)
					questionBoxList[i].text = loadedData.results[currentQuestion].incorrect_answers[answerPlaced]; //places the answer

					questionBoxList[i].text = questionBoxList[i].text.replace(/&#039;/g, "\'")
					questionBoxList[i].text = questionBoxList[i].text.replace(/&#034;/g, "\"")
					questionBoxList[i].text = questionBoxList[i].text.replace(/&quot;/g, "\"")
					questionBoxList[i].text = questionBoxList[i].text.replace(/&uuml;/g, "ü")
					questionBoxList[i].text = questionBoxList[i].text.replace(/&ouml;/g, "ö")

					answerPlaced++
				}
			}
		}

		private function answerCorrect() {
			correctCount++;
			addChild(correctSymbol);
			currentQuestion++;
			generateQuestions();
		}

		private function answerIncorrect() {
			incorrectCount++;
			incorrectSymbol.correctAnswerText.text = "The correct answer is " + questionBoxList[correctAnswer].text + ".";
			addChild(incorrectSymbol);
			currentQuestion++;
			generateQuestions();
		}
		private function answer0picked(event: MouseEvent) {
			if (correctAnswer == 0) {
				answerCorrect();
			} else if (correctAnswer != 0) {
				answerIncorrect();
			}
		}

		private function answer1picked(event: MouseEvent) {
			if (correctAnswer == 1) {
				answerCorrect();
			} else if (correctAnswer != 1) {
				answerIncorrect();
			}
		}

		private function answer2picked(event: MouseEvent) {
			if (correctAnswer == 2) {
				answerCorrect();
			} else if (correctAnswer != 2) {
				answerIncorrect();
			}
		}

		private function answer3picked(event: MouseEvent) {
			if (correctAnswer == 3) {
				answerCorrect();
			} else if (correctAnswer != 3) {
				answerIncorrect();
			}
		}

	}

}