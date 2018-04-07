package  
{
	
	public class Shop extends Box
	{
		private var title:String;
		private var soldItems:Array;
		private var itemCost:Array;
		public function Shop(title:String, soldItems:Array, itemCost:Array) 
		{
			// constructor code
			this.title=title;
			this.soldItems=soldItems;
			this.itemCost=itemCost;
			super()
		}

	}
	
}
