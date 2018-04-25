package {
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.utils.*;
	public class Cat extends MovieClip {


		private var movementDirection: String = "LEFT";
		private var movementMode = "WANDER";
		private var tamed: Boolean = false;

		private var wanderTimer: Timer = new Timer(500);

		private var talkSymbol: MovieClip;
		private var symbolExist: Boolean;
		private var talkAssist: DeltaAssist;
		private var xDelta: DeltaAssist;	
		private var textBox: TextBox;

		private var TALK_DISTANCE:int = 100;
		private var dialog: Array = ["MEOW"];
		private var dialogTemp: Array = new Array();
		private var talkingToCharacter:Boolean = false;
		private var strHeight:int = 50
		private var timer;
		private var dialogTimer:Number = 4;
		
		public function Cat() {
			// constructor code

			start();

		}

		private function start(): void {

			//TALK SYMBOL (appears above head when you can talk to him when you are close enough)
			talkSymbol = new TalkSymbol();
			talkSymbol.y = -225;
			talkSymbol.alpha = 0;
			addChild(talkSymbol);

			talkAssist = new DeltaAssist(talkSymbol, ["alpha"]);
			xDelta = new DeltaAssist(this, ["x"]);
			
			this.timer = new Timer(dialogTimer * 1000); //creates a timer based on value provided, multiplied by 1000 so seconds becomes the input

			this.addEventListener(MouseEvent.CLICK, clickTalk);

			addEventListener(Event.ENTER_FRAME, enterFrame);
			addEventListener(Event.ENTER_FRAME, move);
			wanderTimer.addEventListener(TimerEvent.TIMER, wander);
			addEventListener(Event.ENTER_FRAME, talkSymbolFrame);
		}

		private function enterFrame(event: Event): void {
			/*
			DO:
			updates where the cat moves based on conditions
			*/
			if (movementMode == "FOLLOW") {
				if (this.x <= Main.instance.character.x - 75) {

					movementDirection = "RIGHT";

				} else if (this.x >= Main.instance.character.x + 75) {

					movementDirection = "LEFT";

				} else {

					movementDirection = "IDLE";

				}
			} else if (movementMode == "WANDER") {
				if (wanderTimer.running == false) {
					wanderTimer.start();
				}
			} else {
				if (wanderTimer.running == true) {
					wanderTimer.stop();
				}
			}
		}

		private function wander(event: TimerEvent): void {
			if (movementDirection == "IDLE") {
				if (Math.ceil(Math.random() * 5) == 5) {
					if (Math.round(Math.random()) == 1) { //move directions
						movementDirection = "LEFT"
					} else {
						movementDirection = "RIGHT"
					}
				}
			} else {
				if (Math.ceil(Math.random() * 3) == 3) {
					movementDirection = "IDLE"
				}
			}
		}

		private function move(event: Event): void {
			/*
			DO:
				Handles moveing tha cat based on current movement direction and handles the animation playing
			*/
			if (movementDirection == "LEFT" && x - (width / 2) > 0) {
				this.x -= 5
				if (currentLabel != "walkLeft") {
					gotoAndPlay("walkLeft");
				}
			} else if (movementDirection == "RIGHT" && x + (width / 2) < Main.instance.currentRoom.roomWidth) {
				this.x += 5
				if (currentLabel != "walkRight") {
					gotoAndPlay("walkRight");
				}
			} else if (movementDirection == "IDLE") {
				if (this.x >= Main.instance.character.x + 50) {
					gotoAndStop("idleLeft");
				} else {
					gotoAndStop("idleRight");
				}
			} else {
				trace("unknowen movement direction" + movementDirection);
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
		
		private function clickTalk(event: MouseEvent) { //function to trigger sayDialog after the character is clicked
			if (dialogTemp.length == 0) { //if there is nothing left in dialogTemp
				talkingToCharacter = true
				for (var i: int = 0; i < dialog.length; i++) { //creates a for loop that loops the length of the dialog array times
					dialogTemp.push(dialog[i]); //pushes the data from dialog to dialogTemp as dialogTemp will be modified but storing the text is still needed
				}
			}

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
				trace(this);
				//textBox = new TextBox(dialogTemp[0], this); //creates textBox using provided dialog array as text

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
		
		private function continueSpeech(event: TimerEvent) { //function to trigger sayDialog after a timer is run
			timer.removeEventListener(TimerEvent.TIMER, continueSpeech); //eventlistener that detects when the timer is over
			sayDialog(); //runs function to have him talk
		}		
		//make the cat be in the same room
		//if(
	}
	/*
			private function searchForID(search:int, searcher:int):int {//searches through each room and each stranger to determine what room it is in
			//Every room
			for(var i:int = 0; i < Main.instance.roomList.length; i++)
			{
				var rt:int = -1;
				//Every stranger in room
				for(var j:int = 0; j < Main.instance.roomList[i].strangerArray.length; j++)
				{
					
					if(Main.instance.roomList[i].strangerArray[j].ID == this.ID)//fix
					{
						if(search == 1)//returns the room pos
						{
							rt = i
						} else if(search == 2) {//returns the stranger pos
							rt = j
						} 
						break;
					}
				}
				
			}
			return(rt);
		}
		*/
	/*

*/


}