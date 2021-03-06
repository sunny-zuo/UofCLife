﻿package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class QuizEnding extends MovieClip {

		private var questionsCorrect: int;
		private var questionsIncorrect: int;
		private var passingPercentage: int;
		private var obtainedPercentage: int;
		private var result: Boolean;
		private var pass: Function;
		private var passParams: Array;
		private var fail: Function;
		private var failParams: Array;
		private var applyTarget: Object;
		private var achievementToGrant: Array;

		public var readyToClose: Boolean = false;

		private var achievementFront: AchievementFront = new AchievementFront;

		public function QuizEnding(questionsCorrect: int, questionsIncorrect: int, passingPercentage: Number, achievementToGrant: Array = null, pass: Function = null, passParams: Array = null, fail: Function = null, failParams: Array = null, applyTarget: Object = null) {
			// constructor code
			this.questionsCorrect = questionsCorrect;
			this.questionsIncorrect = questionsIncorrect;
			this.passingPercentage = passingPercentage;
			this.achievementToGrant = achievementToGrant;

			this.pass = pass;
			this.passParams = passParams;
			this.fail = fail;
			this.failParams = failParams;
			this.applyTarget = applyTarget;

			obtainedPercentage = (questionsCorrect / (questionsCorrect + questionsIncorrect)) * 100; //calculates the percentage the player gets
			init();
		}

		private function init(): void {
			this.quizPercentage.text = "You scored " + obtainedPercentage + "%";
			if (obtainedPercentage >= passingPercentage) {
				this.quizResult.text = "Congrats, you passed the quiz!";
				result = true;
				if (achievementToGrant != null) {
					achievementFront.grantAchievement(achievementToGrant[0], achievementToGrant[1]);
				}
			} else {
				this.quizResult.text = "You failed!";
				result = false;
			}
			exit_btn.addEventListener(MouseEvent.CLICK, closeQuiz);
		}

		private function closeQuiz(event: MouseEvent) {
			if (result == true && pass != null) {
				applyTarget.call(pass, passParams);
			}
			if (result == false && fail != null) {
				applyTarget.call(fail, failParams)
			}
			readyToClose = true;
		}

	}

}