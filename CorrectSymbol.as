package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.*

	public class CorrectSymbol extends MovieClip {
		
		public function CorrectSymbol() {
			//constructor code
			init();
		}
		private function init() {
			addEventListener(Event.ADDED_TO_STAGE, waitToRemove);
		}
		private function waitToRemove (event:Event) {
			var timer:Timer = new Timer(1500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, removeThis);
			timer.start();
		}
		private function removeThis(event:Event) {
			this.parent.removeChild(this);
		}
	}
}