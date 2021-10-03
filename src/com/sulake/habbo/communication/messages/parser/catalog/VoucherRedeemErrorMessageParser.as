package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class VoucherRedeemErrorMessageParser implements IMessageParser
   {
       
      
      private var var_1849:String = "";
      
      public function VoucherRedeemErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_1849 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1849 = param1.readString();
         return true;
      }
      
      public function get errorCode() : String
      {
         return this.var_1849;
      }
   }
}
