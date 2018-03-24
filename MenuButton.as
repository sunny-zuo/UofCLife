package  {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	
	public class MenuButton extends SimpleButton {
		
		
		public function MenuButton() {
			// constructor code
			this.addEventListener(MouseEvent.CLICK, onClick)
		}
		private function onClick(event:MouseEvent):void 
		{
			if (Main.instance.inventory.inventoryOpen==false)
			{
				trace('open');
				Main.instance.inventory.inventoryOpen=true;
				Main.instance.inventory.openInventory();
			}
			else if (Main.instance.inventory.inventoryOpen==true)
			{
				trace('close');
				Main.instance.inventory.inventoryOpen=false;
				Main.instance.inventory.closeInventory();
			}
		}
	}
	
}
