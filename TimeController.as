package  
{
	import flash.events.*;
	import flash.utils.Timer;
	import flash.display.MovieClip;
	
	public class TimeController extends MovieClip
	{
		private var my_timer:Timer = new Timer(1000);
		public var time:Array = [1,1,8,1,1];//second(60), minute(60), hour(24), day(30), month(12)
		
		//parallel arrays
		private var activateTimes:Array = [];//array for activateTimes
		private var timeEvents:Array = [];//array for the timeEvents
		private var parentObjects:Array = [];//array for the parentObjects
		
		public function TimeController() 
		{
			/*
			DO:
			add event listeners
			*/
			my_timer.addEventListener(TimerEvent.TIMER, onTimer);
			my_timer.start(); 
			
		}

		private function onTimer(event: TimerEvent):void //function that updates the time
		{
			
			/* 
			DO:
			updates the time whenever the timer activates.
			*/
			
			if(time[0] != 59)//add one second if the seconds are not equal to 59
			{
				time[0] += 1;
				
			} else if(time[1] != 59)//add one minute if the minutes are not equal to 59
			{
				time[0] = 0;
				time[1] += 1
				
			} else if(time[2] != 23)//add one hour if the hours are not equal to 23
			{
				time[0] = 0;
				time[1] = 0;
				time[2] += 1;
				
			} else if(time[3] != 29)//add one day if the days are not equal to 29
			{
				time[0] = 0;
				time[1] = 0;
				time[2] = 0;
				time[3] += 1;
			} else if(time[4] != 11)//add one month if the months are not equal to 11
			{
				time[0] = 0;
				time[1] = 0;
				time[2] = 0;
				time[3] = 0;
				time[4] += 1;
			}

			/* 
			DO:
			checks through the activateTimes to check if any match. If they do then add the relative timeEvent to the objects time array. IF THERE IS A EVENT IN THE OBJECT ALREADY, IT WILL BE OVERRIDDEN!!!
			*/
			for(var i:int = 0; i < activateTimes.length; i++)
			{
				if(activateTimes[i][4] == time[4] || activateTimes[i][4] == -1)//check to see if the month matches
				{
					if(activateTimes[i][3] == time[3] || activateTimes[i][3] == -1)//check to see if the day matches
					{
						if(activateTimes[i][2] == time[2] || activateTimes[i][2] == -1)//check to see if the hour matches
						{
							if(activateTimes[i][1] == time[1] || activateTimes[i][1] == -1)//check to see if the minute matches
							{
								
								if(activateTimes[i][0] == time[0])//check to see if the second matches
								{
									parentObjects[i].movementDirections = timeEvents[i];
									parentObjects[i].startScriptedWalk();
								}
							}
						}
					}
				}
						
				
			}
			
		}
	
		public function getTime(pos: int): int//returns the time array
		{
			/*
			PARAMETERS:
			the posistion in the time array to get the value from
			
			DO:
			returns the time at the array posistion given in the parameter
			
			RETURN VALUE:
			int
			*/
			return(time[pos]);
		}
		
		public function changeTime(posistion: int = 0, newTime:int = 1):void
		{
			/*
			PARAMETERS:
			posistion = the posistion in the array to change
			newTime = the new value you wish to input
			
			DO: 
			changes the value in the time array at the posistion to the newTime value
			*/
			time[posistion] = newTime;
		}

		public function addTimeEvent(parentObject: Object, activateTime:Array, timeEvent:Array):void 
		{
			/*
			PARAMETERS:
			parentObject = the object that this timeEvent will affect
			activateTime = the time at which you want the instructions to activate
			timeEvent = the array of instructions to execute at this time
			
			DO:
			adds a timeEvent to TimeControllers timeEvents array. 
			*/
			
			this.timeEvents.push(timeEvent);
			this.activateTimes.push(activateTime);//the activate times are an array going [second, minute, hour, day, month]. Second must have a number, -1 are blank times and can be inserted after the last time frame you want in acending order.
			this.parentObjects.push(parentObject);
		}
	}
}
