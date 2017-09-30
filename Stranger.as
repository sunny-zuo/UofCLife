﻿package  {
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Stranger extends MovieClip{
		
		private var randomDialog:Array = new Array(); //creates array that will store random dialog

		private var strangerName:String;
		private var dialog:Array = new Array();
		private var textBox:TextBox;
		
		//For below parameters:
		//stangerName is a string to name the stranger (optional, leave as blank if needed)
		//dialog is an array of things for him to say in the order given after prompted
		public function Stranger(dialog:Array, strangerName:String) {
			// constructor code
			this.dialog = dialog;
			this.strangerName = stangerName; //sets parameters to local variables
			
			init();
		}
		
		private function init():void {
			this.addEventListener(Event.ENTER_FRAME, this.sayRandomDialog); //Creates function to randomly say dialog
			this.addEventListener(MouseEvent.CLICK, sayDialog); //Event Listener for a tap on Stranger
			
			//Sets up his name info
			var nameBox:TextBox = new TextBox; //creates a textbox to store his name
			nameBox.x = this.x; //sets x to the x of the character
			nameBox.y = this.y - 40; //sets y to the y of the charater minus 40
			nameBox.text = strangerName; //sets the text of the box to his name
			addChild(nameBox); //adds the box
			
			//Sets the random dialog
			randomDialog = ["Hi", "Hey", "Hello", "Bonjour", "Hello there"]
		}
				
		private function sayRandomDialog(event:Event):void { //Function for random dialog)
			var distance = 10000; //sets how often he will say something, in terms of frames. random so if value = 1000 than it is expected that he will say it every 1000 frames
			var randomNum = Math.ceil(Math.random()*distance);
			if (randomNum == 1) {
				var textChoice = (Math.floor(Math.random() * (randomDialog.length - 1))) //selects a random number between 0 and array length minus 1
				textBox = new TextBox(randomDialog[textChoice], this); //Creates text box using the textChoice as a parameter and this)
				addChild(textBox);
			}
		}
		
		private function sayDialog (event:MouseEvent) {
			textBox = new TextBox(dialog, this); //creates textBox using provided dialog array as text
			addChild(textBox);
		}

	}
	
}
