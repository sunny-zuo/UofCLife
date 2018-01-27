package {
	import flash.net.SharedObject;
	
	public class AchievementHandler {

		public var achievementData: SharedObject = SharedObject.getLocal("ls92ud31");
		/* Properties of the sharedObject:
		  numComplete: number of achievements that have been complete
		  numAchievements: number of achievements total
		  buildingList: list of buildings
		  <buildingName>: list of achievements in those buildings, in array format [title, description, art, achieved]
		*/

		private var buildingList: Array = new Array();
		private var edc: Array = new Array();


		public function AchievementHandler() {
			// constructor code
			init();
		}
		private function init() {
			if (achievementData.data.numComplete == null) {
				achievementData.data.numComplete = 0; //sets the number complete to zero if it doesn't exist yet
			}

			buildingList = [edc]
			achievementData.data.buildingList = buildingList;

			addEdcAchievements();
			achievementData.data.edc = edc;

			achievementData.flush(); //"commits" the data to disk


		}

		private function addEdcAchievements(): void {
			edc.push(["Quiz Novice", "Beat the geography quiz", null, false]);
		}
		
		public function completeAchievement(building: String, achievementName: String) {
			var target:Array = this[building] as Array; //uses the building name to target an array
			for (var i = 0; i < target.length; i++) {
				if (target[i][0] == achievementName) {
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