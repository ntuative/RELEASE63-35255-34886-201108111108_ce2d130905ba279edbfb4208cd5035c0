package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class RoomVisitData
   {
       
      
      private var var_1981:Boolean;
      
      private var _roomId:int;
      
      private var var_1073:String;
      
      private var var_2775:int;
      
      private var var_2776:int;
      
      public function RoomVisitData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1981 = param1.readBoolean();
         this._roomId = param1.readInteger();
         this.var_1073 = param1.readString();
         this.var_2775 = param1.readInteger();
         this.var_2776 = param1.readInteger();
      }
      
      public function get isPublic() : Boolean
      {
         return this.var_1981;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomName() : String
      {
         return this.var_1073;
      }
      
      public function get enterHour() : int
      {
         return this.var_2775;
      }
      
      public function get enterMinute() : int
      {
         return this.var_2776;
      }
   }
}
