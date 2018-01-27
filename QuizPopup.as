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
		private var quizEnding:QuizEnding;
		private var passingPercentage:Number; //percentage, 0-100 that indicates what percentage the player needs to get to pass
		private var thinkTime:int; //time the player is given to "think" for each quesiton
		private var tempThinkTime:int; //temp version of thinkTime that is used to be modified, while keeping the original intact
		
		private var questionTimer:Timer; //timer
		
		private var pass:Function; // function that is run should the player pass
		private var passParams:Array; // params that are used for the function should the player pass
		private var fail:Function; // function is the run should the player fail
		private var failParams:Array; // params that are used for the function should the player pass

		public function QuizPopup(questionCount: int, subject: String, difficulty: String, thinkTime:int = 15, qType: String = "multiple", passingPercentage:Number = 80, pass:Function = null, passParams:Array = null, fail:Function = null, failParams:Array = null) {
			// constructor code
			this.questionCount = questionCount; //converts the parameters given into local variables
			this.topic = subject;
			this.difficulty = difficulty;
			this.qType = qType;
			this.passingPercentage = passingPercentage;
			this.thinkTime = thinkTime;
			this.pass = pass;
			this.passParams = passParams;
			this.fail = fail;
			this.failParams = failParams;
			this.tempThinkTime = thinkTime;
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
			if (questionAPI.loadDone) { //waits for the data to be grabbed
				loadedData = questionAPI.loadedData; //grabs loaded data from questionAPI
				generateQuestions(); //generates the first question
				removeEventListener(Event.ENTER_FRAME, waitForLoad); //removes the event listener as this function is no longer needed
			}
		}

		private function generateQuestions() {
			questionText.text = removeASCII(loadedData.results[currentQuestion].question); //sets the question textbox to the current question

			correctAnswer = Math.floor(Math.random() * 4); //picks a number between 0 and 3 to be the correct answer

			questionBoxList[correctAnswer].text = removeASCII(loadedData.results[currentQuestion].correct_answer); //fills the answer box that was picked with the answer

			var answerPlaced: int = 0; //next incorrect answer to fill
			for (var i: int = 0; i < 4; i++) {
				if (questionBoxList[i].text != loadedData.results[currentQuestion].correct_answer) { //if answer is not the correct answer, then fill it (box is empty/filled with old info)
					questionBoxList[i].text = removeASCII(loadedData.results[currentQuestion].incorrect_answers[answerPlaced]); //places the answer
					answerPlaced++ 
				}
			}
			
			questionTimer = new Timer(1000, tempThinkTime); // creates a timer of 1 second for tempThinkTime iterations
			
			this.timerBacking.timeLeft.text = tempThinkTime; //sets the timer text to the count of tempThinkTime
			
			questionTimer.addEventListener(TimerEvent.TIMER, timerChange);
			questionTimer.start(); //starts the timer
		}
		
		private function timerChange(event:TimerEvent) {
			//after 1 second:
			tempThinkTime -= 1; //reduce the time left by 1
			timerBacking.timeLeft.text = tempThinkTime; //update the time left that is displayed
			if (tempThinkTime <= 0) { //if there is no more time, the answer is incorrect
				answerIncorrect();
			}
		}
		
		private function removeASCII(input:String) {
			//Function to remove the ASCII that makes the question/answer hard to read. Add more when needed.
			input = input.replace(/&#039;/g, "\'");
			input = input.replace(/&#034;/g, "\"");
			input = input.replace(/&quot;/g, "\"");
			input = input.replace(/&uuml;/g, "ü");
			input = input.replace(/&eacute;/g, "é");
			input = input.replace(/&aacute;/g, "á");
			input = input.replace(/&ouml;/g, "ö");
			input = input.replace(/&Uuml;/g, "Ü");
			input = input.replace(/&rsquo;/g, "'");
			input = input.replace(/&sup2;/g, "²");
			input = input.replace(/&amp;/g, "&");
			return(input);
		}

		private function answerCorrect() {
			correctCount++;
			addChild(correctSymbol);
			currentQuestion++;
			
			if (questionTimer) { //if the timer exists, destroy it
				questionTimer.stop();
				questionTimer = null;
			}
			
			if (currentQuestion >= questionCount) {
				createResultPage(1000); //creates the result page with a delay so the result of the final answer can be displayed
			}
			else {
				tempThinkTime = thinkTime + 1; //sets the tempThinkTime to one more than the given thinkTime. This is because the timer runs while the screen that shows if the answer is correct/incorrect is up
				generateQuestions();
			}
		}

		private function answerIncorrect() {
			incorrectCount++;
			incorrectSymbol.correctAnswerText.text = "The correct answer is " + questionBoxList[correctAnswer].text + ".";
			addChild(incorrectSymbol);
			currentQuestion++;

			if (questionTimer) {
				questionTimer.stop();
				questionTimer = null;
			}
			
			if (currentQuestion >= questionCount) {
				createResultPage(2000);
			}
			else {
				tempThinkTime = thinkTime + 2;
				generateQuestions();
			}
		}
		
		private function createResultPage(mills:int) {
			var timer:Timer = new Timer(mills, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, showResultPage);
		}
		
		private function showResultPage(e:TimerEvent) {
			quizEnding = new QuizEnding(correctCount, incorrectCount, passingPercentage);
			addChild(quizEnding);
			addEventListener(Event.ENTER_FRAME, waitToClose);
		}
		
		private function waitToClose(event:Event) {
			if (quizEnding != null) {
				if (quizEnding.readyToClose) {
					this.parent.removeChild(this);
					removeEventListener(Event.ENTER_FRAME, waitToClose);
				}
			}
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