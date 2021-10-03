package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class CanCreateRoomEventMessageParser implements IMessageParser
   {
       
      
      private var var_2691:Boolean;
      
      private var var_1849:int;
      
      public function CanCreateRoomEventMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2691 = param1.readBoolean();
         this.var_1849 = param1.readInteger();
         return true;
      }
      
      public function get canCreateEvent() : Boolean
      {
         return this.var_2691;
      }
      
      public function get errorCode() : int
      {
         return this.var_1849;
      }
   }
}
