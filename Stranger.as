﻿package {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.Timer;

	public class Stranger extends MovieClip {

		private var randomDialog: Array = new Array(); //creates array that will store random dialog

		private var strangerName: String = "";
		private var dialog: Array = new Array();
		private var dialogTemp: Array = new Array();
		private var textBox: TextBox;
		private var timer = new Timer(4000);
		private var timerRand = new Timer(4000);
		private var canTalk: Boolean = true;

		//For below parameters:
		//stangerName is a string to name the stranger (optional, leave as blank if needed)
		//dialog is an array of things for him to say in the order given after prompted
		public function Stranger(dialog: Array, strangerName: String, canTalk: Boolean) {
			// constructor code
			this.dialog = dialog;
			this.strangerName = strangerName; //sets parameters to local variables
			this.canTalk = canTalk;

			init();
		}

		private function init(): void {
			if (canTalk) {
				this.addEventListener(Event.ENTER_FRAME, this.sayRandomDialog); //Creates function to randomly say dialog
				this.addEventListener(MouseEvent.CLICK, clickTalk); //Event Listener for a tap on Stranger
			}
			//Sets up his name info
			var nameBox: TextField = new TextField(); //creates a textbox to store his name
			nameBox.x = this.x + 20; //sets x to the x of the character
			nameBox.y = this.y - 40; //sets y to the y of the charater minus 40
			nameBox.text = strangerName; //sets the text of the box to his name
			addChild(nameBox); //adds the box

			//Sets the random dialog
			randomDialog = ["Man, subway is so understaffed", "Carl's Jr is overpriced :/", "hello there"]
		}

		private function sayRandomDialog(event: Event): void { //Function for random dialog)
			var distance = 1000; //sets how often he will say something, in terms of frames. random so if value = 1000 than it is expected that he will say it every 1000 frames
			var randomNum = Math.ceil(Math.random() * distance);
			if (randomNum == 1 && !textBox) {

				var textChoice = (Math.floor(Math.random() * (randomDialog.length - 1))) //selects a random number between 0 and array length minus 1
				textBox = new TextBox(randomDialog[textChoice], this); //Creates text box using the textChoice as a parameter and this)

				textBox.x = x;
				textBox.y = -height / 2 - 10;
				//set textbox position so it appears above the person's head

				addChild(textBox);

				timerRand.addEventListener(TimerEvent.TIMER, closeTextbox);
				timerRand.start();
			}
		}

		private function closeTextbox(event: TimerEvent) {
			timerRand.removeEventListener(TimerEvent.TIMER, closeTextbox);
			timerRand = null;

			if (textBox) {
				textBox.close();
				textBox = null;
			}
		}

		private function clickTalk(event: MouseEvent) { //function to trigger sayDialog after the character is clicked
			dialogTemp = dialog;
			sayDialog();
		}

		private function continueSpeech(event: TimerEvent) { //function to trigger sayDialog after a timer is run
			timer.removeEventListener(TimerEvent.TIMER, continueSpeech); //eventlistener that detects when the timer is over
			sayDialog();
		}

		private function sayDialog(): void { //function to have him say his lines that were given

			if (textBox) { //if textbox exists, remove it using close function of textBox
				textBox.close();
				textBox = null;
			}

			if (dialogTemp.length < 1) {
				return;
			}

			textBox = new TextBox(dialogTemp[0], this); //creates textBox using provided dialog array as text

			trace(dialogTemp[0]);

			textBox.x = x;
			textBox.y = -height / 2 - 10;
			//set textbox position so it appears above the person's head

			addChild(textBox); //adds to stage

			dialogTemp.splice(0, 1); //removes the first value of the array since it has been said

			if (dialogTemp.length >= 0) { //checks to see if more text is left in array
				timer.addEventListener(TimerEvent.TIMER, continueSpeech); //eventlistener that detects when the timer is over
				timer.start(); //starts timer
			}

		}

	}

}