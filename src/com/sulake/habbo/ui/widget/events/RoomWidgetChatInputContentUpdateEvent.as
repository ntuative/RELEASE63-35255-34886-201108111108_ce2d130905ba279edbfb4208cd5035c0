package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetChatInputContentUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_992:String = "RWWCIDE_CHAT_INPUT_CONTENT";
      
      public static const const_1403:String = "whisper";
      
      public static const const_2082:String = "shout";
       
      
      private var var_2485:String = "";
      
      private var _userName:String = "";
      
      public function RoomWidgetChatInputContentUpdateEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(const_992,param3,param4);
         this.var_2485 = param1;
         this._userName = param2;
      }
      
      public function get messageType() : String
      {
         return this.var_2485;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
   }
}
