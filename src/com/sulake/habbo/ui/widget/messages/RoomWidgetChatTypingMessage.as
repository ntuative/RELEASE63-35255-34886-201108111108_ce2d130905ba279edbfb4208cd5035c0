package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetChatTypingMessage extends RoomWidgetMessage
   {
      
      public static const const_857:String = "RWCTM_TYPING_STATUS";
       
      
      private var var_715:Boolean;
      
      public function RoomWidgetChatTypingMessage(param1:Boolean)
      {
         super(const_857);
         this.var_715 = param1;
      }
      
      public function get isTyping() : Boolean
      {
         return this.var_715;
      }
   }
}
