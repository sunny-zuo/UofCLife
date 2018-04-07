package  
{
	//import flash.display.graphics;
	import flash.display.Sprite;
	public class Shop extends Box
	{
		private var title:String;
		private var soldItems:Array;
		private var itemCost:Array;
		private var buttonList:Array;
		
		public function Shop(title:String, soldItems:Array, itemCost:Array) 
		{
			// constructor code
			this.title=title;
			this.soldItems=soldItems;
			this.itemCost=itemCost;
			super()
			init()
		}
		private function init()
		{
			buttonList=new Array();
			for(var i:int=0; i<soldItems.length; i++)
			{
				var tempButton:Sprite=new Sprite();
				tempButton.graphics.beginFill(0);
				tempButton.graphics.drawRoundRect(0,0, 200, 30, 10)
				tempButton.graphics.beginFill(0xcccccc);
				tempButton.graphics.drawRoundRect(2.5,2.5, 195, 25, 10);
				tempButton.graphics.endFill();
				tempButton.x=10;
				tempButton.y=i*35+40;
				tempButton.buttonMode=true;
				
				//tempButton.addEventListener(MouseEvent.CLICK, buyItem);
				this.addChild(tempButton);
				buttonList[i]=tempButton;
			}
		}

	}
	
}
