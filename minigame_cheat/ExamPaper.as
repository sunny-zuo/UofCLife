package minigame_cheat {
	import flash.display.MovieClip;
	public class ExamPaper extends MovieClip{
		
		public function ExamPaper(loadedData:Object, examinee:Examinee) {
			var rn:Number = Math.random()*100;
			if(rn < examinee.iq){
				txt_a1.text = loadedData.results[0].correct_answer;
			}else{
				txt_a1.text = loadedData.results[0].incorrect_answer[int(Math.random()*2)];
			}
			rn = Math.random()*100;
			if(rn < examinee.iq){
				txt_a2.text = loadedData.results[0].correct_answer;
			}else{
				txt_a2.text = loadedData.results[0].incorrect_answer[int(Math.random()*2)];
			}
			rn = Math.random()*100;
			if(rn < examinee.iq){
				txt_a3.text = loadedData.results[0].correct_answer;
			}else{
				txt_a3.text = loadedData.results[0].incorrect_answer[int(Math.random()*2)];
			}
		}
		

	}
	
}
