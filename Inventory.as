package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Inventory extends MovieClip
	{
		public var inventory:Array; //The actual array that holds all the players items.
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
			//trace(Main.instance, Main.instance.inventory);
			this.x=0;
			this.y=0;
			Main.instance.menuContainer.addChild(inventoryButton);
		}

		//Starts the inventory GUI script
		public function startGUI()
		{
			inventoryGUI=new InventoryGUI();
		}
		
		//Opens the inventory upon clicking the inventory button (if it is already closed)
		public function openInventory()
		{
			Main.instance.menuContainer.addChild(inventoryGUI);
			inventoryGUI.updateGUI();
		}

		//Closes the inventory upon clicking the inventory button (if it is already open)
		public function closeInventory()
		{
			//trace('close*2');
			Main.instance.menuContainer.removeChild(inventoryGUI);
			inventoryGUI.closeGUI();
		}
	}

}