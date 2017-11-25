package  {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class QuestionAPI {

		public function QuestionAPI() {
			// constructor code
		}
		
		static function fetchQuestions(questionCount:int, subject:String, difficulty:String, qType:String = "multiple") {
			var subjectID:int; //int for storing the subject ID. converted from string to actual ID here for better readability
			if (subject == "Geography") { //if the subject is geography, give it it's subjectID
				subjectID = 22;
			}
			else {
				subjectID = 0; //if given something incorrect, change to general category
			}
			//Generates the URL to pull from, as it will need to change based on what we want
			var apiURL:String = "https://opentdb.com/api.php?amount=" + questionCount + "&category=" + subjectID + "&difficulty=" + difficulty + "&type=" + qType
			
			//URL Loader
			var urlRequest:URLRequest = new URLRequest(apiURL); //creates a URLRequest with the url generated above
			var urlLoader:URLLoader = new URLLoader(); //creates a URLLoader
			urlLoader.addEventListener(Event.COMPLETE, loadComplete) //adds an event listener to trigger when it's loaded
			
			try {
				urlLoader.load(urlRequest); //tries to load from the URL
			} catch (error:Error) {
				trace("load error " + error); //if there's an error, will trace it
			}
		}
		
		static function loadComplete (event:Event):void {
			var loader:URLLoader = URLLoader(event.target); //sets the URLLoader to the one generated above
			var data:Object = JSON.parse(loader.data); //parses the JSON received
			/* Example use of data: data.0.question will gave the first question (number 0)
			data.0.correct_answer gives the correct answer of the first question
			data.0.incorrect_answer.0 gives the first incorrect answer of the first question
			*/
		}

	}
	
}
