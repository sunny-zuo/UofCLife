package Controllers {		import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.TextFormatAlign;	public class TextController {		public function TextController() {			// constructor code		}				public static function newTextFormat(size:int = 10, colour:uint = 0, font:String = "Calibri", alignment:String = "center"):TextFormat{			var tempFormat:TextFormat = new TextFormat();			tempFormat.size = size;			tempFormat.color = colour;			tempFormat.font = font;			tempFormat.align = alignment			return tempFormat;		} 				public static function charInString(char:String, str:String):int{			//PROMISES: returns the number of times [char] has been found inside the string [str]						var count:int = 0;			//number of times char existed in str						for(var i:int = 0; i < str.length - char.length + 1; i++){				if(char == str.substr(i, char.length)){					count++;				}			}						return count;		}
		
		public static function removeASCII(input:String) {
			//Function to remove the ASCII that makes the question/answer hard to read. Add more when needed.
			input = input.replace(/&#039;/g, "\'");
			input = input.replace(/&#034;/g, "\"");
			input = input.replace(/&quot;/g, "\"");
			input = input.replace(/&uuml;/g, "ü");
			input = input.replace(/&eacute;/g, "é");
			input = input.replace(/&aacute;/g, "á");
			input = input.replace(/&ouml;/g, "ö");
			input = input.replace(/&Uuml;/g, "Ü");
			input = input.replace(/&rsquo;/g, "'");
			input = input.replace(/&sup2;/g, "²");
			input = input.replace(/&amp;/g, "&");
			input = input.replace(/&iacute;/g, "í")
			return(input);
		}	}	}