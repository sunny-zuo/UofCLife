package  
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import Controllers.TextController;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class InventoryGUI extends MovieClip
	{
		private var itemHolder:Array=new Array();
		private var loader:Loader = new Loader();
		private var itemText:TextField
		private var bitmap:Bitmap;
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
			for(var j:int=0; j<Main.instance.inventory.inventory.length; j++)
			{
				itemText=new TextField();
				itemText.defaultTextFormat=TextController.newTextFormat(10,0,"Arial","left");
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
		public function updateGUI()
		{
			for(var i:int=0; i<Main.instance.inventory.inventory.length; i++)
			{
				if(Main.instance.inventory.inventory[i]!=null)
				{
					var spriteSRC:String=ItemList[Main.instance.inventory.inventory[i][0]][2]
					loader.load(new URLRequest(spriteSRC));
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
					//trace(loader.content.filters);
					itemHolder[i].getChildAt(itemText).text=Main.instance.inventory.inventory[i][1]
					
					var sprite=bitmap;
					//trace(sprite)
					
					sprite.x=(20)+(i*50+i*20);
					sprite.y=20;
					this.addChild(sprite);
				}
			}
		}
		private function onComplete(event:Event)
		{
			bitmap = event.target.content;
			if(bitmap != null){
				bitmap.smoothing = true;
			}
		}		

	}
	
}
