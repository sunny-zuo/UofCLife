package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Stranger extends MovieClip{
		
		private var randomDialog:Array = new Array(); //creates array that will store random dialog
		private var strangerName:String;
		private var dialog:Array = new Array();
		private var textBox:TextBox;
		
		randomDialog[0] = ["Hi", "Hey", "Hello", "Bonjour", "Hello there"]
		
		//For below parameters:
		//stangerName is a string to name the stranger (optional, leave as blank if needed)
		//dialog is an array of things for him to say in the order given after prompted
		public function Stranger(strangerName:String, dialog:Array) {
			// constructor code
			this.strangerName = stangerName; //sets parameters to local variables
			this.dialog = dialog;
			init();
		}
		
		private function init():void {
			stage.addEventListener(Event.ENTER_FRAME, randomDialog); //Creates function to randomly say dialog
		}
		
		private function randomDialog(event:Event) {
			
		}

	}
	
}
