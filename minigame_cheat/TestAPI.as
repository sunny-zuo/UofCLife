﻿package  {
	
	public class TestAPI {
		
		public var loadedData:Object;
		public var loadDone:Boolean = false;
		
		public function TestAPI() {
			// constructor code
		}
		public function fetchQuestions(questionCount: int, subject: String, difficulty: String, qType: String = "multiple") {
			var subjectID: int; //int for storing the subject ID. converted from string to actual ID here for better readability
			
			//Generates the URL to pull from, as it will need to change based on what we want
			var apiURL: String = "https://opentdb.com/api.php?amount=" + questionCount + "&category=" + 9/*subjectID*/ + "&difficulty=" + difficulty + "&type=" + qType

			//URL Loader
			var urlRequest: URLRequest = new URLRequest(apiURL); //creates a URLRequest with the url generated above
			var urlLoader: URLLoader = new URLLoader(); //creates a URLLoader
			urlLoader.addEventListener(Event.COMPLETE, loadComplete) //adds an event listener to trigger when it's loaded

			try {
				urlLoader.load(urlRequest); //tries to load from the URL
			} catch (error: Error) {
				trace("load error " + error); //if there's an error, will trace it
			}
		}

		private function loadComplete(event: Event): void {
			var loader: URLLoader = URLLoader(event.target); //sets the URLLoader to the one generated above
			loadDone = true;
			//trace(loader.data, JSON.parse(loader.data));
			loadedData = JSON.parse(loader.data) //makes the data a public variable so it can accessed by other classes
			/* Access data using loadedData.results[0].question where 0 is the question number, and "question" is the specific data you want.
			more examples: loadedData.results[0].correct_answer gives the correct answer to the first question */
			
		}
	}
	
}