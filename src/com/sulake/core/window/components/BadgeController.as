package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.enum.WindowParam;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   
   public class BadgeController extends WindowController implements IBadgeWindow
   {
      
      protected static const const_468:String = "_BTN_TEXT";
       
      
      public function BadgeController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
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
         if(param2 is WindowEvent)
         {
            switch(param2.type)
            {
               case WindowEvent.const_175:
                  width = 0;
            }
         }
         return super.update(param1,param2);
      }
   }
}
