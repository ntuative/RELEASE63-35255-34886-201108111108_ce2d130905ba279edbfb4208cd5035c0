package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetCreditFurniRedeemMessage extends RoomWidgetMessage
   {
      
      public static const const_879:String = "RWFCRM_REDEEM";
       
      
      private var var_236:int;
      
      public function RoomWidgetCreditFurniRedeemMessage(param1:String, param2:int)
      {
         super(param1);
         this.var_236 = param2;
      }
      
      public function get objectId() : int
      {
         return this.var_236;
      }
   }
}
