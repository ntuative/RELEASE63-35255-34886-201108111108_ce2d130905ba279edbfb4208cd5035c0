package com.sulake.habbo.communication.messages.parser.room.permissions
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class YouAreControllerMessageParser implements IMessageParser
   {
       
      
      public function YouAreControllerMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         return true;
      }
   }
}
