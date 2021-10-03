package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowTouchEvent;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class ButtonController extends InteractiveController implements IButtonWindow, ITouchAwareWindow
   {
      
      protected static const const_468:String = "_BTN_TEXT";
      
      protected static const const_1446:Number = 0.5;
       
      
      public function ButtonController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 0;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         var _loc2_:IWindow = getChildByName(const_468);
         if(_loc2_ != null)
         {
            _loc2_.caption = caption;
         }
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var type:String = null;
         var windowEvent:WindowEvent = null;
         var result:Boolean = false;
         var subject:WindowController = param1;
         var event:WindowEvent = param2;
         if(event is WindowEvent)
         {
            switch(event.type)
            {
               case WindowEvent.const_175:
                  width = 0;
                  break;
               case WindowEvent.const_225:
                  try
                  {
                     getChildByName(const_468).blend = getChildByName(const_468).blend + const_1446;
                  }
                  catch(e:Error)
                  {
                  }
                  break;
               case WindowEvent.const_239:
                  try
                  {
                     getChildByName(const_468).blend = getChildByName(const_468).blend - const_1446;
                  }
                  catch(e:Error)
                  {
                  }
            }
         }
         else if(event is WindowTouchEvent)
         {
            type = "null";
            switch(event.type)
            {
               case WindowTouchEvent.const_817:
                  type = "null";
                  break;
               case WindowTouchEvent.const_1225:
                  type = "null";
                  break;
               case WindowTouchEvent.const_897:
                  type = "null";
            }
            windowEvent = WindowMouseEvent.allocate(type,WindowTouchEvent(event).window,WindowTouchEvent(event).related,WindowTouchEvent(event).localX,WindowTouchEvent(event).localY,WindowTouchEvent(event).stageX,WindowTouchEvent(event).stageY,WindowTouchEvent(event).altKey,WindowTouchEvent(event).ctrlKey,WindowTouchEvent(event).shiftKey,true,0);
            result = super.update(subject,windowEvent);
            windowEvent.recycle();
            return result;
         }
         return super.update(subject,event);
      }
   }
}
