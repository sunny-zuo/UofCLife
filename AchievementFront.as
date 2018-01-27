package  {
	import flash.display.MovieClip;
	
	public class AchievementFront extends MovieClip {
		
		private var progressBarWidth:Number;
		
		private var achievementHandler:AchievementHandler = new AchievementHandler();
		
		public function AchievementFront() {
			// constructor code
			init();
		}
		
		private function init() {
			progressBarWidth = this.progressBar.width; 
		}
		
		public function grantAchievement(building:String, achievementName:String) {
			achievementHandler.completeAchievement(building, achievementName);
		}
		
	}
	
}
