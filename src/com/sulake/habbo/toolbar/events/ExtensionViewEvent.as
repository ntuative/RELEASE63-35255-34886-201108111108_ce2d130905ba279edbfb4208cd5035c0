package com.sulake.habbo.toolbar.events
{
   import flash.events.Event;
   
   public class ExtensionViewEvent extends Event
   {
      
      public static const const_1436:String = "EVE_EXTENSION_VIEW_RESIZED";
       
      
      public function ExtensionViewEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
