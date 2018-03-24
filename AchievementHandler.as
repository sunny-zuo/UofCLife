package {
	import flash.net.SharedObject;

	public class AchievementHandler {

		public var achievementData: SharedObject = SharedObject.getLocal("ls92ud31"); //random string for a poor attempt at hiding the data
		/* Properties of the sharedObject:
		  numComplete: number of achievements that have been complete
		  numAchievements: number of achievements total
		  buildingList: list of buildings
		  <buildingName>: list of achievements in those buildings, in array format [title, description, art, achieved]
		*/

		private var buildingList: Array = new Array();
		private var edc: Array = null;

		private var totalAchievementCount: int = 4; //number of achievements total, please update as more are added.

		//EDC ACHIEVEMENTS
		private var edcAchievementCount: int = 3; //number of achievements in the edc building. please update as more are added.
		private var edcAchievement1: Array = ["Quiz Novice", "Beat the geography quiz once", null, false];
		private var edcAchievement2: Array = ["Quiz Pro", "Beat the geography quiz twice", null, false];
		private var edcAchievement3: Array = ["Quiz Expert", "Beat the geography quiz thrice", null, false];
		private var edcAchievement4: Array = ["Quiz Master", "Beat the geography quiz for the foruth time", null, false];
		
		//END EDC ACHIEVEMENTS

		public function AchievementHandler() {
			// constructor code
			init();
		}
		private function init() {

			achievementData.data.numAchievements = totalAchievementCount;
			achievementData.data.numComplete = 1;
			if (achievementData.data.numComplete == null) {
				achievementData.data.numComplete = 0; //sets the number complete to zero if it doesn't exist yet
			}

			buildingList = ["edc"]
			achievementData.data.buildingList = buildingList;

			addEdcAchievements();
		}

		private function addEdcAchievements(): void {
			edc = null;
			edc = new Array();
			trace(achievementData.data.edc);
			trace("hi");
			if (achievementData.data.edc != undefined) {
				for (var j:int = 0; j < edcAchievementCount; j++) {
					var target2: Array = this["edcAchievement" + (j + 1)] as Array;
					if (achievementData.data.edc[j+1][3]) { //if the achievement was completed, mark it as such
						target2[3] = true;
					}
					edc.push(target2);
				}
				
			}
			else {
				for (var i:int = 0; i < edcAchievementCount; i++) {
					var target: Array = this["edcAchievement" + (i + 1)] as Array;
					edc.push(target);
				}
			}
			
			achievementData.data.edc = edc;
			achievementData.flush(); //"commits" the data to disk

		}

		public function completeAchievement(building: String, achievementName: String) {
			var target: Array = this[building] as Array; //uses the building name to target an array
			for (var i = 0; i < target.length; i++) {
				if (target[i][0] == achievementName && target[i][3] == false) {
					target[i][3] = true;
					achievementData.data.edc = edc;
					achievementData.data.numComplete += 1;
					achievementData.flush(); //saves the data to disk

					return;
				}
			}
		}

	}

}