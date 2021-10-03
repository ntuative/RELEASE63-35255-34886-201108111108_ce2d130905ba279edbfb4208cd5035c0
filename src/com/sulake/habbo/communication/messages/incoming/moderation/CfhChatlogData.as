package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CfhChatlogData
   {
       
      
      private var var_1898:int;
      
      private var var_2605:int;
      
      private var var_1665:int;
      
      private var var_2407:int;
      
      private var var_139:RoomChatlogData;
      
      public function CfhChatlogData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1898 = param1.readInteger();
         this.var_2605 = param1.readInteger();
         this.var_1665 = param1.readInteger();
         this.var_2407 = param1.readInteger();
         this.var_139 = new RoomChatlogData(param1);
         Logger.log("READ CFHCHATLOGDATA: callId: " + this.var_1898);
      }
      
      public function get callId() : int
      {
         return this.var_1898;
      }
      
      public function get callerUserId() : int
      {
         return this.var_2605;
      }
      
      public function get reportedUserId() : int
      {
         return this.var_1665;
      }
      
      public function get chatRecordId() : int
      {
         return this.var_2407;
      }
      
      public function get room() : RoomChatlogData
      {
         return this.var_139;
      }
   }
}
