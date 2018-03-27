package  {
	import flash.events.*;
	import flash.utils.Timer;
	import flash.display.MovieClip;

	public class AchievementComplete extends MovieClip{
		
		private var achievementName:String; //name of the achievement
		private var displayDuration:int; //how long to show the achievement complete info, in seconds
		private var timer:Timer; //timer
		
		public function AchievementComplete(achievementName:String, displayDuration:int = 4) {
			// constructor code
			this.achievementName = achievementName;
			this.displayDuration = displayDuration;
			init();
		}
		private function init():void {
			this.achievementNameText.text = achievementName;
			this.addEventListener(Event.ADDED_TO_STAGE, waitToRemove);
		}
		private function waitToRemove(event:Event):void {
			timer = new Timer((displayDuration * 1000), 1)
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, removeSelf);
			timer.start();
		}
		private function removeSelf(event:TimerEvent):void {
			this.parent.removeChild(this);
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, removeSelf);
			timer = null;
		}

	}
	
}
