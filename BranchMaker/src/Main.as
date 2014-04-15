package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Matt Dobler
	 */
	public class Main extends Sprite 
	{
		var b:Branch = new Branch(2);
		var can:ArtsyCanvas = new ArtsyCanvas();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.frameRate = 60;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			b.x = stage.stageWidth / 2;
			b.y = stage.stageHeight;
			addChild(b);
			addChild(can);
		stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void
		{
			removeChild(b);
			b = new Branch(2);
			b.x = stage.stageWidth / 2;
			b.y = stage.stageHeight;
			addChild(b);
		
		}
	}
	
}