package {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.text.TextFormat;

	public class Stranger extends MovieClip {

		private var randomDialog: Array = new Array(); //creates array that will store random dialog

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
		public function Stranger(xPos:Number, yPos:Number, dialog: Array = null, strangerName: String = "", canTalk: Boolean = true, canTalkRand: Boolean = true, randomDistance: int = 1000, dialogTimer: Number = 4, dialogRandTimer: Number = 4, randomDialog: Array = null) {
			// constructor code
			
			if (dialog == null) { //if there is no dialog given
				canTalk = false; //then he can't talk
			}
			else { //if there is dialog given
				this.canTalk = canTalk; //his canTalk will be whatever is fed
				this.dialog = dialog; //and his dialog will be the dialog given
			}
			this.strangerName = strangerName; //sets parameters to local variables
			this.randomDistance = randomDistance;
			this.canTalkRand = canTalkRand;
			this.timer = new Timer(dialogTimer * 1000); //creates a timer based on value provided, multiplied by 1000 so seconds becomes the input
			this.timerRand = new Timer(dialogRandTimer * 1000); //creates a timer based on value provided
			
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
			var nameBoxFormat:TextFormat = new TextFormat(); //creates textformat to modify namebox
			
			nameBoxFormat.align = "center"; //centers the name so it stays centered regardless of name size
			nameBoxFormat.size = 20; //increases size of name
			
			nameBox.x = -50; //sets x to the x of the character
			nameBox.y = 15; //sets y to the y of the charater minus 40
			nameBox.text = strangerName; //sets the text of the box to his name
			
			nameBox.setTextFormat(nameBoxFormat); //sets the textformat to the textfield
			
			addChild(nameBox); //adds the box

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
				for (var i: int = 0; i < dialog.length; i++) { //creates a for loop that loops the length of the dialog array times
					dialogTemp.push(dialog[i]); //pushes the data from dialog to dialogTemp as dialogTemp will be modified but storing the text is still needed
				}
				timer.reset(); //resets the timer
				timer.start(); //starts the timer again
			}
			else {
				timer.reset(); //resets the timer
				timer.start(); //starts the timer again
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