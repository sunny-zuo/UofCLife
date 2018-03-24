package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Inventory extends MovieClip
	{
		public var inventory:Array;
		public var inventoryOpen:Boolean=false;
		private var inventoryButton:MenuButton;
		private var inventoryGUI:InventoryGUI;
		
		public function Inventory()
		{
			init()
		}
		
		private function init()
		{
			inventory=new Array()
			inventoryButton=new MenuButton();
			inventoryButton.x=10;
			inventoryButton.y=10;
			inventoryGUI=new InventoryGUI();
			this.x=0;
			this.y=0;
			Main.instance.menuContainer.addChild(inventoryButton);
		}
		
		public function openInventory()
		{
			Main.instance.menuContainer.addChild(inventoryGUI);
		}
		public function closeInventory()
		{
			trace('close*2');
			Main.instance.menuContainer.removeChild(inventoryGUI);
		}
	}

}