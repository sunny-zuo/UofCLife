package  {
	
	public class MenuController {

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
			
			Main.instance.menuContainer.addChild(tempDecisionBox);
		}
		
		public static function generateQuizPopUp(questionCount:int, topic:String, difficulty:String, thinkTime:int = 15, qType:String = "multiple", passingGrade:Number = 80, pass:Function = null, passParams:Array = null, fail:Function = null, failParams:Array = null, applyTarget:Object = null):void{
			/*
			PARAMETERS:
			?????? Refer to the class
			DO:
			Creates a quiz pop up inside the menuContainer.
			*/
			var tempQuizPopUp:QuizPopup = new QuizPopup(questionCount, topic, difficulty, thinkTime, qType, passingGrade, pass, passParams, fail, failParams, applyTarget);
			
			tempQuizPopUp.x = Main.stg.stageWidth/2;
			tempQuizPopUp.y = Main.stg.stageHeight/2;
			//centers the quiz box
			
			Main.instance.menuContainer.addChild(tempQuizPopUp);
		}

	}
	
}
