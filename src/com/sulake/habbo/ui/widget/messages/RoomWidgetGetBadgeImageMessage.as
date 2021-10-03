package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetGetBadgeImageMessage extends RoomWidgetMessage
   {
      
      public static const const_867:String = "RWGOI_MESSAGE_GET_BADGE_IMAGE";
       
      
      private var var_2439:String = "";
      
      public function RoomWidgetGetBadgeImageMessage(param1:String)
      {
         super(const_867);
         this.var_2439 = param1;
      }
      
      public function get badgeId() : String
      {
         return this.var_2439;
      }
   }
}
