package  {
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import Controllers.TextController;
	
	public class ConfessionPopup extends MovieClip {
		private var confessionAPI:ConfessionAPI = new ConfessionAPI();
		//generates confessions
		
		private var scaleAssist:DeltaAssist;
		private var alphaAssist:DeltaAssist;
		
		private var loadedData:Object;
		
		private var lastConfession:int = -1;
		//no last confession (no confession has index of -1)
		
		public function ConfessionPopup() {
			alpha = 0;
			scaleX = 0.8;
			scaleY = 0.8;
			
			scaleAssist = new DeltaAssist(this, ["scaleX", "scaleY"]);
			alphaAssist = new DeltaAssist(this, ["alpha"]);
			
			scaleAssist.setLinear(0.02, 1);
			alphaAssist.setLinear(0.2, 1, activateButtons);
			//pop up animation
			
			Main.instance.character.allowCharMove = false;
			//don't let character move while this menu is on		
			
			init();
		}
		
		private function init():void{
			confessionAPI.fetchConfessions(); //runs the fetchConfessions function which gets the confessions
			
			//btn_next.addEventListener(MouseEvent.CLICK, refreshConfession);
			//event listener for a click to refresh for a new confession
			
			btn_close.txt_display.text = "Close";
			
			addEventListener(Event.ENTER_FRAME, waitForLoad);
		}
		
		private function waitForLoad(event: Event): void {
			if (confessionAPI.loadDone) { //waits for the data to be grabbed
				loadedData = confessionAPI.loadedData; //grabs loaded data from questionAPI
				
				txt_confession.text = TextController.removeASCII(selectRandomConfession());
				
				removeEventListener(Event.ENTER_FRAME, waitForLoad); //removes the event listener as this function is no longer needed
			}
		}
		
		/*
		{"response_code":0,"results":[{"category":"Geography","type":"multiple","difficulty":"easy","question":"Which city is the capital of the United States of America?","correct_answer":"Washington D.C","incorrect_answers":["Seattle","Albany","Los Angeles"]}]} [object Object]

		{"data":[{"created_time":"2018-01-09T00:00:47+0000","message":"[#33460] Anyone taken GOPH 375? Opinions on the course? Is it hard?\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1555443424532475"},{"created_time":"2018-01-09T00:00:38+0000","message":"[#33459] How acceptable is it to wear sweatpants to uni? Discuss. \n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1555443331199151"},{"created_time":"2018-01-09T00:00:29+0000","message":"[#33458] I\u2019m a hella weak girl looking for another female gym partner. Not looking to lose weight but to get strong and in shape, and need someone who knows what they\u2019re doing and can give me a rundown of weights and how the machines work, and to potentially be a workout buddy (cuz I literally have no clue how equipment works and motivation is nice). Looking to workout casually, maybe 3 times a week in the evenings or during the day on weekends. Comment if interested and I\u2019ll shoot you a message! \n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1555443241199160"},{"created_time":"2017-12-06T04:40:38+0000","message":"[#33457] I am challenging Elizabeth cannon to a duel, winner gets their tuition money refunded.\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1522756114467873"},{"created_time":"2017-12-06T04:40:29+0000","message":"[#33456] Why is every girl's leg broken at uni this week o.O","id":"431651536911675_1522755994467885"},{"created_time":"2017-12-06T04:20:50+0000","message":"[#33455] Do the profs use a plagiarism tool?\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1522746027802215"},{"created_time":"2017-12-06T04:20:41+0000","message":"[#33454] Wheres all the good looking , non freaky, single guys at?! Wanting some holiday excitement!\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1522745877802230"},{"created_time":"2017-12-06T04:20:32+0000","message":"[#33453] Anybody wants platinum mid\/support player for league? Add me IGN: Uls\u00e0N\nI will gladly join a t3am too\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1522745744468910"},{"created_time":"2017-12-05T07:00:02+0000","message":"[#33452] When your girlfriend can\u2019t make time for you but can make time for everyone and everything else she wants. Don\u2019t come crying to me when I\u2019m not around anymore. You had your chance.","id":"431651536911675_1521889251221226"},{"created_time":"2017-12-05T06:40:21+0000","message":"[#33451] The werklund school of education is a total joke. And I say this as a student in it. Please do yourself a favor and go to Lethbridge, or anywhere else.","id":"431651536911675_1521875687889249"},{"created_time":"2017-12-05T06:40:12+0000","message":"[#33450] My stress and anxiety levels are through the roof right now\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521875634555921"},{"created_time":"2017-12-05T06:40:02+0000","message":"[#33449] Not trying offend couples who display PDA but can the couple who are always all over each other chill out in ENGG 311. I don\u2019t mind PDA but if y\u2019all make out every 10 seconds it gets kinda annoying. \n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521875411222610"},{"created_time":"2017-12-05T06:20:22+0000","message":"[#33448] The best thing about short girls is your dick looks bigger. Why do you think so many roided out gym bros go after the short girls? Cause their tiny roid dicky looks big to them. \n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521864424557042"},{"created_time":"2017-12-05T06:20:12+0000","message":"[#33447] Today I was sitting in class with someone from residence. We've talked before and know eachother really well. First thing he asks me is if I'm in KNES 244, that would be fine...if we hadnt been working on the final project together for 3 weeks now. \n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521864364557048"},{"created_time":"2017-12-05T06:20:03+0000","message":"[#33446] Does anyone know how many calories are in eating ass? The MyFitnessPal app doesn't have an answer. \n\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521864254557059"},{"created_time":"2017-12-05T06:00:22+0000","message":"[#33445] Hey girl are you a fitted bedsheet? Because I've spent half the evening trying to get you on the fucking bed but I'm ready to give up and jerk off instead. \n\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521853767891441"},{"created_time":"2017-12-05T06:00:13+0000","message":"[#33444] Why don\u2019t some people hold the door for others?? Geez it only takes a few seconds don\u2019t be an ass\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521853697891448"},{"created_time":"2017-12-05T06:00:03+0000","message":"[#33443] Might be a dumb question, but where are the paper hole punchers at uofc?\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521853617891456"},{"created_time":"2017-12-05T05:40:21+0000","message":"[#33442] What exactly is a sorority? Do they cost money to join? What's involved in them time-wise and commitment-wise? Do each have their own theme or thing or are they all the same?","id":"431651536911675_1521843677892450"},{"created_time":"2017-12-05T05:40:12+0000","message":"[#33441] The girl on 4th floor of engg crying on Friday for so long I really hope you are ok\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521843527892465"},{"created_time":"2017-12-05T05:40:03+0000","message":"[#33440] why do I still have dreams about you like wtf get out of my head\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521843477892470"},{"created_time":"2017-12-05T05:20:30+0000","message":"[#33439] I regret being born","id":"431651536911675_1521833811226770"},{"created_time":"2017-12-05T05:20:21+0000","message":"[#33438] Will i look like a jerk if I wear airpods and go around school \n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521833731226778"},{"created_time":"2017-12-05T05:20:12+0000","message":"[#33437] Is it better to take a bare minimum just above the fail grade like 55-60\u0025 or is withdrawing from the course better for your transcript etc? Also does anyone know how it would affect your student loan if you drop to part time this late in the semester. \n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521833624560122"},{"created_time":"2017-12-05T05:00:48+0000","message":"[#33436] When you so ugly that desperately replying to random Craiglist ads doesnt even help...\n \n_______________________\n This confession was sent using Messenger. Send your confession here to post it on this page: http:\/\/m.me\/UofCConfess","id":"431651536911675_1521814881228663"}],"paging":{"cursors":{"before":"Q2c4U1pXNTBYM0YxWlhKNVgzTjBiM0o1WDJsa0R5STBNekUyTlRFMU16WTVNVEUyTnpVNk5EWXdNRGN6TlRVME1USXlNekV5TkRjMUR3eGhjR2xmYzNSdmNubGZAhV1FQSURRek1UWTFNVFV6TmpreE1UWTNOVjh4TlRVMU5EUXpOREkwTlRNeU5EYzFEd1IwYVcxbEJscFVCaThC","after":"Q2c4U1pXNTBYM0YxWlhKNVgzTjBiM0o1WDJsa0R5TTBNekUyTlRFMU16WTVNVEUyTnpVNk9EYzFNVGc1T1RjMk16azFNVEkzTkRJM05nOE1ZAWEJwWDNOMGIzSjVYMmxrRHlBME16RTJOVEUxTXpZANU1URTJOelZAmTVRVeU1UZA3hORGc0TVRJeU9EWTJNdzhFZAEdsdFpRWmFKaWdBQVE9PQZDZD"},"next":"https:\/\/graph.facebook.com\/v2.11\/431651536911675\/posts?access_token=147480742557060\u00257C7df2b675aa1d9f11298e122bb8abd93d&limit=25&after=Q2c4U1pXNTBYM0YxWlhKNVgzTjBiM0o1WDJsa0R5TTBNekUyTlRFMU16WTVNVEUyTnpVNk9EYzFNVGc1T1RjMk16azFNVEkzTkRJM05nOE1ZAWEJwWDNOMGIzSjVYMmxrRHlBME16RTJOVEUxTXpZANU1URTJOelZAmTVRVeU1UZA3hORGc0TVRJeU9EWTJNdzhFZAEdsdFpRWmFKaWdBQVE9PQZDZD"}} [object Object]

		*/
		
		private function selectRandomConfession():String{
			/*
			Return Value:
			Returns a String for a confession that is not the same as the current one being displayed.
			*/
			
			var rv:int = Math.random()*26;
			
			while(rv == lastConfession){
				rv = Math.random()*26;
			}
			
			lastConfession = rv;
			
			//trace(loadedData.data.length); //use this to check how many confessions are fetched
			
			return loadedData.data[rv].message.split("\n \n_______________________\n")[0].split("] ", 2)[1];
		}
		
		private function activateButtons():void{
			/*DO:
			Allow the buttons to be pushed.
			*/
			
			//btn_next.addEventListener(MouseEvent.CLICK, nextTrigger);
			
			btn_close.addEventListener(MouseEvent.CLICK, closeTrigger);
		}
		
		private function closeTrigger(event:MouseEvent):void{
			closePopup();
			//close the pop up decision box
		}
		
		public function closePopup():void{
			//btn_next.removeEventListener(MouseEvent.CLICK, refreshConfession);
			btn_close.removeEventListener(MouseEvent.CLICK, closePopup);
			//removes the event listeners so that clicking on yes and no does nothing
			
			scaleAssist.setLinear(-0.02, 0.08);
			alphaAssist.setLinear(-0.2, 0, cleanUp);
			//pop out animation
			
			Main.instance.character.allowCharMove = true;
			//let character move when menu disappears
		}
		
		private function cleanUp():void{
			parent.removeChild(this);
			//destroys this pop up completely
		}

	}
	
}
