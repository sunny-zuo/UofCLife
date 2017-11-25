package  {	import flash.events.Event;	import flash.display.MovieClip;	import flash.display.DisplayObject;		public class DeltaAssist {		//used for changing a certain variable/property on the parent object at a certain rate				private const MODES:Array = ["Logarithmic", "Linear", "Accelerate"];		//UNUSED - list of modes possible for changing values				private var parentObj:Object;		//object that that the varName is in				private var varNames:Array;		//variable names that are being changed (length is 1 if only 1 variable is changed)				private var changing:Boolean;		//whether it is in use or not (value will change according to mode when active)				private var deltaMode:String;		//defines how the property will change				/*scaleMode is:		Logarithmic		= changes value logarithmically slower and slower as it approaches a target value 		Linear			= changes linearly at a constant rate		Accelerate		= changes via an acceleration		*/				//PARAMETERS		private var useTarget:Boolean;		//linear and accelerate modes - whether a valueTarget is being used (valueTarget is always used in exponential mode)				private var valueTarget:Number;		//all modes - value that it moves towards (optional in linear and accelerate modes)				private var changeFactor:Number;		//exponential mode - relative speed at which it exponentially approaches the valueTarget				private var changeSpeed:Number;		//linear and accelerate modes - speed at which it changes				private var changeAccel:Number;		//accelerate mode - acceleration at which the changeSpeed changes
		
		private var finishFunc:Function;
		//function that executes when delta has finished changing
		
		private var funcParam:Array;
		//function that executes when delta has finished changing				public function DeltaAssist(parentObj:DisplayObject, varNames:Array) {			this.parentObj = parentObj;			this.varNames = varNames;			//set local variables						changing = false;			//inactive when first created		}				public function setActive(changing:Boolean = true){			if(this.changing != changing){				//parameter state is different from what state it is currently in								this.changing = changing;				//set changing to new state								if(changing){					parentObj.addEventListener(Event.ENTER_FRAME, changeFrame);				}				else{					parentObj.removeEventListener(Event.ENTER_FRAME, changeFrame);				}			}		}				public function setLogarithmic(valueTarget:Number, changeFactor:Number, finishFunc:Function = null, funcParam:Array = null):void{			/*			PARAMETERS:			valueTarget = new value of valueTarget			changeFactor = new value of changeFactor			DO:			Sets this to change the variable logarithmically when provided with valid parameters.			*/						if(changeFactor < 0 || changeFactor > 1){				trace("ERROR: Unable to change to logarithmic mode. Enter a value between 0 and 1 for changeFactor");				return;			}						deltaMode = "Logarithmic";			this.valueTarget = valueTarget;			this.changeFactor = changeFactor;
			this.finishFunc = finishFunc;			this.funcParam = funcParam;
						setActive();		}				public function setLinear(changeSpeed:Number, valueTarget = null, finishFunc:Function = null, funcParam:Array = null):void{			/*			PARAMETERS:			changeSpeed = new value of changeSpeed			valueTarget = value to stop changing once the value is at this number			DO:			Sets this to change the variable linearly.			*/			deltaMode = "Linear";			this.changeSpeed = changeSpeed;
			this.finishFunc = finishFunc;
			this.funcParam = funcParam;			
						if(valueTarget is Number){				useTarget = true;				//use the value target to compute changes				this.valueTarget = valueTarget;			}						setActive();		}				public function setAccelerate(changeSpeed:Number, changeAccel:Number, valueTarget = null, finishFunc:Function = null, funcParam:Array = null):void{			/*			PARAMETERS:			changeSpeed = new value of changeSpeed			changeAccel = new value of changeAccel			DO:			Sets this to change the variable acceleratively.			*/			deltaMode = "Accelerate";			this.changeSpeed = changeSpeed;			this.changeAccel = changeAccel;
			this.finishFunc = finishFunc;
			this.funcParam = funcParam;
						if(valueTarget is Number){				useTarget = true;				//use the value target to compute changes				this.valueTarget = valueTarget;			}						setActive();		}				private function changeFrame(event:Event):void{			/*			DO:			Changes the variable. This event function is added when changing is set to true, and is removed when changing is set to false.			*/						if(deltaMode == "Logarithmic"){
				parentObj[varNames[0]] += (valueTarget - parentObj[varNames[0]]) * changeFactor;
				//logarithmic growth
				
				if(Math.abs(parentObj[varNames[0]] - valueTarget) < 0.01){
					//if it is very close to its valueTarget, then stop the logarithmic growth
					setActive(false);
					//disable growth
					if(finishFunc != null){
						//if finishFunc is not null
						finishFunc.apply(parentObj, funcParam);
						//run the function when it reaches the goal
					}
				}
								for(var i:int = 1; i < varNames.length; i++){					parentObj[varNames[i]] = parentObj[varNames[0]];
					//copy it to all the other variables				}			}			else if(deltaMode == "Linear"){
				parentObj[varNames[0]] += changeSpeed;
				//linear growth
				if(useTarget){
					if(Math.abs(valueTarget - parentObj[varNames[0]]) <= Math.abs(changeSpeed)){
						//value is very close to target value
						parentObj[varNames[0]] = valueTarget;
						//set it to the target value
						setActive(false);
						//disable change
						if(finishFunc != null){
						//if finishFunc is not null
							finishFunc.apply(parentObj, funcParam);
							//run the function when it reaches the goal
						}
					}
				}				for(var j:int = 1; j < varNames.length; j++){					parentObj[varNames[j]] = parentObj[varNames[0]];
					//copy it to all the other variables				}			}			else if(deltaMode == "Accelerate"){
				changeSpeed += changeAccel;
				parentObj[varNames[0]] += changeSpeed;
				//acceleration growth
				if(useTarget){
					if(Math.abs(valueTarget - parentObj[varNames[0]]) <= Math.abs(valueTarget - (parentObj[varNames[0]] + changeSpeed))){
						//value is very close to target value
						parentObj[varNames[0]] = valueTarget;
						//set it to the target value
						setActive(false);
						//disable change
						if(finishFunc != null){
						//if finishFunc is not null
							finishFunc.apply(parentObj, funcParam);
							//run the function when it reaches the goal
						}
					}
				}
								for(var k:int = 0; k < varNames.length; k++){					parentObj[varNames[k]] = parentObj[varNames[0]];
					//copy it to all the other variables				}			}			else{				trace("ERROR: Mode not found!");			}		}	}	}