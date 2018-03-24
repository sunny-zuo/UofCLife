package  
{
	import flash.events.*;
	import flash.utils.Timer;
	import flash.display.MovieClip;
	
	public class timeController extends MovieClip
	{

		private var my_timer:Timer = new Timer(10);
		private var time:Array = new Array[1,1,8,1,1];//month(12), day(30), hour(24), minute(60), second(60)
		
		public function timeController() 
		{
			
			my_timer.addEventListener(TimerEvent.TIMER, onTimer);
			my_timer.start(); 
			
		}

		private function onTimer(event: TimerEvent):void //function that updates the time
		{
			
			
			
		//trace("seconds: " + time[4] + " minutes: " + time[3] + " hours: " + time[2] + " days: " + time[1]+ " months: " + time[0]);
			
			if(time[4] != 59)//add one second if the seconds are not equal to 59
			{
				time[4] += 1;
				
			} else if(time[3] != 59)//add one minute if the minutes are not equal to 59
			{
				time[4] = 0;
				time[3] += 1
				
			} else if(time[2] != 23)//add one hour if the hours are not equal to 23
			{
				time[4] = 0;
				time[3] = 0;
				time[2] += 1;
				
			} else if(time[1] != 29)//add one day if the days are not equal to 29
			{
				time[4] = 0;
				time[3] = 0;
				time[2] = 0;
				time[1] += 1;
			} else if(time[1] != 29)//add one month if the months are not equal to 11
			{
				time[4] = 0;
				time[3] = 0;
				time[2] = 0;
				time[1] = 0;
				time[0] += 1;
			}
			
		}	
	
		public function getTime(): Array//returns the time array
		{
			return(time.concat());
		}
		
		public function changeTime(posistion: int = 0, newTime:int = 1):void
		{
			time[posistion] = newTime;
		}
		
		
	}
}
