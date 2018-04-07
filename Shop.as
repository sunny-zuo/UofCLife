package  
{
	import flash.display.MovieClip;
	//simport flash.display.graphics;
	import flash.display.Sprite;
	public class Shop extends MovieClip
	{
		private var title:String;
		private var soldItems:Array;
		private var itemCost:Array;
		private var rect:Sprite;
		private var exitButton:Sprite;
		public function Shop(title:String, soldItems:Array, itemCost:Array) 
		{
			// constructor code
			this.title=title;
			this.soldItems=soldItems;
			this.itemCost=itemCost;
			init();
		}
		private function init()
		{
			//Initialization
			rect=new Sprite();
			rect.graphics.beginFill(0x00000);
			rect.graphics.drawRoundRect(-5,-5,0.50*Main.stg.stageWidth+10,0.5* Main.stg.stageHeight+10,30);
			rect.graphics.beginFill(0xaaaaaa);
			rect.graphics.drawRoundRect(0,0,0.50*Main.stg.stageWidth,0.5* Main.stg.stageHeight, 30);
			rect.graphics.endFill();
			this.addChild(rect);
			
			exitButton=new Sprite()
			rect.graphics.beginFill(0xff0000);
			rect.graphics.drawRoundRect(10,10,25,25,5);
		}

	}
	
}
