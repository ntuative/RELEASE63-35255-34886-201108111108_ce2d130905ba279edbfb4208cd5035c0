package com.sulake.habbo.help.tutorial
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class TutorialCallGuideBotView implements ITutorialUIView
   {
       
      
      private var var_36:TutorialUI;
      
      private var var_2050:IWindowContainer;
      
      public function TutorialCallGuideBotView(param1:IItemListWindow, param2:TutorialUI)
      {
         super();
         this.var_36 = param2;
         var _loc3_:IWindowContainer = param2.buildXmlWindow("tutorial_call_guidebot") as IWindowContainer;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.procedure = this.windowProcedure;
         param1.addListItem(_loc3_ as IWindow);
         this.var_36.prepareForTutorial();
      }
      
      public function get view() : IWindowContainer
      {
         return null;
      }
      
      public function get id() : String
      {
         return TutorialUI.const_534;
      }
      
      public function dispose() : void
      {
         if(this.var_2050)
         {
            this.var_2050.dispose();
            this.var_2050 = null;
         }
         this.var_36 = null;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         switch(param2.name)
         {
            case "button_cancel":
               if(param1.type == WindowMouseEvent.const_43)
               {
                  this.var_36.showView(TutorialUI.const_96);
               }
         }
      }
   }
}
