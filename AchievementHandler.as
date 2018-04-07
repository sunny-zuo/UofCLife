package {
	import flash.net.SharedObject;

	public class AchievementHandler {

		public var achievementData: SharedObject = SharedObject.getLocal(Main.sharedObjectName); //shared object name is a static in Main
		/* Properties of the sharedObject:
		  numComplete: number of achievements that have been complete
		  numAchievements: number of achievements total
		  buildingList: list of buildings
		  <buildingName>: list of achievements in those buildings, in array format [title, description, art, achieved]
		*/

		private var buildingList: Array = new Array();
		private var edc: Array = null;

		private var totalAchievementCount: int = 4; //number of achievements total, please update as more are added, else the % complete breaks

		//EDC ACHIEVEMENTS
		private var edcAchievementCount: int = 4; //number of achievements in the edc building. please update as more are added, else things break
		//Format: [title, description, art, achieved boolean]
		private var edcAchievement1: Array = ["Quiz Novice", "Beat the geography quiz once", null, false];
		private var edcAchievement2: Array = ["Quiz Pro", "Beat the geography quiz twice", null, false];
		private var edcAchievement3: Array = ["Quiz Expert", "Beat the geography quiz thrice", null, false];
		private var edcAchievement4: Array = ["Quiz Master", "Beat the geography quiz for the fourth time", null, false];

		//END EDC ACHIEVEMENTS

		public function AchievementHandler() {
			// constructor code
			init();
		}
		private function init() {
			achievementData.data.numAchievements = totalAchievementCount; // sets the shared object to reflect the correct total achievement count
			if (achievementData.data.numComplete == null) {
				achievementData.data.numComplete = 0; // sets the number complete to zero if it doesn't exist yet
			}

			buildingList = ["edc"] //list of buildings
			achievementData.data.buildingList = buildingList; // sets the list of buildings into the shared object

			addEdcAchievements(); //add the edc achievements into the saved object
		}

		private function addEdcAchievements(): void {
			edc = null;
			edc = new Array();
			if (achievementData.data.hasOwnProperty("edc")) { // if there is already achievement data in the shared object
				for (var j: int = 0; j < edcAchievementCount; j++) { // go through each achievement, and add it to a new array
					var target2: Array = this["edcAchievement" + (j + 1)] as Array; // targets each achievement number, up to total number of achievements
					var tempArray: Array = achievementData.data.edc
					if (tempArray[j][3]) { //if the achievement was already completed, mark it as such
						target2[3] = true;
					}
					edc.push(target2);
				}

			} else { //if there is no achievement data, aka new player
				for (var i: int = 0; i < edcAchievementCount; i++) { //go through each achievement and add it
					var target: Array = this["edcAchievement" + (i + 1)] as Array;
					edc.push(target);
				}
			}

			achievementData.data.edc = edc; //sets the shared object info to whatever what just generated above
			achievementData.flush(); //"commits" the data to disk

		}

		public function completeAchievement(building: String, achievementName: String) {
			var target: Array = this[building] as Array; //uses the building name to target an array
			for (var i = 0; i < target.length; i++) {
				if (target[i][0] == achievementName && target[i][3] == false) {
					target[i][3] = true;
					achievementData.data.edc = edc; //sets the shared object edc data to the new edc data
					//if a new building is added, the above line must be done for that building as well
					achievementData.data.numComplete += 1; //increases the number complete
					achievementData.flush(); //saves the data to disk

					var achievementComplete: AchievementComplete = new AchievementComplete(achievementName);
					achievementComplete.x = 780.7;
					achievementComplete.y = 42.95;
					Main.instance.menuContainer.addChild(achievementComplete);

					return;
				}
			}

		}

	}

}