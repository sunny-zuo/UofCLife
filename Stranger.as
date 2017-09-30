package {
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
		private var canTalkRand: Boolean = true;
		private var randomDistance: int;
		private var strHeight:Number; //static height of the stranger when created (also where text boxes should spawn)

		//For below parameters:
		//stangerName is a string to name the stranger (optional, leave as blank if needed)
		//dialog is an array of things for him to say in the order given after prompted
		//canTalk is a bool that states whether he can talk or not
		//randomDistance is a int that reflects how often he'll say random things
		//canTalkRand is a bool that states whether he will randomly talk or not
		public function Stranger(dialog: Array, strangerName: String, canTalk: Boolean, canTalkRand: Boolean, randomDistance: int) {
			// constructor code
			this.dialog = dialog;
			this.strangerName = strangerName; //sets parameters to local variables
			this.canTalk = canTalk;
			this.randomDistance = randomDistance;
			this.canTalkRand = canTalkRand;
			
			strHeight = height;
			
			init();
		}

		private function init(): void {
			if (canTalk) {
				this.addEventListener(MouseEvent.CLICK, clickTalk); //Event Listener for a tap on Stranger
			}
			if (canTalkRand) {
				this.addEventListener(Event.ENTER_FRAME, this.sayRandomDialog); //Creates function to randomly say dialog
			}
			trace(height);
			
			//Sets up his name info
			var nameBox: TextField = new TextField(); //creates a textbox to store his name
			nameBox.x = 0; //sets x to the x of the character
			nameBox.y = 35; //sets y to the y of the charater minus 40
			nameBox.text = strangerName; //sets the text of the box to his name
			addChild(nameBox); //adds the box
			
			trace(height);

			//Sets the random dialog
			randomDialog = ["Man, subway is so understaffed", "Carl's Jr is overpriced :/", "hello there"]
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
			dialogTemp = dialog; //sets array, dialogTemp to dialog array to preserve it as dialogTemp will be modified as he talks
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

			if (dialogTemp.length < 1) { //if no dialog exists, exit out of this function to prevent errors
				return; //exits out of this function
			}

			textBox = new TextBox(dialogTemp[0], this); //creates textBox using provided dialog array as text
			
			textBox.y = -strHeight - 10;
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