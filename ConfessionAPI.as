package  {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class ConfessionAPI {
		public var loadedData:Object;
		public var loadDone:Boolean = false;
		public function ConfessionAPI() {
			// constructor code
		}
		
		public function fetchConfessions(){
			//THIS SHOULD BE SECRET
			//https://graph.facebook.com/oauth/access_token?client_id=147480742557060&client_secret=7df2b675aa1d9f11298e122bb8abd93d&grant_type=client_credentials
			//															^App ID						^App Secret
			var apiURL:String = "https://graph.facebook.com/431651536911675/posts?access_token=2093241067576871|d79944d2ed7466b7ebb349b1bff45193";
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
		
		private function loadComplete(event:Event):void{
			var loader: URLLoader = URLLoader(event.target); //sets the URLLoader to the one generated above
			loadDone = true;
			//trace(loader.data, JSON.parse(loader.data));
			loadedData = JSON.parse(loader.data) //makes the data a public variable so it can accessed by other classes
			/* Access data using loadedData.results[0].question where 0 is the question number, and "question" is the specific data you want.
			more examples: loadedData.results[0].correct_answer gives the correct answer to the first question */
		}

	}
	
}
