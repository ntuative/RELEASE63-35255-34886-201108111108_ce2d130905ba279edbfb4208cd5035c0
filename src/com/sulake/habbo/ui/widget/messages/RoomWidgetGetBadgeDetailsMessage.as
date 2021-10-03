package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetGetBadgeDetailsMessage extends RoomWidgetMessage
   {
      
      public static const const_835:String = "RWGOI_MESSAGE_GET_BADGE_DETAILS";
       
      
      private var var_2550:int = 0;
      
      public function RoomWidgetGetBadgeDetailsMessage(param1:int)
      {
         super(const_835);
         this.var_2550 = param1;
      }
      
      public function get groupId() : int
      {
         return this.var_2550;
      }
   }
}
