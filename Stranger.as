﻿package {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.text.TextFormat;
	import flash.net.SharedObject;

	//import com.adobe.tvsdk.mediacore.events.TimeChangeEvent;

	public class Stranger extends MovieClip {

		private var randomDialog: Array = new Array(); //creates array that will store random dialog

		private var xDelta: DeltaAssist;

		private var strangerName: String = "";
		private var dialog: Array = new Array();
		private var dialogTemp: Array = new Array();
		private var textBox: TextBox;
		private var timer;
		private var timerRand;
		private var canTalk: Boolean = true;
		private var canTalkRand: Boolean = true;
		private var randomDistance: int;
		private var strHeight: Number; //static height of the stranger when created (also where text boxes should spawn)
		public var xPos: Number; //where it's x will be
		public var yPos: Number; //where it's y will be
		private var wanderDist: Number = 100;
		private var ID: int; //this is the ID the stranger uses to identify itself(must be unique!)

		public var movementDirections: Array = []; //an array to hold movement commands when doing scripted movements(see moevent documentation)

		private var intHolder: int;

		//movement variables
		private var movementDirection: String = ""
		var wanderTimer: Timer = new Timer(500);

		private var talkingToCharacter: Boolean = false


		private const TALK_DISTANCE: Number = 250;
		//how far you can be to talk to a character

		private var talkSymbol: MovieClip;
		//talk symbol (exclamation mark)
		private var talkAssist: DeltaAssist;
		//delta assist for the talk symbol fading in and out

		private var symbolExist: Boolean;
		//whether the talk symbol is currently being shown

		//For below parameters:
		//stangerName is a string to name the stranger (optional, leave as blank if needed)
		//dialog is an array of things for him to say in the order given after prompted
		//canTalk is a bool that states whether he can talk or not
		//randomDistance is a int that reflects how often he'll say random things
		//canTalkRand is a bool that states whether he will randomly talk or not
		//dialogTimer is the time in seconds between each piece of dialog, default is 4 seconds
		//dialogRandTimer is the time in seconds that will happen before the random dialog disappears, default is 4 seconds
		//dialogRand is the random dialog that he will say

		//Only required parameter is the dialog of the person
		public function Stranger(ID: int, xPos: Number, yPos: Number, dialog: Array = null, strangerName: String = "", canTalk: Boolean = true, canTalkRand: Boolean = false, randomDistance: int = 1000, dialogTimer: Number = 4, dialogRandTimer: Number = 4, randomDialog: Array = null, wanderDistance: Number = -1) {
			// constructor code

			if (dialog == null) { //if there is no dialog given
				canTalk = false; //then he can't talk
			} else { //if there is dialog given
				this.canTalk = canTalk; //his canTalk will be whatever is fed
				this.dialog = dialog; //and his dialog will be the dialog given
			}
			this.strangerName = strangerName; //sets parameters to local variables
			this.randomDistance = randomDistance;
			this.canTalkRand = canTalkRand;
			this.ID = ID
			this.timer = new Timer(dialogTimer * 1000); //creates a timer based on value provided, multiplied by 1000 so seconds becomes the input
			this.timerRand = new Timer(dialogRandTimer * 1000); //creates a timer based on value provided


			this.xPos = xPos;
			this.yPos = yPos;
			this.wanderDist = wanderDistance

			if (randomDialog == null) { //if the array is null. array is set to null by default as you cannot declare an array as a default
				this.randomDialog = ["Man, subway is so understaffed", "Carl's Jr is overpriced :/", "hello there"] //default random text
			} else { //else, if there is a value
				this.randomDialog = randomDialog; //sets random dialog array to equal the array given here
			}
			strHeight = height; //sets his height to a static value

			init();
		}

		private function init(): void {
			if (canTalk) { //if he can talk, add the event listener
				this.addEventListener(MouseEvent.CLICK, clickTalk); //Event Listener for a tap on Stranger
			}
			if (canTalkRand) { //if he can talk randomly, add the event listener
				this.addEventListener(Event.ENTER_FRAME, this.sayRandomDialog); //Creates function to randomly say dialog
			}

			//Sets up his name info
			var nameBox: TextField = new TextField(); //creates a textbox to store his name
			var nameBoxFormat: TextFormat = new TextFormat(); //creates textformat to modify namebox

			nameBoxFormat.align = "center"; //centers the name so it stays centered regardless of name size
			nameBoxFormat.size = 20; //increases size of namesay

			nameBox.x = -50; //sets x to the x of the character
			nameBox.y = 15; //sets y to the y of the charater minus 40
			nameBox.text = strangerName; //sets the text of the box to his name

			nameBox.setTextFormat(nameBoxFormat); //sets the textformat to the textfield

			addChild(nameBox); //adds the box

			//TALK SYMBOL (appears above head when you can talk to him when you are close enough)
			talkSymbol = new TalkSymbol();
			talkSymbol.y = -225;
			talkSymbol.alpha = 0;
			addChild(talkSymbol);

			talkAssist = new DeltaAssist(talkSymbol, ["alpha"]);
			xDelta = new DeltaAssist(this, ["x"]);

			addEventListener(Event.ENTER_FRAME, talkSymbolFrame);
			addEventListener(Event.ENTER_FRAME, move)
			wanderTimer.addEventListener(TimerEvent.TIMER, wander);
			wanderTimer.start()

		}

		private function wander(event: TimerEvent): void {
			if (wanderDist <= 0) {
				wanderTimer.stop();
				removeEventListener(TimerEvent.TIMER, wander);
			}
			if (movementDirection == "") {
				if (Math.ceil(Math.random() * 5) == 5) {
					if (Math.round(Math.random()) == 1) { //move directions
						if (this.x > xPos - wanderDist) {
							movementDirection = "LEFT"
						} else {
							//movementDirection == "RIGHT"
						}
					} else {
						if (this.x < xPos + wanderDist) {
							movementDirection = "RIGHT"
						} else {
							//movementDirection = "LEFT"
						}
					}
				}
			} else {
				if (Math.ceil(Math.random() * 3) == 3) {
					movementDirection = ""
				}
			}


		}

		private function move(event: Event): void {

			if (!talkingToCharacter) {
				if (movementDirection == "LEFT" && x - (width / 2) > 0) {
					this.x -= 5
				} else if (movementDirection == "RIGHT" && x + (width / 2) < Main.instance.currentRoom.roomWidth) {
					this.x += 5
				}
			}
		}

		private function talkSymbolFrame(event: Event): void {
			if (Math.abs(x - Main.instance.character.x) < TALK_DISTANCE) {
				var talking: Boolean = Boolean(textBox);
				if (!talking && !symbolExist) {
					//if not talking and symbol does not exist

					talkAssist.setLinear(0.2, 1);
					//turn on symbol
					symbolExist = true;
					//mark as existent
				} else if (talking && symbolExist) {
					//if talking and symbol exists
					talkAssist.setLinear(-0.2, 0);
					//turn off symbol
					symbolExist = false;
					//mark it as nonexistent
				}
			} else { //if too far away
				if (symbolExist) {
					talkAssist.setLinear(-0.2, 0);
					//turn off symbol
					symbolExist = false;
					//mark it as nonexistent
				}
			}
		}

		private function sayRandomDialog(event: Event): void { //Function for random dialog)
			var randomNum = Math.ceil(Math.random() * randomDistance); //generates a random number from 1 to 1000
			if (randomNum == 1 && !textBox) { //if the random number is 1 and there isn't already a textbox, create a new one

				var textChoice = (Math.floor(Math.random() * (randomDialog.length))) //selects a random number between 0 and array length minus 1
				textBox = new TextBox(randomDialog[textChoice], this); //Creates text box using the textChoice as a parameter and this)

				textBox.y = -strHeight - 10;
				//set textbox position so it appears above the person's head

				addChild(textBox);

				timerRand.addEventListener(TimerEvent.TIMER, closeTextbox); //closes textbox after set amount of time set by the timer
				timerRand.start(); //starts the timer
			}
		}

		private function closeTextbox(event: TimerEvent) {
			timerRand.removeEventListener(TimerEvent.TIMER, closeTextbox); //removes eventlistener for cleanup

			if (textBox) { //removes the textbox after the timer passes
				textBox.close();
				textBox = null;
			}
		}

		private function clickTalk(event: MouseEvent) { //function to trigger sayDialog after the character is clicked
			if (dialogTemp.length == 0) { //if there is nothing left in dialogTemp
				talkingToCharacter = true
				for (var i: int = 0; i < dialog.length; i++) { //creates a for loop that loops the length of the dialog array times
					dialogTemp.push(dialog[i]); //pushes the data from dialog to dialogTemp as dialogTemp will be modified but storing the text is still needed
				}
			}

			sayDialog(); //runs function to have him talk
		}

		private function continueSpeech(event: TimerEvent) { //function to trigger sayDialog after a timer is run
			timer.removeEventListener(TimerEvent.TIMER, continueSpeech); //eventlistener that detects when the timer is over
			sayDialog(); //runs function to have him talk
		}

		private function sayDialog(): void { //function to have him say his lines that were given
			if (textBox) { //if textbox exists, remove it using close function of textBox
				textBox.close();
				textBox = null;
			}

			if (Math.abs(x - Main.instance.character.x) > TALK_DISTANCE) {
				dialogTemp = [];
				//stop talking
			}

			if (dialogTemp.length < 1) { //if no dialog exists, exit out of this function to prevent errors
				talkingToCharacter = false
				return; //exits out of this function
			}

			timer.reset(); //resets the timer

			if (dialogTemp[0] is String) {
				//if the next object in line is a String, then talk

				textBox = new TextBox(dialogTemp[0], this); //creates textBox using provided dialog array as text

				textBox.y = -strHeight - 10;
				//set textbox position so it appears above the person's head

				addChild(textBox); //adds to stage

				dialogTemp.splice(0, 1); //removes the first value of the array since it has been said

				continueDialog();
			} else if (dialogTemp[0] is Array) { //function array
				var functionArray: Array = dialogTemp[0];
				//takes the entire function array

				var callFunction: Function;
				if (functionArray[0] is String && functionArray[0].substring(0, 4) == "fcn_") {
					//if it is in String form because the function is private
					callFunction = this[functionArray[0].substring(4)];
					//"this" type casts the String into a function call
				} else {
					//no need for conversion
					callFunction = functionArray[0];
				}

				for (var i: int = 1; i < functionArray.length; i++) {
					if (functionArray[i] is String && functionArray[i].substring(0, 4) == "fcn_") {
						functionArray[i] = this[functionArray[i].substring(4)];
						//convert all Strings (that start with fcn) inside the array to functions
					}
				}
				callFunction.apply(this, functionArray.slice(1));
				//call the function using the rest of the functionArray (after slicing)
				dialogTemp.splice(0, 1); //removes the first value of the array since it has been executed
			}

		}

		private function continueDialog(): void { //public so that I can put it in function handle as parameter
			/*
			DO:
			Allows the character to continue saying things.
			*/
			if (dialogTemp.length >= 0) { //checks to see if more text is left in array
				timer.addEventListener(TimerEvent.TIMER, continueSpeech); //eventlistener that detects when the timer is over
				timer.start(); //starts timer
			}
		}

		private function skipToSayDialog(index: int): void { //public so that I can put it in function handle as parameter
			/*
			PARAMETERS:
			index = index where the character starts talking at again
			DO:
			Changes dialogTemp to continue from index onwards.
			*/
			if (index >= 0 && index < dialog.length) {
				//index exists
				dialogTemp = dialog.slice(index);
				//jump to index

			} else {
				dialogTemp = [];
				//stop speech
			}

			sayDialog(); //runs function to have him talk	
		}

		private function jumpToTempDialog(skipCount: int): void {
			dialogTemp.splice(0, skipCount);

			sayDialog();
		}

		private function generateQuiz(questionCount: int, topic: String, difficulty: String, thinkTime: int = 15, qType: String = "multiple", passingGrade: Number = 80, achievementToGrant: Array = null, pass: Function = null, passParams: Array = null, fail: Function = null, failParams: Array = null, applyTarget: Object = null) {
			MenuController.generateQuizPopUp(questionCount, topic, difficulty, thinkTime, qType, passingGrade, achievementToGrant, pass, passParams, fail, failParams, applyTarget);
		}

		private function addQuizDialog(): void {

			var achievementData: SharedObject = SharedObject.getLocal(Main.sharedObjectName); //shared object name is a static in Main
			if (achievementData.data.edc[0][0] == "Quiz Novice" && achievementData.data.edc[0][3] == false) { //if first quiz achievement isn't completed
				dialogTemp.push("Geography is for nerds like me!");
				dialogTemp.push("I dare thee to a geography dual!");
				dialogTemp.push([MenuController.generateDecisionBox, "fcn_generateQuiz", [10, "Geography", "easy", 10, "multiple", 70, ["edc", "Quiz Novice"]], "fcn_jumpToTempDialog", [1], this]);
				dialogTemp.push(["fcn_clearDialog"]);
				dialogTemp.push("Fight me scrub");
			} else if (achievementData.data.edc[1][0] == "Quiz Pro" && achievementData.data.edc[1][3] == false) {
				dialogTemp.push("Back for more, I see");
				dialogTemp.push("You were just lucky the first time");
				dialogTemp.push([MenuController.generateDecisionBox, "fcn_generateQuiz", [10, "Geography", "medium", 8, "multiple", 80, ["edc", "Quiz Pro"]], "fcn_jumpToTempDialog", [1], this]);
				dialogTemp.push(["fcn_clearDialog"]);
				dialogTemp.push("Chicken!");
			} else if (achievementData.data.edc[2][0] == "Quiz Expert" && achievementData.data.edc[2][3] == false) {
				dialogTemp.push("I'll beat you this time!");
				dialogTemp.push("srsly I'm good at this stuff");
				dialogTemp.push([MenuController.generateDecisionBox, "fcn_generateQuiz", [10, "Geography", "hard", 8, "multiple", 90, ["edc", "Quiz Expert"]], "fcn_jumpToTempDialog", [1], this]);
				dialogTemp.push(["fcn_clearDialog"]);
				dialogTemp.push("Haha too scared?");
			} else if (achievementData.data.edc[3][0] == "Quiz Master" && achievementData.data.edc[3][3] == false) {
				dialogTemp.push("YOU HAVE UNLOCKED MY FINAL FORM");
				dialogTemp.push("PREPARE TO DIE!");
				dialogTemp.push("5 Questions. 5 Seconds each.");
				dialogTemp.push([MenuController.generateDecisionBox, "fcn_generateQuiz", [5, "Geography", "hard", 5, "multiple", 100, ["edc", "Quiz Master"]], "fcn_jumpToTempDialog", [1], this]);
				dialogTemp.push(["fcn_clearDialog"]);
				dialogTemp.push("GET REKT");
			}
		}

		private function clearDialog(): void {
			dialogTemp = [];
		}

		public function startScriptedWalk(): void {
			intHolder = 0;
			wanderTimer.stop();
			addEventListener(Event.ENTER_FRAME, scriptedWalk);

		}

		private function scriptedWalk(event: Event): void {
			if (intHolder >= movementDirections.length) {
				trace("remove listener");
				removeEventListener(Event.ENTER_FRAME, scriptedWalk);
				return;
			}
			var walkSpeed: int = 5;
			/*
			DO:
			allow the stranger to follow the scripted commands given
			*/

			//if the current command is move
			if (movementDirections[intHolder][0] == "WALKTO") {
				if (movementDirections[intHolder][1] > x && (Math.abs(movementDirections[intHolder][1] - x) >= Math.abs(walkSpeed * 2))) {

					movementDirection = "RIGHT";

				} else if (movementDirections[intHolder][1] < x && (Math.abs(movementDirections[intHolder][1] - x) >= Math.abs(walkSpeed * 2))) {
					movementDirection = "LEFT";

				} else {

					movementDirection = "";
					xPos = movementDirections[intHolder][1];
					intHolder++;
				}

			} else if (movementDirections[intHolder][0] == "PAUSE") {
				removeEventListener(Event.ENTER_FRAME, scriptedWalk);
				var waitingTimer: Timer = new Timer(movementDirections[intHolder][1]);
				waitingTimer.addEventListener(TimerEvent.TIMER, waitTimer);
				waitingTimer.start();

			} else if (movementDirections[intHolder][0] == "GOTOROOM") {
				xPos = movementDirections[intHolder][2];
				x = movementDirections[intHolder][2];
				Main.instance.roomList[movementDirections[intHolder][1]].addStrangerToRoom(this);
				intHolder++;
			} else if (movementDirections[intHolder][0] == "END") {
				if (movementDirections[intHolder][1] == true) {
					wanderTimer.start();
				}
				intHolder++;
			}


		}

		private function waitTimer(event: TimerEvent): void {
			intHolder++;
			removeEventListener(TimerEvent.TIMER, waitTimer);
			addEventListener(Event.ENTER_FRAME, scriptedWalk);
		}
	}



}