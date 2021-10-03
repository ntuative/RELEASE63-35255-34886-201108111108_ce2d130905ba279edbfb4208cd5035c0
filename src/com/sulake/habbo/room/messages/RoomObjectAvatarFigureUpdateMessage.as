package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_727:String;
      
      private var var_2822:String;
      
      private var var_1123:String;
      
      public function RoomObjectAvatarFigureUpdateMessage(param1:String, param2:String = null, param3:String = null)
      {
         super();
         this.var_727 = param1;
         this.var_1123 = param2;
         this.var_2822 = param3;
      }
      
      public function get figure() : String
      {
         return this.var_727;
      }
      
      public function get race() : String
      {
         return this.var_2822;
      }
      
      public function get gender() : String
      {
         return this.var_1123;
      }
   }
}
