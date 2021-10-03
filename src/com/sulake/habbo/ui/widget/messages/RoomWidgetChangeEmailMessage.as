package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetChangeEmailMessage extends RoomWidgetMessage
   {
      
      public static const const_820:String = "rwcem_change_email";
       
      
      private var var_2602:String;
      
      public function RoomWidgetChangeEmailMessage(param1:String)
      {
         super(const_820);
         this.var_2602 = param1;
      }
      
      public function get newEmail() : String
      {
         return this.var_2602;
      }
   }
}
