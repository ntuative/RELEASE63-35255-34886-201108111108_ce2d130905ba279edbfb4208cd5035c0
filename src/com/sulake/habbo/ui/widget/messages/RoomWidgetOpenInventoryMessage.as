package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetOpenInventoryMessage extends RoomWidgetMessage
   {
      
      public static const const_891:String = "RWGOI_MESSAGE_OPEN_INVENTORY";
      
      public static const const_1847:String = "inventory_effects";
      
      public static const const_1335:String = "inventory_badges";
      
      public static const const_2077:String = "inventory_clothes";
      
      public static const const_2043:String = "inventory_furniture";
       
      
      private var var_2381:String;
      
      public function RoomWidgetOpenInventoryMessage(param1:String)
      {
         super(const_891);
         this.var_2381 = param1;
      }
      
      public function get inventoryType() : String
      {
         return this.var_2381;
      }
   }
}
