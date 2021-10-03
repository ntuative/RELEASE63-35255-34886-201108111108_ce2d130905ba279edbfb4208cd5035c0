package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class InfoFeedEnableMessageParser implements IMessageParser
   {
       
      
      private var var_1891:Boolean;
      
      public function InfoFeedEnableMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_1891 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1891 = param1.readBoolean();
         return true;
      }
      
      public function get enabled() : Boolean
      {
         return this.var_1891;
      }
   }
}
