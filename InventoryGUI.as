package  
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Controllers.TextController;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.net.URLRequest;
	
	public class InventoryGUI extends MovieClip
	{
		private var itemHolder:Array=new Array();
		
		private var itemText:TextField
		public function InventoryGUI() 
		{
			// constructor code
			init();
		}
		
		private function init()
		{
			//trace(Main.instance.inventory);
			for(var i:int=0; i<12; i++)
			{
				Main.instance.inventory.inventory[i]=null;
			}
			
			this.graphics.beginFill(0xaaaaaa);
			this.graphics.drawRect(0, 0, 0.8*Main.stg.stageWidth, 0.8*Main.stg.stageHeight);
			this.graphics.endFill();
			this.x=0.1*Main.stg.stageWidth;
			this.y=0.1*Main.stg.stageHeight;

			//Creates the inventory GUI array which holds all the item pictures for the GUI
			for(var j:int=0; j<Main.instance.inventory.inventory.length; j++)
			{
				itemText=new TextField();
				itemText.defaultTextFormat=TextController.newTextFormat(10,0x0000ff,"Arial","left");
				itemText.x=(10)+(j*50+j*10);
				itemText.y=10;
				itemText.text='';
				itemText.width=50;
				
				var tempItem:MovieClip=new MovieClip();
				tempItem.graphics.beginFill(0xeeeeee);
				tempItem.graphics.drawRect((10)+(j*50+j*10), 10, 50,50);
				tempItem.graphics.endFill();
				this.addChild(tempItem);
				
				tempItem.addChild(itemText);
				itemHolder.push(tempItem);
			}
		}

		//Updates the inventory GUI upon opening the inventory
		public function updateGUI()
		{
			for(var i:int=0; i<Main.instance.inventory.inventory.length; i++)
			{
				if(Main.instance.inventory.inventory[i]!=null)
				{
					var loader:Loader = new Loader();
					var spriteSRC=ItemList[Main.instance.inventory.inventory[i][0]][2]
					loader.load(new URLRequest(spriteSRC));
					var sprite:DisplayObject=addChild(loader);
					sprite.x=(10)+(i*50+i*10);
					sprite.y=10;
					itemHolder[i].addChild(sprite);
					
					itemHolder[i].getChildAt(itemText).text=Main.instance.inventory.inventory[i][1];
					itemHolder[i].setChildIndex(itemHolder[i].getChildAt(itemText), itemHolder[i].numChildren-1);
				}
			}
		}

		//closes the GUI upon closing the inventory
		public function closeGUI()
		{
			for(var i:int=0; i<Main.instance.inventory.inventory.length; i++)
			{
				if(Main.instance.inventory.inventory[i]!=null)
				{
					for(var j:int=0; j<itemHolder[i].numChildren; j++)
					{
						if(itemHolder[i].getChildAt(j)!=itemText)
						{
							itemHolder[i].removeChild(itemHolder[i].getChildAt(j));
						}
					}
				}
			}
		}

	}
	
}
