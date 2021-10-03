package com.sulake.habbo.communication.messages.parser.inventory.purse
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class CreditBalanceParser implements IMessageParser
   {
       
      
      private var var_2031:int;
      
      public function CreditBalanceParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2031 = int(param1.readString());
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get balance() : int
      {
         return this.var_2031;
      }
   }
}
