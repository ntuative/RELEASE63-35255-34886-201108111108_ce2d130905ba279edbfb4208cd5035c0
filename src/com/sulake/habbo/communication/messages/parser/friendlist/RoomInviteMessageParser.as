package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomInviteMessageParser implements IMessageParser
   {
       
      
      private var var_1280:int;
      
      private var var_2724:String;
      
      public function RoomInviteMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1280 = param1.readInteger();
         this.var_2724 = param1.readString();
         return true;
      }
      
      public function get senderId() : int
      {
         return this.var_1280;
      }
      
      public function get messageText() : String
      {
         return this.var_2724;
      }
   }
}
