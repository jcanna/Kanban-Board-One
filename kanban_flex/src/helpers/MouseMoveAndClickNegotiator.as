package helpers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	
	public class MouseMoveAndClickNegotiator implements IEventDispatcher
	{
		private var deferredMouseEvent:MouseEvent;
		private var timer:Timer;
		private var eventDispatcher:EventDispatcher;
		public var uicomponent:UIComponent;
		
		public function MouseMoveAndClickNegotiator(uicomponent:UIComponent)
		{
			this.uicomponent = uicomponent;
			eventDispatcher = new EventDispatcher(this.uicomponent);
			
			uicomponent.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			uicomponent.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			uicomponent.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function mouseDownHandler(event:MouseEvent) {
				deferredMouseEvent = event;
		}
		
		private function mouseMoveHandler(event:MouseEvent) {
			if (deferredMouseEvent != null) {
				var eventToDispatch = deferredMouseEvent;				
				deferredMouseEvent = null;
				dispatchEvent(eventToDispatch);
			}
		}
		
		private function clickHandler(event:MouseEvent) {
			deferredMouseEvent = null;
			dispatchEvent(event);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
 	 	
		public function dispatchEvent(event:Event):Boolean {
			return eventDispatcher.dispatchEvent(event);
		}
		 	 	
		public function hasEventListener(type:String):Boolean {
			return eventDispatcher.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		 	 	
		public function willTrigger(type:String):Boolean {
			return eventDispatcher.willTrigger(type);
		}

	}
}