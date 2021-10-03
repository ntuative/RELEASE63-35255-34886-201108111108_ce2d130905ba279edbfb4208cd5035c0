package com.sulake.habbo.catalog.viewer.widgets.events
{
   import com.sulake.habbo.catalog.viewer.Offer;
   import flash.events.Event;
   
   public class SelectProductEvent extends Event
   {
       
      
      private var var_107:Offer;
      
      public function SelectProductEvent(param1:Offer, param2:Boolean = false, param3:Boolean = false)
      {
         super(WidgetEvent.CWE_SELECT_PRODUCT,param2,param3);
         this.var_107 = param1;
      }
      
      public function get offer() : Offer
      {
         return this.var_107;
      }
   }
}
