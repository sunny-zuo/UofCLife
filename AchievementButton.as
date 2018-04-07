package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class AchievementButton extends MovieClip {
		public function AchievementButton() {
			// constructor code
			init();
		}
		private function init(): void {
			this.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(event: MouseEvent): void {
			if (Main.instance.inventory.inventoryOpen == true) {
				Main.instance.inventory.inventoryOpen = false;
				Main.instance.inventory.closeInventory();
			}
			if (Main.instance.achievementFront.displayOpen) {
				Main.instance.achievementFront.closeAchievementDisplay();
				Main.instance.achievementFront.displayOpen = false;
			}
			else if (!Main.instance.achievementFront.displayOpen) {
				Main.instance.achievementFront.x = 480;
				Main.instance.achievementFront.y = 240;
				Main.instance.achievementFront.openAchievementDisplay();
				Main.instance.achievementFront.displayOpen = true;
			}
		}

	}

}