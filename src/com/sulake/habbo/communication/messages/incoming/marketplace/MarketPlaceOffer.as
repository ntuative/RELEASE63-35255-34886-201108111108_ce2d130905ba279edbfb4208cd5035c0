package com.sulake.habbo.communication.messages.incoming.marketplace
{
   public class MarketPlaceOffer
   {
       
      
      private var var_1349:int;
      
      private var _furniId:int;
      
      private var var_2335:int;
      
      private var var_2276:String;
      
      private var var_2160:int;
      
      private var var_438:int;
      
      private var var_2333:int = -1;
      
      private var var_2334:int;
      
      private var var_2159:int;
      
      public function MarketPlaceOffer(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int, param9:int = -1)
      {
         super();
         this.var_1349 = param1;
         this._furniId = param2;
         this.var_2335 = param3;
         this.var_2276 = param4;
         this.var_2160 = param5;
         this.var_438 = param6;
         this.var_2333 = param7;
         this.var_2334 = param8;
         this.var_2159 = param9;
      }
      
      public function get offerId() : int
      {
         return this.var_1349;
      }
      
      public function get furniId() : int
      {
         return this._furniId;
      }
      
      public function get furniType() : int
      {
         return this.var_2335;
      }
      
      public function get stuffData() : String
      {
         return this.var_2276;
      }
      
      public function get price() : int
      {
         return this.var_2160;
      }
      
      public function get status() : int
      {
         return this.var_438;
      }
      
      public function get timeLeftMinutes() : int
      {
         return this.var_2333;
      }
      
      public function get averagePrice() : int
      {
         return this.var_2334;
      }
      
      public function get offerCount() : int
      {
         return this.var_2159;
      }
   }
}
