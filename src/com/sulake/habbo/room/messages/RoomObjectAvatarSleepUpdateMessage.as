package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarSleepUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_2198:Boolean;
      
      public function RoomObjectAvatarSleepUpdateMessage(param1:Boolean = false)
      {
         super();
         this.var_2198 = param1;
      }
      
      public function get isSleeping() : Boolean
      {
         return this.var_2198;
      }
   }
}
