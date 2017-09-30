package {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class EducationBuilding extends MovieClip {
		
		public function EducationBuilding() {
			// constructor code
			init()
		}

		private function init(): void {
			EnterRoomSymbol()
		}

		//Returns room symbol
		public function EnterRoomSymbol(): MovieClip {
			var enterSymbol = new EnterSymbol();
			return enterSymbol;
		}
	}
}