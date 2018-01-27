package  {
	import flash.events.MouseEvent;
	
	public class ConfessionPopup {
		private var confessionAPI:ConfessionAPI = new ConfessionAPI();
		//generates confessions
		
		private var scaleAssist:DeltaAssist;
		private var alphaAssist:DeltaAssist;
		
		private var loadedData:Object;
		
		private var lastConfession:int = -1;
		//no last confession (no confession has index of -1)
		
		public function ConfessionPopup() {
			alpha = 0;
			scaleX = 0.8;
			scaleY = 0.8;
			
			scaleAssist = new DeltaAssist(this, ["scaleX", "scaleY"]);
			alphaAssist = new DeltaAssist(this, ["alpha"]);
			
			scaleAssist.setLinear(0.02, 1);
			alphaAssist.setLinear(0.2, 1, activateButtons);
			//pop up animation
			
			Main.instance.character.allowCharMove = false;
			//don't let character move while this menu is on			
			
			init();
		}
		
		private function init():void{
			confessionsAPI.fetchConfessions(); //runs the fetchConfessions function which gets the confessions
			
			//btn_next.addEventListener(MouseEvent.CLICK, refreshConfession);
			//event listener for a click to refresh for a new confession
			
			btn_close.txt_display.text = "Close";
			
			//event listener to close popup

			addEventListener(Event.ENTER_FRAME, waitForLoad);
		}
		
		private function waitForLoad(event: Event): void {
			if (confessionAPI.loadDone) { //waits for the data to be grabbed
				loadedData = questionAPI.loadedData; //grabs loaded data from questionAPI
				
			trace("END");				
				
				removeEventListener(Event.ENTER_FRAME, waitForLoad); //removes the event listener as this function is no longer needed
			}
		}
		
		private function selectRandomConfession(last:int):String{
			/*
			Return Value:
			Returns a String for a confession that is not the same as the current one being displayed.
			*/
			
			var rv:int = Math.random()*23;
			
			while(rv == last){
				rv = Math.random()*23;
			}
			
			
		}
		
		private var activateButtons():void{
			/*DO:
			Allow the buttons to be pushed.
			*/
			
			//btn_next.addEventListener(MouseEvent.CLICK, refreshConfession);
			
			btn_close.addEventListener(MouseEvent.CLICK, closePopup);
		}
		
		private function closePopup(event:MouseEvent):void{
			btn_next.removeEventListener(MouseEvent.CLICK, refreshConfession);
			btn_close.removeEventListener(MouseEvent.CLICK, closePopup);
			//removes the event listeners so that clicking on yes and no does nothing
			
			scaleAssist.setLinear(-0.02, 0.08);
			alphaAssist.setLinear(-0.2, 0, cleanUp);
			//pop out animation
			
			Main.instance.character.allowCharMove = true;
			//let character move when menu disappears
		}
		
		private function cleanUp():void{
			parent.removeChild(this);
			//destroys this pop up completely
		}

	}
	
}
