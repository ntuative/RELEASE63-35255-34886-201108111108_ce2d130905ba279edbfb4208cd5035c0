package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class MarketplaceItemStatsParser implements IMessageParser
   {
       
      
      private var var_2334:int;
      
      private var var_2806:int;
      
      private var var_2803:int;
      
      private var _dayOffsets:Array;
      
      private var var_1987:Array;
      
      private var var_1988:Array;
      
      private var var_2805:int;
      
      private var var_2804:int;
      
      public function MarketplaceItemStatsParser()
      {
         super();
      }
      
      public function get averagePrice() : int
      {
         return this.var_2334;
      }
      
      public function get offerCount() : int
      {
         return this.var_2806;
      }
      
      public function get historyLength() : int
      {
         return this.var_2803;
      }
      
      public function get dayOffsets() : Array
      {
         return this._dayOffsets;
      }
      
      public function get averagePrices() : Array
      {
         return this.var_1987;
      }
      
      public function get soldAmounts() : Array
      {
         return this.var_1988;
      }
      
      public function get furniTypeId() : int
      {
         return this.var_2805;
      }
      
      public function get furniCategoryId() : int
      {
         return this.var_2804;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2334 = param1.readInteger();
         this.var_2806 = param1.readInteger();
         this.var_2803 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         this._dayOffsets = [];
         this.var_1987 = [];
         this.var_1988 = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._dayOffsets.push(param1.readInteger());
            this.var_1987.push(param1.readInteger());
            this.var_1988.push(param1.readInteger());
            _loc3_++;
         }
         this.var_2804 = param1.readInteger();
         this.var_2805 = param1.readInteger();
         return true;
      }
   }
}
