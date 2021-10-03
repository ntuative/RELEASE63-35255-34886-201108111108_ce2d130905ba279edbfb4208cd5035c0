package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContextStateListener;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.enum.MouseCursorType;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.graphics.IWindowRenderer;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MouseEventProcessor implements IEventProcessor, IDisposable
   {
      
      protected static var var_366:Array;
      
      protected static var var_317:Array;
      
      protected static var var_440:Point = new Point();
       
      
      protected var var_769:Point;
      
      protected var var_150:WindowController;
      
      protected var var_71:WindowController;
      
      protected var var_175:IWindowRenderer;
      
      protected var var_96:IDesktopWindow;
      
      protected var var_958:Vector.<IWindowContextStateListener>;
      
      private var _disposed:Boolean = false;
      
      public function MouseEventProcessor()
      {
         super();
         this.var_769 = new Point();
         if(var_366 == null)
         {
            var_366 = new Array();
            var_366[0] = MouseCursorType.const_377;
            var_366[1] = MouseCursorType.const_30;
            var_366[2] = MouseCursorType.const_377;
            var_366[3] = MouseCursorType.const_377;
            var_366[4] = MouseCursorType.const_377;
            var_366[5] = MouseCursorType.const_30;
            var_366[6] = MouseCursorType.const_377;
         }
         if(var_317 == null)
         {
            var_317 = new Array();
            var_317[0] = WindowState.const_91;
            var_317[1] = WindowState.const_92;
            var_317[2] = WindowState.const_88;
            var_317[3] = WindowState.const_76;
            var_317[4] = WindowState.const_57;
            var_317[5] = WindowState.const_98;
            var_317[6] = WindowState.const_89;
         }
      }
      
      public static function setMouseCursorByState(param1:uint, param2:uint) : void
      {
         var _loc3_:int = var_317.indexOf(param1);
         if(_loc3_ > -1)
         {
            var_366[_loc3_] = param2;
         }
      }
      
      public static function getMouseCursorByState(param1:uint) : uint
      {
         var _loc2_:int = 0;
         while(_loc2_-- > 0)
         {
            if((param1 & 0) > 0)
            {
               return var_366[_loc2_];
            }
         }
         return MouseCursorType.const_30;
      }
      
      protected static function convertMouseEventType(param1:MouseEvent, param2:IWindow, param3:IWindow) : WindowMouseEvent
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:Boolean = false;
         _loc5_ = new Point(param1.stageX,param1.stageY);
         param2.convertPointFromGlobalToLocalSpace(_loc5_);
         switch(param1.type)
         {
            case MouseEvent.MOUSE_MOVE:
               _loc4_ = "null";
               break;
            case MouseEvent.MOUSE_OVER:
               _loc4_ = "null";
               break;
            case MouseEvent.MOUSE_OUT:
               _loc4_ = "null";
               break;
            case MouseEvent.ROLL_OUT:
               _loc4_ = "null";
               break;
            case MouseEvent.ROLL_OVER:
               _loc4_ = "null";
               break;
            case MouseEvent.CLICK:
               _loc4_ = "null";
               break;
            case MouseEvent.DOUBLE_CLICK:
               _loc4_ = "null";
               break;
            case MouseEvent.MOUSE_DOWN:
               _loc4_ = "null";
               break;
            case MouseEvent.MOUSE_UP:
               _loc6_ = _loc5_.x > -1 && _loc5_.y > -1 && _loc5_.x < param2.width && _loc5_.y < param2.height;
               _loc4_ = !!_loc6_ ? "null" : WindowMouseEvent.const_284;
               break;
            case MouseEvent.MOUSE_WHEEL:
               _loc4_ = "null";
               break;
            default:
               _loc4_ = "null";
         }
         return WindowMouseEvent.allocate(_loc4_,param2,param3,_loc5_.x,_loc5_.y,param1.stageX,param1.stageY,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown,param1.delta);
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this._disposed = true;
         }
      }
      
      public function process(param1:EventProcessorState, param2:IEventQueue) : void
      {
         var event:MouseEvent = null;
         var index:int = 0;
         var child:WindowController = null;
         var array:Array = null;
         var tempWindowEvent:WindowEvent = null;
         var window:IWindow = null;
         var temp:IWindow = null;
         var tracker:IWindowContextStateListener = null;
         var state:EventProcessorState = param1;
         var eventQueue:IEventQueue = param2;
         if(eventQueue.length == 0)
         {
            return;
         }
         this.var_96 = state.desktop;
         this.var_71 = state.var_1427 as WindowController;
         this.var_150 = state.var_1429 as WindowController;
         this.var_175 = state.renderer;
         this.var_958 = state.var_1431;
         eventQueue.begin();
         this.var_769.x = -1;
         this.var_769.y = -1;
         var mouseCursorType:int = 0;
         while(true)
         {
            event = eventQueue.next() as MouseEvent;
            if(event == null)
            {
               break;
            }
            if(event.stageX != this.var_769.x || event.stageY != this.var_769.y)
            {
               this.var_769.x = event.stageX;
               this.var_769.y = event.stageY;
               array = new Array();
               this.var_96.groupParameterFilteredChildrenUnderPoint(this.var_769,array,WindowParam.const_29);
            }
            index = array != null ? int(array.length) : 0;
            if(index == 0)
            {
               switch(event.type)
               {
                  case MouseEvent.MOUSE_MOVE:
                     if(this.var_71 != this.var_96 && !this.var_71.disposed)
                     {
                        this.var_71.getGlobalPosition(var_440);
                        tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.const_25,this.var_71,null,event.stageX - 0,event.stageY - 0,event.stageX,event.stageY,event.altKey,event.ctrlKey,event.shiftKey,event.buttonDown,event.delta);
                        this.var_71.update(this.var_71,tempWindowEvent);
                        this.var_71 = WindowController(this.var_96);
                        tempWindowEvent.recycle();
                     }
                     break;
                  case MouseEvent.MOUSE_DOWN:
                     window = this.var_96.getActiveWindow();
                     if(window)
                     {
                        window.deactivate();
                     }
                     break;
                  case MouseEvent.MOUSE_UP:
                     if(this.var_150)
                     {
                        array.push(this.var_150);
                        index++;
                     }
               }
            }
            while(--index > -1)
            {
               child = this.passMouseEvent(WindowController(array[index]),event);
               if(child != null && child.visible)
               {
                  if(event.type == MouseEvent.MOUSE_MOVE)
                  {
                     if(child != this.var_71)
                     {
                        if(!this.var_71.disposed)
                        {
                           this.var_71.getGlobalPosition(var_440);
                           tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.const_25,this.var_71,child,event.stageX - 0,event.stageY - 0,event.stageX,event.stageY,event.altKey,event.ctrlKey,event.shiftKey,event.buttonDown,event.delta);
                           this.var_71.update(this.var_71,tempWindowEvent);
                           tempWindowEvent.recycle();
                        }
                        if(!child.disposed)
                        {
                           child.getGlobalPosition(var_440);
                           tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,child,null,event.stageX - 0,event.stageY - 0,event.stageX,event.stageY,event.altKey,event.ctrlKey,event.shiftKey,event.buttonDown,event.delta);
                           child.update(child,tempWindowEvent);
                           tempWindowEvent.recycle();
                        }
                        if(!child.disposed)
                        {
                           this.var_71 = child;
                        }
                     }
                  }
                  else if(event.type == MouseEvent.MOUSE_UP || event.type == MouseEvent.CLICK || event.type == MouseEvent.MOUSE_DOWN)
                  {
                     if(this.var_71 && !this.var_71.disposed)
                     {
                        if(this.var_958 != null)
                        {
                           for each(tracker in this.var_958)
                           {
                              tracker.mouseEventReceived(event.type,this.var_71);
                           }
                        }
                     }
                  }
                  temp = child.parent;
                  while(temp && !temp.disposed)
                  {
                     if(temp is IInputProcessorRoot)
                     {
                        tempWindowEvent = convertMouseEventType(event,temp,child);
                        IInputProcessorRoot(temp).process(tempWindowEvent);
                        tempWindowEvent.recycle();
                        break;
                     }
                     temp = temp.parent;
                  }
                  if(event.altKey)
                  {
                     if(this.var_71)
                     {
                        Logger.log("HOVER: " + this.var_71.name);
                     }
                  }
                  if(this.var_71 is IInteractiveWindow)
                  {
                     try
                     {
                        mouseCursorType = IInteractiveWindow(this.var_71).getMouseCursorByState(this.var_71.state);
                        if(mouseCursorType == MouseCursorType.const_30)
                        {
                           mouseCursorType = getMouseCursorByState(this.var_71.state);
                        }
                     }
                     catch(e:Error)
                     {
                        mouseCursorType = 0;
                     }
                  }
                  if(child != this.var_96)
                  {
                     event.stopPropagation();
                     eventQueue.remove();
                  }
                  break;
               }
            }
         }
         eventQueue.end();
         MouseCursorControl.type = mouseCursorType;
         state.desktop = this.var_96;
         state.var_1427 = this.var_71;
         state.var_1429 = this.var_150;
         state.renderer = this.var_175;
         state.var_1431 = this.var_958;
      }
      
      private function passMouseEvent(param1:WindowController, param2:MouseEvent, param3:Boolean = false) : WindowController
      {
         var _loc9_:* = null;
         if(param1.disposed)
         {
            return null;
         }
         if(param1.testStateFlag(WindowState.const_89))
         {
            return null;
         }
         var _loc4_:* = false;
         var _loc5_:Point = new Point(param2.stageX,param2.stageY);
         param1.convertPointFromGlobalToLocalSpace(_loc5_);
         if(param2.type == MouseEvent.MOUSE_UP)
         {
            if(param1 != this.var_150)
            {
               if(this.var_150 && !this.var_150.disposed)
               {
                  this.var_150.update(this.var_150,convertMouseEventType(new MouseEvent(MouseEvent.MOUSE_UP,false,true,param2.localX,param2.localY,null,param2.ctrlKey,param2.altKey,param2.shiftKey,param2.buttonDown,param2.delta),this.var_150,param1));
                  this.var_150 = null;
                  if(param1.disposed)
                  {
                     return null;
                  }
               }
            }
            else
            {
               _loc4_ = !param1.hitTestLocalPoint(_loc5_);
            }
         }
         if(!_loc4_)
         {
            _loc9_ = this.var_175.getDrawBufferForRenderable(param1);
            if(!param1.validateLocalPointIntersection(_loc5_,_loc9_))
            {
               return null;
            }
         }
         if(param1.testParamFlag(WindowParam.const_629))
         {
            if(param1.parent != null)
            {
               return this.passMouseEvent(WindowController(param1.parent),param2);
            }
         }
         if(!param3)
         {
            switch(param2.type)
            {
               case MouseEvent.MOUSE_DOWN:
                  this.var_150 = param1;
                  break;
               case MouseEvent.CLICK:
                  if(this.var_150 != param1)
                  {
                     return null;
                  }
                  this.var_150 = null;
                  break;
               case MouseEvent.DOUBLE_CLICK:
                  if(this.var_150 != param1)
                  {
                     return null;
                  }
                  this.var_150 = null;
                  break;
            }
         }
         var _loc7_:WindowMouseEvent = convertMouseEventType(param2,param1,null);
         var _loc8_:Boolean = param1.update(param1,_loc7_);
         _loc7_.recycle();
         if(!_loc8_ && !param3)
         {
            if(param1.parent)
            {
               return this.passMouseEvent(WindowController(param1.parent),param2);
            }
         }
         return param1;
      }
   }
}
