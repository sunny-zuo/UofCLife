package  {
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Delta {
		//used for changing a certain variable/property on the parent object at a certain rate
		
		private const MODES:Array = ["Logarithmic", "Linear", "Accelerate"];
		//UNUSED - list of modes possible for changing values
		
		private var parentObj:Object;
		//object that that the varName is in
		
		private var varNames:Array;
		//variable names that are being changed (length is 1 if only 1 variable is changed)
		
		private var changing:Boolean;
		//whether it is in use or not (value will change according to mode when active)
		
		private var deltaMode:String;
		//defines how the property will change
		
		/*scaleMode is:
		Logarithmic		= changes value logarithmically slower and slower as it approaches a target value 
		Linear			= changes linearly at a constant rate
		Accelerate		= changes via an acceleration
		*/
		
		private var valueTarget:Number;
		//exponential mode - value that it moves towards
		private var changeFactor:Number;
		//exponential mode - relative speed at which it exponentially approaches the valueTarget
		
		//LINEAR MODE VARIABLES
		
		private var changeSpeed:Number;
		//linear and accelerate modes - speed at which it changes
		private var changeAccel:Number;
		//accelerate mode - acceleration at which the changeSpeed changes
		
		public function Delta(parentObj:MovieClip, varNames:Array) {
			this.parentObj = parentObj;
			this.varNames = varNames;
			//set local variables
			
			changing = false;
			//inactive when first created
		}
		
		public function setActive(changing:Boolean){
			if(this.changing != changing){
				//parameter state is different from what state it is currently in
				
				this.changing = changing;
				//set changing to new state
				
				if(changing){
					trace("derp");
					parentObj.addEventListener(Event.ENTER_FRAME, changeFrame);
				}
				else{
					trace("wow");
					parentObj.removeEventListener(Event.ENTER_FRAME, changeFrame);
				}
			}
		}
		
		public function setLogarithmic(valueTarget:Number, changeFactor:Number):void{
			/*
			PARAMETERS:
			valueTarget = new value of valueTarget
			changeFactor = new value of changeFactor
			DO:
			Sets this to change the variable logarithmically when provided with valid parameters.
			*/
			
			if(changeFactor < 0 || changeFactor > 1){
				trace("ERROR: Unable to change to logarithmic mode. Enter a value between 0 and 1 for changeFactor");
				return;
			}
			
			deltaMode = "Logarithmic";
			this.valueTarget = valueTarget;
			this.changeFactor = changeFactor;
		}
		
		public function setLinear(changeSpeed:Number){
			/*
			PARAMETERS:
			changeSpeed = new value of changeSpeed
			DO:
			Sets this to change the variable linearly.
			*/
			deltaMode = "Linear";
			this.changeSpeed = changeSpeed;
		}
		
		public function setAccelerate(changeSpeed:Number, changeAccel:Number){
			/*
			PARAMETERS:
			changeSpeed = new value of changeSpeed
			changeAccel = new value of changeAccel
			DO:
			Sets this to change the variable acceleratively.
			*/
			deltaMode = "Accelerate";
			this.changeSpeed = changeSpeed;
			this.changeAccel = changeAccel;
		}
		
		private function changeFrame(event:Event):void{
			/*
			DO:
			Changes the variable. This event function is added when changing is set to true, and is removed when changing is set to false.
			*/

			//trace(parentObj[varNames[0]],parentObj[varNames[1]]);
			trace("hi");
			if(deltaMode == "Logarithmic"){
				for(var i:int = 0; i < varNames.length; i++){
					parentObj[varNames[i]] += (valueTarget - parentObj[varNames[i]]) * changeFactor;
					//logarithmic growth
					//trace(parentObj[varNames[0]] - valueTarget);
					if(Math.abs(parentObj[varNames[0]] - valueTarget) < 0.01){
						//if it is very close to its valueTarget, then stop the logarithmic growth
						setActive(false);
						//disable growth
					}
				}
			}
			else if(deltaMode == "Linear"){
				for(var j:int = 0; j < varNames.length; j++){
					parentObj[varNames[j]] += changeSpeed;
					//linear growth
				}
			}
			else if(deltaMode == "Accelerate"){
				for(var k:int = 0; k < varNames.length; k++){
					changeSpeed += changeAccel;
					parentObj[varNames[k]] += changeSpeed;
					//acceleration growth
				}
			}
			else{
				trace("ERROR: Mode not found!");
			}
		}

	}
	
}
