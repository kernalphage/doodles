package 
{
	import flash.desktop.ClipboardFormats;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Matt Dobler
	 */
	public class Branch extends MovieClip
	{
		public var _maxLen:Number = 80;
		public var _maxWidth:Number = 10;
		public var _startRotation = 0;
		public var _cosSin:Boolean = Math.random() < .5;
		public var _time:Number = 0;
		public var _startLen:Number = 0;
		public function Branch(len:Number, rotation:Number = 0, prevWidth:Number = 30)
		{
			_startLen = len;
			_maxLen *= len;
			_maxWidth *= len;
			_startRotation = rotation;
			this.rotation = _startRotation;
			if (len > .2)
			{		
			//branch
			graphics.beginFill(0x63613f);
			graphics.drawCircle(0, 0, prevWidth/2);
			graphics.drawCircle(0, -_maxLen, _maxWidth/2);
			graphics.endFill();
			graphics.lineStyle();
			graphics.beginFill(0x63613f);
			graphics.moveTo( -prevWidth / 2, 0);
			graphics.lineTo( prevWidth / 2 , 0);
			graphics.lineStyle(2 * len );
			graphics.lineTo( _maxWidth / 2, -_maxLen);
			graphics.lineStyle();
			graphics.lineTo( -_maxWidth / 2, -_maxLen);
			graphics.endFill();

				for (var i:int = Math.random() * 2 + 2; i >= 0; i--)
				{
					var newRotation:Number = Math.random() * 80 - 40;
					var b:Branch = new Branch(len * (Math.random()*.4 + .4),newRotation, _maxWidth);
					b.x = 0;
					b.y = -_maxLen;
					addChild(b);
				}
			addEventListener(Event.ENTER_FRAME, onFrame);
			}
			else
			{
				//leaf
				graphics.beginFill(0xff00,.8);
				graphics.drawCircle(_maxWidth/2, 0, 10);
				graphics.endFill();
			}
		}
		
		public function onFrame(e:Event)
		{
			_time += .02 * (2-_startLen);
			this.rotation =  _startRotation + ((_cosSin)?Math.cos(_time):Math.sin(_time)) * 8 * Math.sqrt((2-_startLen));
		}
	}
	
}