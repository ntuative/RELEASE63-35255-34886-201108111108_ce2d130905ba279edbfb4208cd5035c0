package com.sulake.core.runtime.events
{
   public class ErrorEvent extends WarningEvent
   {
       
      
      protected var var_3080:Boolean;
      
      protected var var_2113:String;
      
      public function ErrorEvent(param1:String, param2:String, param3:Boolean, param4:String = null)
      {
         this.var_3080 = param3;
         this.var_2113 = param4;
         super(param1,param2);
      }
      
      public function get critical() : Boolean
      {
         return this.var_3080;
      }
      
      public function get stackTrace() : String
      {
         return this.var_2113;
      }
   }
}
