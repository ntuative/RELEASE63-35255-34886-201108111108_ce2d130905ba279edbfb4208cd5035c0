package com.sulake.habbo.catalog.marketplace
{
   public class MarketplaceItemStats
   {
       
      
      private var var_2334:int;
      
      private var var_2806:int;
      
      private var var_2803:int;
      
      private var _dayOffsets:Array;
      
      private var var_1987:Array;
      
      private var var_1988:Array;
      
      private var var_2805:int;
      
      private var var_2804:int;
      
      public function MarketplaceItemStats()
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
      
      public function set averagePrice(param1:int) : void
      {
         this.var_2334 = param1;
      }
      
      public function set offerCount(param1:int) : void
      {
         this.var_2806 = param1;
      }
      
      public function set historyLength(param1:int) : void
      {
         this.var_2803 = param1;
      }
      
      public function set dayOffsets(param1:Array) : void
      {
         this._dayOffsets = param1.slice();
      }
      
      public function set averagePrices(param1:Array) : void
      {
         this.var_1987 = param1.slice();
      }
      
      public function set soldAmounts(param1:Array) : void
      {
         this.var_1988 = param1.slice();
      }
      
      public function set furniTypeId(param1:int) : void
      {
         this.var_2805 = param1;
      }
      
      public function set furniCategoryId(param1:int) : void
      {
         this.var_2804 = param1;
      }
   }
}
