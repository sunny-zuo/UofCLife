package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class InventoryButton extends MovieClip {
		
		private var achievementFront:AchievementFront = new AchievementFront;
		
		public function InventoryButton() {
			// constructor code
			init();
		}
		private function init(): void {
			this.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(event: MouseEvent): void {
			if (Main.instance.inventory.inventoryOpen == false) {
				Main.instance.inventory.inventoryOpen = true;
				Main.instance.inventory.openInventory();
				
				if (Main.instance.achievementFront.displayOpen) {
					Main.instance.achievementFront.closeAchievementDisplay();
				}
			}
			else if (Main.instance.inventory.inventoryOpen == true) {
				Main.instance.inventory.inventoryOpen = false;
				Main.instance.inventory.closeInventory();
			}
		}

	}

}