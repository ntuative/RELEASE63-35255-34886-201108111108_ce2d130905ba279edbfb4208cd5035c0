package com.sulake.core.window.utils
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MouseEventQueue extends GenericEventQueue
   {
       
      
      protected var var_1738:Point;
      
      public function MouseEventQueue(param1:IEventDispatcher)
      {
         super(param1);
         this.var_1738 = new Point();
         _eventDispatcher.addEventListener(MouseEvent.CLICK,this.mouseEventListener,false);
         _eventDispatcher.addEventListener(MouseEvent.DOUBLE_CLICK,this.mouseEventListener,false);
         _eventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseEventListener,false);
         _eventDispatcher.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseEventListener,false);
         _eventDispatcher.addEventListener(MouseEvent.MOUSE_UP,this.mouseEventListener,false);
         _eventDispatcher.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseEventListener,false);
      }
      
      public function get mousePosition() : Point
      {
         return this.var_1738;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            _eventDispatcher.removeEventListener(MouseEvent.CLICK,this.mouseEventListener,false);
            _eventDispatcher.removeEventListener(MouseEvent.DOUBLE_CLICK,this.mouseEventListener,false);
            _eventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseEventListener,false);
            _eventDispatcher.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseEventListener,false);
            _eventDispatcher.removeEventListener(MouseEvent.MOUSE_UP,this.mouseEventListener,false);
            _eventDispatcher.removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseEventListener,false);
            super.dispose();
         }
      }
      
      private function mouseEventListener(param1:MouseEvent) : void
      {
         this.var_1738.x = param1.stageX;
         this.var_1738.y = param1.stageY;
         var_515.push(param1);
      }
   }
}
