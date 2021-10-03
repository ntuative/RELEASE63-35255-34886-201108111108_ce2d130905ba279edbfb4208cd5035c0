package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.ChargeInfo;
   
   public class ChargeInfoMessageParser implements IMessageParser
   {
       
      
      private var var_780:ChargeInfo;
      
      public function ChargeInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_780 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_780 = new ChargeInfo(param1);
         return true;
      }
      
      public function get chargeInfo() : ChargeInfo
      {
         return this.var_780;
      }
   }
}
