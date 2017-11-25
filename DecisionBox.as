package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class DecisionBox extends MovieClip{
		/*PURPOSE:
		Decision box that pops up whenever the player makes a YES/NO decision.
		*/
		
		private var yes:Function;
		//called when yes is selected
		private var no:Function;
		//called when no is selected
		private var yesParams:Array;
		//parameters for the yes function
		private var noParams:Array;
		//parameters for the no function
		private var applyTarget:Object;
		//object the functions are called upon
		
		private var scaleAssist:DeltaAssist;
		private var alphaAssist:DeltaAssist;
		
		public function DecisionBox(yes:Function, yesParams:Array, no:Function, noParams:Array, applyTarget:Object) {
			/*
			PARAMETERS:
			yes = function to be called when yes is selected
			yesParams = function parameters of yes
			no = function to be called when no is selected
			noParams = function parameters of no
			applyTarget = object the functions are called upon
			DO:
			Creates a decision box.
			*/
			this.yes = yes;
			this.no = no;
			this.yesParams = yesParams;
			this.noParams = noParams;
			this.applyTarget = applyTarget;
			//store decision functions
			
			alpha = 0;
			scaleX = 0.8;
			scaleY = 0.8;
			
			scaleAssist = new DeltaAssist(this, ["scaleX", "scaleY"]);
			alphaAssist = new DeltaAssist(this, ["alpha"]);
			
			scaleAssist.setLinear(0.02, 1);
			alphaAssist.setLinear(0.2, 1, activateButtons);
			//pop up animation
		}
		
		private function activateButtons():void{
			/*DO:
			Allow the Y/N buttons to be pushed.
			*/
			
			btn_yes.addEventListener(MouseEvent.CLICK, yesTrigger);
			
			btn_no.addEventListener(MouseEvent.CLICK, noTrigger);
		}
		
		private function yesTrigger(event:MouseEvent):void{		
			if(yes != null){
				//if yes is a defined function
				
				yes.apply(applyTarget, yesParams);
				//calls the yes function upon click
			}
			
			closePopUp();
			//close the pop up decision box
		}
		
		private function noTrigger(event:MouseEvent):void{
			if(no!= null){
				//if no is a defined function
				
				no.apply(applyTarget, noParams);
				//calls the no function upon click	
			}
			
			closePopUp();
			//close the pop up decision box
		}
		
		private function closePopUp():void{
			/*
			DO:
			Closes the pop up decision box.
			*/
			
			btn_yes.removeEventListener(MouseEvent.CLICK, yesTrigger);
			btn_no.removeEventListener(MouseEvent.CLICK, noTrigger);
			//removes the event listeners so that clicking on yes and no does nothing
			
			scaleAssist.setLinear(-0.02, 0.08);
			alphaAssist.setLinear(-0.2, 0, cleanUp);
			//pop out animation
		}
		
		private function cleanUp():void{
			parent.removeChild(this);
			//destroys this pop up completely
		}

	}
	
}
