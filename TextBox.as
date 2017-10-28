package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import Controllers.TextController;
	import flash.events.Event;

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
		
		//SCALING VARIABLES
		
		private var scaleAssist:Delta;
		//controls scaling of the text box (used for popping up and out)
		
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
			
			if (displayString != null) { //if there is text provided
				scaleAssist = new Delta(this, ["scaleX", "scaleY"]);
			
				open();
				//open the textbox
			}
			else { //if no text is provided
				return; //stop trying to create a box
			}
		}
		
		private function open():void{
			/*
			DO:
			Opens the textbox and displays the first text stream
			*/		
			
			drawOutline();
			drawTextField();
			
			txt_display.text = displayString;
			//display the text
			
			scaleX = scaleY = 0;
			//completely collapse textbox as it spawns
			
			scaleAssist.setLogarithmic(1, 0.25);
			scaleAssist.setActive(true);
		}
		
		public function close():void{
			/*
			DO:
			Closes the textbox.
			RETURN VALUE:
			Returns whether the box was closed before all text has been displayed.
			*/
			
			scaleAssist.setAccelerate(0.1, -0.02);
			scaleAssist.setActive(true);
			//set a pop-out scaling mode for the textbox
			
			addEventListener(Event.ENTER_FRAME, checkFullCollapse);
			//begin collapse of the text box
		}
		
		private function checkFullCollapse(event:Event):void{
			if(scaleX < 0){
				scaleAssist.setActive(false);
				//stop allowing the textbox to change scale
				
				removeEventListener(Event.ENTER_FRAME, checkFullCollapse);
				//removes this event function
				
				parent.removeChild(this);
				//remove the text box
			}
		}
		
		private function drawOutline():void{
			/*
			DO:
			Draws the outline of the text box.
			*/
			
			spr_box = new Sprite();
			//create new sprite to hold the box
			
			spr_box.x = -BOXSIZE.x/2;
			spr_box.y = -BOXSIZE.y;
			//offset the box to center the bottom on the person's registration point
			
			
			spr_box.graphics.beginFill(0xffffff, 1);
			//fill the box with white
			spr_box.graphics.lineStyle(3);
			//set line to thickness of 3
			spr_box.graphics.drawRect(0, 0, BOXSIZE.x, BOXSIZE.y);
			//draw a box outline based on the BOXSIZE
			spr_box.graphics.endFill();
			//stop fill
			
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
			txt_display.y = -BOXSIZE.y;
			//offset the textfield to center the bottom on the person's registration point
			
			txt_display.width = BOXSIZE.x;
			txt_display.height = BOXSIZE.y;
			//define the size of the textfield
			
			txt_display.selectable = false;
			//cannot highlight text in the textfield
			
			txt_display.multiline = true;
			txt_display.wordWrap = true;
			//allow the text display in several lines
			
			txt_display.defaultTextFormat = TextController.newTextFormat(20);
			//set the text format of the textbox to font size 10			
			
			addChild(txt_display);
			//add the textfield to this MovieClip
		}
	}
	
}
