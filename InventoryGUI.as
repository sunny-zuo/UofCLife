package  
{
	import flash.display.MovieClip;
	public class InventoryGUI extends MovieClip
	{

		public function InventoryGUI() 
		{
			// constructor code
			init();
		}
		
		private function init()
		{
			this.graphics.beginFill(0xaaaaaa);
			this.graphics.drawRect(0, 0, 0.8*Main.stg.stageWidth, 0.8*Main.stg.stageHeight);
			this.graphics.endFill();
			this.x=0.1*Main.stg.stageWidth;
			this.y=0.1*Main.stg.stageHeight;
		}

	}
	
}
