package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	public class TextBox extends MovieClip {
		//TextBox that displays text
		
		private var boxOutline:Sprite;
		//sprite object that represents the background outline of the box
		
		private var bufferStream:Array;
		//list of messages to be displayed in this text box
		
		private var textSource:Stranger;
		//person who is spearking the text in this textbox
		
		public function TextBox(bufferStream:Array, textSource:Stranger) {
			/*CONSTRUCTOR
			PARAMETERS:
			bufferStream = Array of Strings that this text box will display
			DO:
			Stores bufferStream into local variable bufferStream
			*/
			
			this.bufferStream = bufferStream;
			this.textSource = textSource;
			//store parameters as local variables
			
			open();
			
			
			
		}
		
		private function open():void{
			/*
			DO:
			Opens the textbox and displays the first text stream
			*/
			
			x = textSource.x;
			y = textSource.y;
			//set position of textbox to the stranger			
			trace(textSource.x, textSource.y);
			drawOutline();
			
		}
		
		public function close():void{
			/*
			*/
		}
		
		private function drawOutline():void{
			boxOutline = new Sprite();
			boxOutline.graphics.lineStyle(3);
			//set line to thickness of 3
			boxOutline.graphics.drawRect(0, 0, 150, 100);
			//draw a box outline of 150 pixels wide, 100 pixels tall
			addChild(boxOutline);
		}
	}
	
}
