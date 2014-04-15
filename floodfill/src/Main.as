package 
{
	import adobe.utils.ProductManager;
	import flash.automation.AutomationAction;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Matt Dobler
	 */
	public class Main extends Sprite 
	{
		private var siz:int = 400;
		private var bdata:BitmapData;
		private var map:Bitmap;
		private var open:Vector.<Point>;
		private var found:Vector.<Vector.<Point>>;
		private var step:int = 0;
		private var perFrame:int = 100;
		private var stepsize:Number = 0;
		private var evenodd:Boolean = false;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function safeGet(found:Vector.<Vector.<Point>>,x:int,y:int):Point
		{
			if (x < 0 || y < 0 || x >= found.length || y >= found[0].length)
			{
				return new Point(-999,-999);
			}
			return found[x][y];
		}
		
		private function shuffle(arr:Vector.<Point>):void 
		{
			for (var i:int = 0; i < arr.length; i++)
			{
				var index:int = Math.floor(Math.random() * arr.length);
				var temp:Point = arr[i];
				arr[i] = arr[index];
				arr[index] = temp;
			}
		}
		
		private function next():void
		{
			if (open.length > 0)
			{
			var state:Point = open.pop();
			step++;
			stepsize = Math.max(stepsize, open.length);
			bdata.setPixel(state.x,state.y,((open.length)));
			var next:Vector.<Point> = new Vector.<Point>();
			var u:int, v:int;
			u = state.x;
			v = state.y;
			var temp:Vector.<Point> = new Vector.<Point>();
			var n:Point = safeGet(found, u - 1, v);
			if (n.x == -2)
			{
				found[u-1][v].x = state.x; 
				found[u-1][v].y = state.y;
				temp.push(new Point(u - 1, v));
				bdata.setPixel(u - 1, v, 0xffff00);
			}			
			n = safeGet(found, u, v + 1);
			if (n.x == -2)
			{
				found[u][v+1].x = state.x; 
				found[u][v+1].y = state.y;
				temp.push(new Point(u, v + 1));
				bdata.setPixel(u, v + 1, 0xffff00);
			}
			n = safeGet(found, u , v - 1);
			if (n.x == -2)
			{
				found[u][v-1].x = state.x; 
				found[u][v-1].y = state.y;
				temp.push(new Point( u , v - 1));
				bdata.setPixel(u, v - 1, 0xffff00);
			}
						n = safeGet(found, u + 1, v);
			if (n.x == -2)
			{
				found[u+1][v].x = state.x; 
				found[u+1][v].y = state.y;
				temp.push(new Point(u + 1, v));
				bdata.setPixel(u + 1, v, 0xffff00);
			}


			shuffle(temp);
			for (var i:int = 0; i < temp.length; i++)
			{
				open.push(temp[i]);
			}
			}
			else
			{
				stage.removeEventListener(Event.ENTER_FRAME, nextFrame);
				if (!evenodd)
				{
					evenodd = true;
					
					var scaliong:Number = (400.0 / siz);
					graphics.lineStyle(scaliong /2, 0);
					for (var i:int = 0; i < siz; i++)
					{
						for (var j = 0; j < siz; j++)
						{
							graphics.moveTo(i * scaliong, j * scaliong);
							graphics.lineTo(found[i][j].x * scaliong, found[i][j].y * scaliong);
						}
					}
				}
			}
		}
		private function nextFrame(e:Event):void 
		{
			var prevnum:int = step;
			for (var i = 0; i < perFrame; i++)
				next();
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			open = new Vector.<Point>();
			found = new Vector.<Vector.<Point>>();
			//generate 
			for (var i = 0; i < siz; i++)
			{
				found[i] = new Vector.<Point>();
				for (var j = 0; j < siz; j++)
				{
					found[i][j] = new Point( -2, -2);
				}
			}
			//Generate bitmap, 
			bdata = new BitmapData(siz,siz,false,0xffffff);
			map = new Bitmap(bdata);
			map.scaleX = map.scaleY = 400/siz;

			addChild(map);
			var initState:Point= new Point(Math.floor(Math.random() * siz), Math.floor(Math.random() * siz));
			open.push(initState);
			stage.addEventListener(Event.ENTER_FRAME, nextFrame);
		}
		
	}
	
}