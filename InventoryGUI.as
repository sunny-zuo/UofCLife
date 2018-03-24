package  
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	
	public class InventoryGUI extends MovieClip
	{
		private var itemHolder:Array=new Array();
		private var loader:Loader = new Loader();
		
		public function InventoryGUI() 
		{
			// constructor code
			init();
		}
		
		private function init()
		{
			trace(Main.instance.inventory);
			for(var i:int=0; i<3; i++)
			{
				Main.instance.inventory.inventory[i]=null;
			}
			
			this.graphics.beginFill(0xaaaaaa);
			this.graphics.drawRect(0, 0, 0.8*Main.stg.stageWidth, 0.8*Main.stg.stageHeight);
			this.graphics.endFill();
			this.x=0.1*Main.stg.stageWidth;
			this.y=0.1*Main.stg.stageHeight;
			for(var j:int=0; j<Main.instance.inventory.inventory.length; j++)
			{
				var tempItem:MovieClip=new MovieClip();
				tempItem.graphics.beginFill(0xeeeeee);
				tempItem.graphics.drawRect((10)+(j*50+j*10), 10, 50,50);
				tempItem.graphics.endFill();
				this.addChild(tempItem);
				itemHolder.push(tempItem);
			}
		}
		public function updateGUI()
		{
			
		}

	}
	
}
