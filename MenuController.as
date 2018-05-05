package  {
	import flash.display.MovieClip;
	public class MenuController {
		public static var currentPopup:MovieClip;
		//current existing popup
		
		public function MenuController() {
			// constructor code
		}
		
		public static function generateDecisionBox(yes:Function, yesParams:Array, no:Function, noParams:Array, applyTarget:Object):void{
			/*
			PARAMETERS:
			yes = function to be called when yes is selected
			yesParams = function parameters of yes
			no = function to be called when no is selected
			noParams = function parameters of no
			applyTarget = object the functions are called upon
			DO:
			Creates a decision box inside the menuContainer.
			*/
			var tempDecisionBox:DecisionBox = new DecisionBox(yes, yesParams, no, noParams, applyTarget);
			
			tempDecisionBox.x = Main.stg.stageWidth/2;
			tempDecisionBox.y = Main.stg.stageHeight/2;
			//centers the decision box
			
			destroyPopup();
			
			currentPopup = tempDecisionBox;
			//set new popup to this new one
			
			Main.instance.menuContainer.addChild(tempDecisionBox);
		}
		

		public static function generateShop(title:String="Shop", soldItems:Array=null, itemCost:Array=null):void
		{
			/*
			PARAMETERS:
			title: A string to appear at the the top of the shop that is the name of the shop (Example: Bento Sushi)
			soldItems: An array of items sold in the shop
			itemCost: An array of the cost of each items sold in the shop (Must have 1 to 1 corispondance with soldItems)
			DO:
			Creates a generic shop GUI.
			*/
			if(soldItems==null)
			{
				soldItems=new Array();
				soldItems.push('_2');
			}
			if(itemCost==null)
			{
				itemCost=new Array();
				itemCost.push(5);
			}
			var tempShopBox:Shop=new Shop(title, soldItems, itemCost);
			tempShopBox.x=0.25*Main.stg.stageWidth;
			tempShopBox.y=0.25* Main.stg.stageHeight;
			
			destroyPopup();
			currentPopup = tempShopBox;
			Main.instance.menuContainer.addChild(tempShopBox);
		}
		
		public static function generateQuizPopUp(questionCount:int, topic:String, difficulty:String, thinkTime:int = 15, qType:String = "multiple", passingGrade:Number = 80, achievementToGrant:Array = null, pass:Function = null, passParams:Array = null, fail:Function = null, failParams:Array = null, applyTarget:Object = null):void{

			/*
			PARAMETERS:
			?????? Refer to the class
			DO:
			Creates a quiz pop up inside the menuContainer.
			*/
			var tempQuizPopUp:QuizPopup = new QuizPopup(questionCount, topic, difficulty, thinkTime, qType, passingGrade, achievementToGrant, pass, passParams, fail, failParams);
			
			tempQuizPopUp.x = Main.stg.stageWidth/2;
			tempQuizPopUp.y = Main.stg.stageHeight/2;
			//centers the quiz box
		
			destroyPopup();
			
			currentPopup = tempQuizPopUp;
			//set new popup to this new one
			
			Main.instance.menuContainer.addChild(tempQuizPopUp);
		}
		
		public static function generateConfessionPopup():void{
			/*
			PARAMETERS:
			?????? Refer to the class
			DO:
			Creates a confession pop up inside the menuContainer.
			*/
			
			var tempConfessionsPopup:ConfessionPopup = new ConfessionPopup();
			
			tempConfessionsPopup.x = Main.stg.stageWidth/2;
			tempConfessionsPopup.y = Main.stg.stageHeight/2;
			//centers the quiz box
			
			destroyPopup();
			
			currentPopup = tempConfessionsPopup;
			//set new popup to this new one
			
			Main.instance.menuContainer.addChild(tempConfessionsPopup);
		}
		
		private static function destroyPopup():void{
			if(currentPopup && currentPopup is DecisionBox){
				//if a popup exists currently
				//currentPopup.closePopup();
				//close existing popup
				
				currentPopup = null;
				//set popup to no more, so it does not exist anymore
			}
		}
	}
	
}
