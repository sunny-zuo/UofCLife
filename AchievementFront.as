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
			updateDisplay();
		}
		
		public function grantAchievement(building:String, achievementName:String) {
			achievementHandler.completeAchievement(building, achievementName);
			updateDisplay();
		}
		
		private function updateDisplay():void {
			progressBarWidth = this.progressBar.width;
			this.progressBar.width = (achievementHandler.achievementData.data.numComplete/achievementHandler.achievementData.data.numAchievements)*progressBarWidth
			this.percentCompleteText.text = String(Math.floor((achievementHandler.achievementData.data.numComplete/achievementHandler.achievementData.data.numAchievements)*100)) + "% Complete";
		}
		
	}
	
}
