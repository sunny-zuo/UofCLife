package  
{
	import flash.display.MovieClip;
	public class InventoryGUI extends MovieClip
	{
		public var inventoryArray:Array=new Array();
		private var itemHolder:Array=new Array();
		public function InventoryGUI() 
		{
			// constructor code
			init();
		}
		
		private function init()
		{
			for(var i:int=0; i<3; i++)
			{
				inventoryArray[i]=null;
			}
			trace(inventoryArray);
			this.graphics.beginFill(0xaaaaaa);
			this.graphics.drawRect(0, 0, 0.8*Main.stg.stageWidth, 0.8*Main.stg.stageHeight);
			this.graphics.endFill();
			this.x=0.1*Main.stg.stageWidth;
			this.y=0.1*Main.stg.stageHeight;
			for(var i:int=0; i<inventoryArray.length; i++)
			{
				var tempItem:MovieClip=new MovieClip();
				tempItem.graphics.beginFill(0xeeeeee);
				tempItem.graphics.drawRect((10)+(i*50+i*10), 10, 50,50);
				tempItem.graphics.endFill();
				this.addChild(tempItem);
				itemHolder.push(tempItem);
			}
		}

	}
	
}
