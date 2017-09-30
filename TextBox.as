package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import Controllers.TextController;

	public class TextBox extends MovieClip {
		//TextBox that displays text
		
		private const BOXSIZE:Point = new Point(200, 100);
		//data structure that defines the size of the text box (constant)
		
		private var spr_box:Sprite;
		//Sprite object that represents the background outline of the box
		
		private var txt_display:TextField;
		//TextField object that represents the text field that displays the text
		
		private var displayString:String;
		//message to be displayed in this text box
		
		private var textSource:Stranger;
		//person who is spearking the text in this textbox
		
		public function TextBox(displayString:String, textSource:Stranger) {
			/*CONSTRUCTOR
			PARAMETERS:
			displayString = Array of Strings that this text box will display
			DO:
			Stores bufferStream into local variable bufferStream
			*/
			
			this.displayString = displayString;
			this.textSource = textSource;
			//store parameters as local variables
			
			open();
			//open the textbox
		}
		
		private function open():void{
			/*
			DO:
			Opens the textbox and displays the first text stream
			*/
			
			x = textSource.x;
			y = textSource.y;
			//set position of textbox to the stranger			
			
			drawOutline();
			drawTextField();
			
			txt_display.text = displayString;
			//display the text
		}
		
		public function close():void{
			/*
			DO:
			Closes the textbox.
			RETURN VALUE:
			Returns whether the box was closed before all text has been displayed.
			*/
			
			parent.removeChild(this);
			//remove the text box
		}
		
		private function drawOutline():void{
			/*
			DO:
			Draws the outline of the text box.
			*/
			
			spr_box = new Sprite();
			//create new sprite to hold the box
			
			spr_box.x = -BOXSIZE.x/2;
			spr_box.y = -BOXSIZE.y/2;
			//offset the box to center the bottom on the person's registration point
			
			spr_box.graphics.lineStyle(3);
			//set line to thickness of 3
			spr_box.graphics.drawRect(0, 0, BOXSIZE.x, BOXSIZE.y);
			//draw a box outline based on the BOXSIZE
			
			addChild(spr_box);
			//add the box to this MovieClip
		}
		
		private function drawTextField(){
			/*
			DO:
			Draws a text box to display the text
			*/
			
			txt_display = new TextField();
			//create textfield
			
			txt_display.x = -BOXSIZE.x/2;
			txt_display.y = -BOXSIZE.y/2;
			//offset the textfield to center the bottom on the person's registration point
			
			txt_display.width = BOXSIZE.x;
			txt_display.height = BOXSIZE.y;
			//define the size of the textfield
			
			txt_display.selectable = false;
			//cannot highlight text in the textfield
			
			txt_display.defaultTextFormat = TextController.newTextFormat(20);
			//set the text format of the textbox to font size 10			
			
			addChild(txt_display);
			//add the textfield to this MovieClip
		}
	}
	
}
