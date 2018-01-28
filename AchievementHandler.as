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
		private var edc: Array = new Array();
		
		private var totalAchievementCount:int = 3; //number of achievements total, please update as more are added.

		//EDC ACHIEVEMENTS
		private var edcAchievementCount: int = 3; //number of achievements in the edc building. please update as more are added.
		private var edcAchievement1: Array = ["Quiz Novice", "Beat the geography quiz", null, false];
		private var edcAchievement2: Array = ["Quiz Pro", "Beat the geography quiz twice", null, false];
		private var edcAchievement3: Array = ["Quiz Master", "Beat the geography quiz thrice", null, false];
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

			buildingList = [edc]
			achievementData.data.buildingList = buildingList;

			addEdcAchievements();
		}

		private function addEdcAchievements(): void {
			edc = null;
			edc = new Array();

			if (achievementData.data.edc != undefined) {
				edc = achievementData.data.edc;
				for (var i = 0; i < edcAchievementCount; i++) {
					var target: Array = this["edcAchievement" + (i + 1)] as Array;
					if (achievementData.data.edc[i].indexOf(target[0]) < 0) {
						trace(achievementData.data.edc[i][0]);
						trace(target[0]);
						edc.push(target);
					}
				}


			} else {
				for (var ii = 0; ii < edcAchievementCount; ii++) {
					var target2: Array = this["edcAchievement" + (ii + 1)] as Array;
					edc.push(target2);
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