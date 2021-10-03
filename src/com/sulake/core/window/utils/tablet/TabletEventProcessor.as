package com.sulake.core.window.utils.tablet
{
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.utils.EventProcessorState;
   import com.sulake.core.window.utils.IEventQueue;
   import com.sulake.core.window.utils.MouseEventProcessor;
   
   public class TabletEventProcessor extends MouseEventProcessor
   {
       
      
      private var var_3150:String = "";
      
      public function TabletEventProcessor()
      {
         super();
      }
      
      override public function process(param1:EventProcessorState, param2:IEventQueue) : void
      {
         if(param2.length == 0)
         {
            return;
         }
         var_96 = param1.desktop;
         var_71 = param1.var_1427 as WindowController;
         var_150 = param1.var_1429 as WindowController;
         var_175 = param1.renderer;
         var_958 = param1.var_1431;
         param2.begin();
         param2.end();
         param1.desktop = var_96;
         param1.var_1427 = var_71;
         param1.var_1429 = var_150;
         param1.renderer = var_175;
         param1.var_1431 = var_958;
      }
   }
}
