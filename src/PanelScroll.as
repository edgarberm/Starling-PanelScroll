package 
{
  import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;

	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;


	public class PanelScroll extends Sprite 
	{
		private var _container:Sprite;
		private var _panelBounds:Rectangle = new Rectangle(0, 0, 700, 456);
		private var _currentPanelIndex:int = 0;
		private var _panelCount:int;
		private var position:Point;
		private var _x1:Number;
		private var _x2:Number;
		private var _t1:uint;
		private var _t2:uint;
		private var _startX:Number;
		private var _offsetX:Number; 
		
		public function PanelScroll() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage (event:Event) : void 
		{ 
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_container = new Sprite();
			_container.x = _panelBounds.x;
			_container.y = _panelBounds.y;
			this.addChild(_container);
			
			_container.addEventListener(TouchEvent.TOUCH, touchHandler); 
			
			var q:Quad;
			
			_panelCount = 5;
			
			for(var i:uint = 0; i < 5; i++)
			{
				q = new Quad(600, 450);
				q.color = Math.random() * 0xFFFFFF;
				q.x = i * _panelBounds.width;
				q.y = 0;
				_container.addChild(q);
			}
		}

		private function touchHandler(event : TouchEvent) : void 
		{
			var touch:Touch = event.getTouch(stage);
			position = touch.getLocation(stage);
			var target:Quad = event.target as Quad;
			
			if(touch.phase == TouchPhase.BEGAN )
			{
				_startX = position.x;
				_offsetX = _container.x;
				_x1 = _x2 = position.x;
				_t1 = _t2 = getTimer();
				
				this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
			   
			if(touch.phase == TouchPhase.MOVED )
			{
			  _container.x = _offsetX + position.x - _startX;
			}
			
			if(touch.phase == TouchPhase.ENDED )
			{
        this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);

				var elapsedTime:Number = (getTimer() - _t2) / 1000;
				var xVelocity:Number = (position.x - _x2) / elapsedTime;
	
				if (_currentPanelIndex > 0 && (xVelocity > 20 || _container.x > (_currentPanelIndex - 0.5) * -_panelBounds.width + _panelBounds.x)) 
				{
					_currentPanelIndex--;
				} 
				else if (_currentPanelIndex < _panelCount - 1 && (xVelocity < -20 || _container.x < (_currentPanelIndex + 0.5) * -_panelBounds.width + _panelBounds.x)) 
				{
					_currentPanelIndex++;
				}
				
				TweenLite.to(_container, 0.7, {x:_currentPanelIndex * -_panelBounds.width + _panelBounds.x, ease:Strong.easeOut});
			}
		}

		private function onEnterFrame(event : Event) : void 
		{
			_x2 = _x1;
			_t2 = _t1;
			_x1 = position.x;
			_t1 = getTimer();
		}
	}
}
