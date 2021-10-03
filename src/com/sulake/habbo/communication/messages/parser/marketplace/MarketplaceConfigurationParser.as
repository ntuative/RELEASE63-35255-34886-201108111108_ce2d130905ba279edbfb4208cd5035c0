package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class MarketplaceConfigurationParser implements IMessageParser
   {
       
      
      private var var_1675:Boolean;
      
      private var var_2348:int;
      
      private var var_1767:int;
      
      private var var_1768:int;
      
      private var var_2353:int;
      
      private var var_2349:int;
      
      private var var_2352:int;
      
      private var var_2354:int;
      
      public function MarketplaceConfigurationParser()
      {
         super();
      }
      
      public function get isEnabled() : Boolean
      {
         return this.var_1675;
      }
      
      public function get commission() : int
      {
         return this.var_2348;
      }
      
      public function get tokenBatchPrice() : int
      {
         return this.var_1767;
      }
      
      public function get tokenBatchSize() : int
      {
         return this.var_1768;
      }
      
      public function get offerMinPrice() : int
      {
         return this.var_2349;
      }
      
      public function get offerMaxPrice() : int
      {
         return this.var_2353;
      }
      
      public function get expirationHours() : int
      {
         return this.var_2352;
      }
      
      public function get averagePricePeriod() : int
      {
         return this.var_2354;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1675 = param1.readBoolean();
         this.var_2348 = param1.readInteger();
         this.var_1767 = param1.readInteger();
         this.var_1768 = param1.readInteger();
         this.var_2349 = param1.readInteger();
         this.var_2353 = param1.readInteger();
         this.var_2352 = param1.readInteger();
         this.var_2354 = param1.readInteger();
         return true;
      }
   }
}
