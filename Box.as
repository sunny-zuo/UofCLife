package  
{
	import flash.display.MovieClip;
	//simport flash.display.graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Box extends MovieClip
	{
		
		private var rect:Sprite;
		private var exitButton:Sprite;
		private var scaleAssist:DeltaAssist = new DeltaAssist(this, ["scaleX", "scaleY"]);
		private var alphaAssist:DeltaAssist = new DeltaAssist(this, ["alpha"]);
		
		public function Box() 
		{
			// constructor code
			
			init();
		}
		private function init()
		{
			//Initialization
			rect=new Sprite();
			rect.graphics.beginFill(0x00000);
			rect.graphics.drawRoundRect(-5,-5,0.50*Main.stg.stageWidth+10,0.5* Main.stg.stageHeight+10,30);
			rect.graphics.beginFill(0xaaaaaa);
			rect.graphics.drawRoundRect(0,0,0.50*Main.stg.stageWidth,0.5* Main.stg.stageHeight, 30);
			rect.graphics.endFill();
			this.addChild(rect);
			
			exitButton=new Sprite()
			exitButton.graphics.beginFill(0xff0000);
			exitButton.graphics.drawRoundRect(10,10,25,25,5);
			exitButton.graphics.endFill();
			exitButton.graphics.beginFill(0xdddddd);
			exitButton.graphics.lineStyle(1,0xdddddd,1);
			exitButton.graphics.moveTo(12,12);
			exitButton.graphics.lineTo(33,33);
			exitButton.graphics.moveTo(12,33);
			exitButton.graphics.lineTo(33,12);
			exitButton.graphics.endFill();
			exitButton.buttonMode=true;
			exitButton.addEventListener(MouseEvent.CLICK, exit);
			
			this.addChild(exitButton);
			scaleAssist.setLinear(0.02, 1);
			alphaAssist.setLinear(0.2, 1, null);
		}
		
		private function exit(event:MouseEvent)
		{
			exitButton.removeEventListener(MouseEvent.CLICK,exit);
			MenuController.currentPopup = null;
			scaleAssist.setLinear(-0.02, 0.08);
			alphaAssist.setLinear(-0.2, 0, cleanUp);
			//cleanUp();
			Main.instance.character.allowCharMove = true;
		}
		private function cleanUp():void{			
			parent.removeChild(this);
			//destroys this pop up completely
		}
	}
	
}
