package
{
	import flash.display.MovieClip;
	
	public class Inventory extends MovieClip
		public var inventory:Array;
		private var inventoryButton:MenuButton;
		
		public function Inventory()
		{
			init()
		}
		
		private function init()
		{
			trace('inventory init');
			inventory=new Array()
			inventoryButton=new MenuButton();
			inventoryButton.x=10;
			inventoryButton.y=10;
			Main.instance.menuContainer.addChild(inventoryButton);
		}
		
		public function openInventory()
		{
			
		}
	}
}