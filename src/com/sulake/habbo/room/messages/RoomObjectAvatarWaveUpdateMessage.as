package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarWaveUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_2193:Boolean = false;
      
      public function RoomObjectAvatarWaveUpdateMessage(param1:Boolean = false)
      {
         super();
         this.var_2193 = param1;
      }
      
      public function get isWaving() : Boolean
      {
         return this.var_2193;
      }
   }
}
