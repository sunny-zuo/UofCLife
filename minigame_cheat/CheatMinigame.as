package minigame_cheat {
	import flash.events.Event;
	import flash.display.MovieClip;
	
	import Controllers.TextController;
	
	public class CheatMinigame extends MovieClip{
		private var testAPI:QuestionAPI;
		private var loadedData:Object;
		public function CheatMinigame(){
			drawBackground();
			
			testAPI = new QuestionAPI();
			testAPI.fetchQuestions(3, "General Knowledge", "hard", "multiple");
			addEventListener(Event.ENTER_FRAME, waitForLoad);
		}
		private function waitForLoad(event: Event): void {
			if (testAPI.loadDone) { //waits for the data to be grabbed
				loadedData = testAPI.loadedData; //grabs loaded data from questionAPI
				
				//Others Paper
				var examinee1:Examinee = new Examinee("John", 80);
				var examinee2:Examinee = new Examinee("Diego", 68);
				var examinee3:Examinee = new Examinee("Nincompoop", 33);
				
				var myPaper:PlayerPaper = new PlayerPaper(loadedData);
				myPaper.x = width/2;
				myPaper.y = height/2;
				
				/*var paper1:ExamPaper = new ExamPaper(loadedData, examinee1);
				var paper2:ExamPaper = new ExamPaper(loadedData, examinee2);
				var paper3:ExamPaper = new ExamPaper(loadedData, examinee3);*/
				
				addChild(myPaper);
				
				
				removeEventListener(Event.ENTER_FRAME, waitForLoad); //removes the event listener as this function is no longer needed
			}
			
			
		}
		private function drawBackground():void{
			graphics.beginFill(0xffffff);
			graphics.drawRect(0, 0, Main.stg.stageWidth, Main.stg.stageHeight);
			graphics.endFill();
		}

	}
	
}
