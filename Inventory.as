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
			init();
		}
		
		private function init()
		{
			//creates and populates the empty inventory
			inventory=new Array();
			for(var i:int=0; i<12; i++)
			{
				inventory[i]=null;
			}

			//sets up basics for the GUI
			inventoryButton=new MenuButton();
			inventoryButton.x=10;
			inventoryButton.y=10;
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

		//A function to add Items to the inventory.
		public function addItem(item:String, amount:int=1)
		{
			var itemCheck:Array=checkInventory(item);
			if(itemCheck[0]==true)
			{
				inventory[itemCheck[1]][1]+=amount;
			}
			else if(itemCheck[0]==false)
			{
				for(var i:int=0; i<inventory.length; i++)
				{
					if(inventory[i]==null)
					{
						inventory[i]=[item, amount];
						i=inventory.length;
					}
				}
			} 
		}

		//A function to remove Items from the inventory
		public function removeItem(item:String, amount:int=1):Boolean
		{
			var itemCheck:Array=checkInventory(item);
			if(!itemCheck[0])
			{
				return false;
			}
			else if(itemCheck[0])
			{
				if(inventory[itemCheck[1]][1]>=amount)
				{
					inventory[itemCheck[1]][1]-=amount;
					
					if(inventory[itemCheck[1]][1]==amount)
					{
						inventory[itemCheck[1]]=null;
					}
					return true;
				}
				else if(inventory[itemCheck[1]][1<amount])
				{
					return false;
				}
			}
			else
			{
				return false;
			}
			return false;
		}

		private function checkInventory(item:String):Array
		{
			/*
			Parameters
			item= String form of the item ID
			DO:
			The fucntion checks the inventory for a specific item and where in the inventory that item is in the array.
			RETERNS Array
			The 0th index of the return array is a boolean value to determin wheather the item is in the inventory (true if it is, false if not)
			The 1st index of the return array is a int which is the location of the item in the inventory (if true) or null (if false)
			*/
			for(var i:int=0; i<inventory.length; i++)
			{
				
				if(inventory[i]!=null)
				{
					
					if(inventory[i][0]==item)
					{
						return [true, i];
						i=inventory.length;
					}
				}
				
			}
			return [false, null];
		}
	}

}