package  {
	import flash.display.MovieClip;
	
	public class AchievementFront extends MovieClip {
		
		private var progressBarWidth:Number;
		
		private var achievementHandler:AchievementHandler;
		
		public function AchievementFront() {
			// constructor code
			init();
		}
		
		private function init() {
			progressBarWidth = this.progressBar.width; 
		}
		
	}
	
}
