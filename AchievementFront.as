package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class AchievementFront extends MovieClip {

		private var progressBarWidth: Number; //width of the progress bar
		private var currentPageNumber: int = 1; //current page number
		private var buildingSelected: int = 1; //building selected. 1 = edc
		private var maxPageNumber: int; //largest value the page number can be

		private var achievementHandler: AchievementHandler = new AchievementHandler();

		public function AchievementFront() {
			// constructor code
			init();
		}

		private function init() {
			updateDisplay();
			this.increasePageButton.addEventListener(MouseEvent.CLICK, increasePageNumber);
			this.decreasePageButton.addEventListener(MouseEvent.CLICK, decreasePageNumber);
		}

		public function grantAchievement(building: String, achievementName: String) {
			achievementHandler.completeAchievement(building, achievementName);
			updateDisplay();
		}

		private function updateDisplay(): void {
			if (isNaN(progressBarWidth)) {
				progressBarWidth = this.progressBar.width; //if the progress bar width does not exist, set it
			}

			if (buildingSelected == 1) { //if the EDC building is selected
				updateEDCInfo(); //updates edc info if edc is selected
			}
			this.pageNumber.text = "Page " + currentPageNumber + "/" + maxPageNumber; //sets the page number values
		}

		private function updateEDCInfo(): void {
			maxPageNumber = Math.ceil(achievementHandler.achievementData.data.edc.length / 3); //max page number is the num of achievements divided by 3, since 3 on each page
			//Changes achievement progress stats
			this.progressBar.width = (achievementHandler.achievementData.data.numComplete / achievementHandler.achievementData.data.numAchievements) * progressBarWidth //sets the progress bar width
			this.percentCompleteText.text = String(Math.floor((achievementHandler.achievementData.data.numComplete / achievementHandler.achievementData.data.numAchievements) * 100)) + "% Complete"; //sets the % complete text
			//Change page display
			var firstAchievementToDisplay: int = (currentPageNumber * 3) - 3; //sets the number of the first achievement to display on the page
			//Holder One
			this.achievementHolderOne.achievementName.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay][0]; //updates name
			this.achievementHolderOne.achievementDescription.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay][1]; //updates description
			//Art should be here, however it has not been implemented. Art info would be the [2] value of the array
			if (achievementHandler.achievementData.data.edc[firstAchievementToDisplay][3]) {
				this.achievementHolderOne.completeStatus.gotoAndStop(2); //if the achievement is obtained, checkmark
			} else {
				this.achievementHolderOne.completeStatus.gotoAndStop(1); //if achievement is not obtained, X
			}

			//Holder Two
			if (firstAchievementToDisplay + 1 < achievementHandler.achievementData.data.edc.length) { //if the array is long enough so that an achievement exists, then fill the info
				this.achievementHolderTwo.achievementName.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay + 1][0]; //updates name
				this.achievementHolderTwo.achievementDescription.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay + 1][1]; //updates description
				//Art should be here, however it has not been implemented. Art info would be the [2] value of the array
				if (achievementHandler.achievementData.data.edc[firstAchievementToDisplay + 1][3]) {
					this.achievementHolderTwo.completeStatus.gotoAndStop(2); //if the achievement is obtained, checkmark
				} else {
					this.achievementHolderTwo.completeStatus.gotoAndStop(1); //if achievement is not obtained, X
				}
			} else {
				this.achievementHolderTwo.achievementName.text = "";
				this.achievementHolderTwo.achievementDescription.text = "";
				this.achievementHolderTwo.completeStatus.gotoAndStop(3); //blank box is at the third frame
			}

			//Holder Three
			if (firstAchievementToDisplay + 2 < achievementHandler.achievementData.data.edc.length) { //if the array is long enough so that an achievement exists, then fill the info
				this.achievementHolderThree.achievementName.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay + 2][0]; //updates name
				this.achievementHolderThree.achievementDescription.text = achievementHandler.achievementData.data.edc[firstAchievementToDisplay + 2][1]; //updates description
				//Art should be here, however it has not been implemented
				if (achievementHandler.achievementData.data.edc[firstAchievementToDisplay + 2][3]) {
					this.achievementHolderThree.completeStatus.gotoAndStop(2); //if the achievement is obtained, checkmark
				} else {
					this.achievementHolderThree.completeStatus.gotoAndStop(1); //if achievement is not obtained, X
				}
			} else {
				this.achievementHolderThree.achievementName.text = ""; //sets the text to blank if the achievement does not exist
				this.achievementHolderThree.achievementDescription.text = ""; //sets the text to blank if the achievement does not exist
				this.achievementHolderThree.completeStatus.gotoAndStop(3); //nothing is at third frame, so the complete status box wouldn't be in an empty achievement
			}
		}

		private function increasePageNumber(event: MouseEvent): void {
			if ((currentPageNumber + 1) > maxPageNumber) { //if the new page would be over the max page number allowed, set to page 1
				currentPageNumber = 1;
				updateDisplay(); //update after changing page
			} else {
				currentPageNumber += 1; //else, increase the page normally
				updateDisplay(); //and update the display
			}
		}

		private function decreasePageNumber(event: MouseEvent): void {
			if ((currentPageNumber - 1) < 1) { //if the page would become below page 1
				currentPageNumber = maxPageNumber; //set to the last page
				updateDisplay(); //and update the display
			} else {
				currentPageNumber -= 1; //else, reduce the page normally
				updateDisplay(); //and update the display
			}
		}

	}

}