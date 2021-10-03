package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContextStateListener;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.graphics.IWindowRenderer;
   
   public class EventProcessorState
   {
       
      
      public var renderer:IWindowRenderer;
      
      public var desktop:IDesktopWindow;
      
      public var var_1427:IWindow;
      
      public var var_1429:IWindow;
      
      public var var_1431:Vector.<IWindowContextStateListener>;
      
      public function EventProcessorState(param1:IWindowRenderer, param2:IDesktopWindow, param3:IWindow, param4:IWindow, param5:Vector.<IWindowContextStateListener>)
      {
         super();
         this.renderer = param1;
         this.desktop = param2;
         this.var_1427 = param3;
         this.var_1429 = param4;
         this.var_1431 = param5;
      }
   }
}
