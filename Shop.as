package  
{
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.text.TextField;
	public class Shop extends Box
	{
		private var title:String;
		private var soldItems:Array;
		private var itemCost:Array;
		private var buttonList:Array;
		private var textFormat:TextFormat;
		private var titleText:TextField=new TextField;
		private var subText:TextField=new TextField;
		
		
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
			//trace(title);
			textFormat=new TextFormat();
			textFormat.size=20;
			textFormat.font='Comic Sans MS';
			textFormat.align='center';
			titleText.defaultTextFormat=textFormat;
			titleText.text=title;
			titleText.width=this.width-70;
			titleText.x=this.width/2-titleText.width/2
			titleText.y=10;
			titleText.selectable=false;
			subText.defaultTextFormat=textFormat;
			subText.text=title;
			subText.x=0
			subText.width=this.width;
			subText.y=this.height-50
			
			subText.selectable=false;
			this.addChild(titleText);
			this.addChild(subText);
			buttonList=new Array();
			for(var i:int=0; i<soldItems.length; i++)
			{
				var tempButton:MovieClip=new MovieClip();
				var tempText:TextField=new TextField()
				
				textFormat.color=0x333333;
				tempText.defaultTextFormat=textFormat;
				tempText.selectable=false;
				//trace(ItemList)
				//trace(ItemList[soldItems[i]]);
				tempText.text=ItemList[soldItems[i]][1]+": $"+ itemCost[i].toString();
				tempText.x=1;
				tempText.y=1;
				
				tempButton.graphics.beginFill(0);
				tempButton.graphics.drawRoundRect(0,0, 200, 30, 10)
				tempButton.graphics.beginFill(0xcccccc);
				tempButton.graphics.drawRoundRect(2.5,2.5, 195, 25, 10);
				tempButton.graphics.endFill();
				tempButton.x=10;
				tempButton.y=i*35+40;
				tempButton._item=soldItems[i];
				tempButton._cost=itemCost[i]
				tempButton.addChild(tempText);
				tempButton.buttonMode=true;
				tempButton.addEventListener(MouseEvent.CLICK, buyItem);
				this.addChild(tempButton);
				buttonList[i]=tempButton;
			}
		}
		private function buyItem(event:MouseEvent)
		{
			/*
			PARAMETERS:
			event: The mouse event from clicking the buy button in the shop
			DO:
			Checks if the player has enough money to buy the item and removes that much money
			Adds 1 of the item that the player has bought
			RETURNS:
			Nothing
			*/
			var cost=event.target._cost;
			var item=event.target._item;
			if(Main.instance.inventory.removeItem('_1', cost))
			{
				Main.instance.inventory.addItem(item,1);
				subText.text="You bought 1 "+ItemList[item][1]
			}
			else
			{
				subText.text="Transaction Failed"
			}
		}
	}
}
