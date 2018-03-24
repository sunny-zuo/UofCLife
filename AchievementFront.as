package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class AchievementFront extends MovieClip {
		
		private var progressBarWidth:Number;
		private var currentPageNumber:int = 1;
		private var buildingSelected:int = 1;
		private var maxPageNumber:int;
		
		private var achievementHandler:AchievementHandler = new AchievementHandler();
		
		public function AchievementFront() {
			// constructor code
			init();
		}
		
		private function init() {
			updateDisplay();
			this.increasePageButton.addEventListener(MouseEvent.CLICK, increasePageNumber);
			this.decreasePageButton.addEventListener(MouseEvent.CLICK, decreasePageNumber);
		}
		
		public function grantAchievement(building:String, achievementName:String) {
			achievementHandler.completeAchievement(building, achievementName);
			updateDisplay();
		}
		
		private function updateDisplay():void {
			if (isNaN(progressBarWidth)) {
				progressBarWidth = this.progressBar.width;
			}
			
			if (buildingSelected == 1) { //if the EDC building is selected
				updateEDCInfo();
			}
			this.pageNumber.text = "Page " + currentPageNumber + "/" + maxPageNumber;
		}
		
		private function updateEDCInfo():void {
			maxPageNumber = Math.ceil(achievementHandler.achievementData.data.edc.length/3);
			//Changes achievement progress stats
			this.progressBar.width = (achievementHandler.achievementData.data.numComplete/achievementHandler.achievementData.data.numAchievements)*progressBarWidth
			this.percentCompleteText.text = String(Math.floor((achievementHandler.achievementData.data.numComplete/achievementHandler.achievementData.data.numAchievements)*100)) + "% Complete";
			//Change page display
			var firstAchievementToDisplay:int = (currentPageNumber * 3) - 3;
			//Holder One
			this.achievementHolderOne.achievementName.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay][0]; //updates name
			this.achievementHolderOne.achievementDescription.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay][1]; //updates description
			//Art should be here, however it has not been implemented
			if (achievementHandler.achievementData.data.edc[firstAchievementToDisplay][3]) {
				this.achievementHolderOne.completeStatus.gotoAndStop(2); //if the achievement is obtained, checkmark
			}
			else {
				this.achievementHolderOne.completeStatus.gotoAndStop(1); //if achievement is not obtained, X
			}
			
			//Holder Two
			this.achievementHolderTwo.achievementName.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay+1][0]; //updates name
			this.achievementHolderTwo.achievementDescription.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay+1][1]; //updates description
			//Art should be here, however it has not been implemented
			if (achievementHandler.achievementData.data.edc[firstAchievementToDisplay+1][3]) {
				this.achievementHolderTwo.completeStatus.gotoAndStop(2); //if the achievement is obtained, checkmark
			}
			else {
				this.achievementHolderTwo.completeStatus.gotoAndStop(1); //if achievement is not obtained, X
			}
			
			//Holder Three
			this.achievementHolderThree.achievementName.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay+2][0]; //updates name
			this.achievementHolderThree.achievementDescription.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay+2][1]; //updates description
			//Art should be here, however it has not been implemented
			if (achievementHandler.achievementData.data.edc[firstAchievementToDisplay+2][3]) {
				this.achievementHolderThree.completeStatus.gotoAndStop(2); //if the achievement is obtained, checkmark
			}
			else {
				this.achievementHolderThree.completeStatus.gotoAndStop(1); //if achievement is not obtained, X
			}
		}
		
		private function increasePageNumber(event:MouseEvent):void {
			if ((currentPageNumber + 1) > maxPageNumber) {
				currentPageNumber = 1;
				updateDisplay();
			}
			else {
				currentPageNumber += 1;
				updateDisplay();
			}
		}
		
		private function decreasePageNumber(event:MouseEvent):void {
			if ((currentPageNumber-1) < 1) {
				currentPageNumber = maxPageNumber;
				updateDisplay();
			}
			else {
				currentPageNumber -= 1;
				updateDisplay();
			}
		}
		
	}
	
}
