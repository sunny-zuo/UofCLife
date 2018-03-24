﻿package  {	import flash.events.Event;	import flash.display.MovieClip;	import flash.display.DisplayObject;		public class DeltaAssist extends MovieClip{		//used for changing a certain variable/property on the parent object at a certain rate				private const MODES:Array = ["Logarithmic", "Linear", "Accelerate"];		//UNUSED - list of modes possible for changing values				private var parentObj:Object;		//object that that the varName is in				private var varNames:Array;		//variable names that are being changed (length is 1 if only 1 variable is changed)				private var changing:Boolean;		//whether it is in use or not (value will change according to mode when active)				private var deltaMode:String;		//defines how the property will change				/*scaleMode is:		Logarithmic		= changes value logarithmically slower and slower as it approaches a target value 		Linear			= changes linearly at a constant rate		Accelerate		= changes via an acceleration		*/				//PARAMETERS		private var useTarget:Boolean;		//linear and accelerate modes - whether a valueTarget is being used (valueTarget is always used in exponential mode)				private var valueTarget:Number;		//all modes - value that it moves towards (optional in linear and accelerate modes)				private var changeFactor:Number;		//exponential mode - relative speed at which it exponentially approaches the valueTarget				private var changeSpeed:Number;		//linear and accelerate modes - speed at which it changes				private var changeAccel:Number;		//accelerate mode - acceleration at which the changeSpeed changes				private var finishFunc:Function;		//function that executes when delta has finished changing				private var funcParam:Array;		//function that executes when delta has finished changing				public function DeltaAssist(parentObj:Object, varNames:Array) {			this.parentObj = parentObj;			this.varNames = varNames;			//set local variables						changing = false;			//inactive when first created		}				public function setActive(changing:Boolean = true){			if(this.changing != changing){				//parameter state is different from what state it is currently in								this.changing = changing;				//set changing to new state								if(changing){					addEventListener(Event.ENTER_FRAME, changeFrame);				}				else{					removeEventListener(Event.ENTER_FRAME, changeFrame);				}			}		}				public function setLogarithmic(valueTarget:Number, changeFactor:Number, finishFunc:Function = null, funcParam:Array = null):void{			/*			PARAMETERS:			valueTarget = new value of valueTarget			changeFactor = new value of changeFactor			DO:			Sets this to change the variable logarithmically when provided with valid parameters.			*/						if(changeFactor < 0 || changeFactor > 1){				trace("ERROR: Unable to change to logarithmic mode. Enter a value between 0 and 1 for changeFactor");				return;			}						deltaMode = "Logarithmic";			this.valueTarget = valueTarget;			this.changeFactor = changeFactor;			this.finishFunc = finishFunc;			this.funcParam = funcParam;						setActive();		}				public function setLinear(changeSpeed:Number, valueTarget = null, finishFunc:Function = null, funcParam:Array = null):void{			/*			PARAMETERS:			changeSpeed = new value of changeSpeed			valueTarget = value to stop changing once the value is at this number			DO:			Sets this to change the variable linearly.			*/			deltaMode = "Linear";			this.changeSpeed = changeSpeed;			this.finishFunc = finishFunc;			this.funcParam = funcParam;									if(valueTarget is Number){				useTarget = true;				//use the value target to compute changes				this.valueTarget = valueTarget;			}						setActive();		}				public function setAccelerate(requireChangeSpeed:Boolean, changeSpeed:Number, changeAccel:Number, valueTarget = null, finishFunc:Function = null, funcParam:Array = null):void{			/*			PARAMETERS:
			requireChangeSpeed = whether the change speed value is accepted			changeSpeed = new value of changeSpeed			changeAccel = new value of changeAccel			DO:			Sets this to change the variable acceleratively.			*/			deltaMode = "Accelerate";			if(requireChangeSpeed){				this.changeSpeed = changeSpeed;			}			this.changeAccel = changeAccel;			this.finishFunc = finishFunc;			this.funcParam = funcParam;						if(valueTarget is Number){				useTarget = true;				//use the value target to compute changes				this.valueTarget = valueTarget;			}						setActive();		}				private function changeFrame(event:Event):void{			/*			DO:			Changes the variable. This event function is added when changing is set to true, and is removed when changing is set to false.			*/						if(deltaMode == "Logarithmic"){				for(var i:int = 0; i < varNames.length; i++){					parentObj[varNames[i]] += (valueTarget - parentObj[varNames[i]]) * changeFactor;					//logarithmic growth					//trace(parentObj[varNames[i]] - valueTarget);					if(Math.abs(parentObj[varNames[i]] - valueTarget) < 0.01){						//if it is very close to its valueTarget, then stop the logarithmic growth						setActive(false);						//disable growth						runEndFunction();					}				}			}			else if(deltaMode == "Linear"){				for(var j:int = 0; j < varNames.length; j++){					parentObj[varNames[j]] += changeSpeed;					//linear growth					if(useTarget){						if(Math.abs(valueTarget - parentObj[varNames[j]]) <= Math.abs(changeSpeed)){							//value is very close to target value							parentObj[varNames[j]] = valueTarget;							//set it to the target value							setActive(false);							//disable change							runEndFunction();						}					}				}			}			else if(deltaMode == "Accelerate"){				for(var k:int = 0; k < varNames.length; k++){					changeSpeed += changeAccel;					parentObj[varNames[k]] += changeSpeed;					//acceleration growth										if(useTarget){						if(Math.abs(valueTarget - parentObj[varNames[k]]) <= Math.abs(valueTarget - (parentObj[varNames[k]] + changeSpeed))){							//value is very close to target value							parentObj[varNames[k]] = valueTarget;							//set it to the target value							setActive(false);							//disable change														runEndFunction();						}					}				}			}			else{				trace("ERROR: Mode not found!");			}		}
		
		private function runEndFunction():void{
			if(finishFunc != null){
				//if finishFunc is not null
				finishFunc.apply(parentObj, funcParam);
				//run the function when it reaches the goal
				
				finishFunc = null;
				//set it to null so it is not run again
			}
		}	}	}