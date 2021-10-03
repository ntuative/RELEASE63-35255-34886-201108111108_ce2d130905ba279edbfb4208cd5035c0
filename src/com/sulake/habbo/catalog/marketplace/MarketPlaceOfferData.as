package com.sulake.habbo.catalog.marketplace
{
   import flash.display.BitmapData;
   
   public class MarketPlaceOfferData implements IMarketPlaceOfferData
   {
      
      public static const const_108:int = 1;
      
      public static const const_75:int = 2;
       
      
      private var var_1349:int;
      
      private var _furniId:int;
      
      private var var_2335:int;
      
      private var var_2276:String;
      
      private var var_2160:int;
      
      private var var_2334:int;
      
      private var var_3012:int;
      
      private var var_438:int;
      
      private var var_2333:int = -1;
      
      private var var_2159:int;
      
      private var var_49:BitmapData;
      
      public function MarketPlaceOfferData(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:int = -1)
      {
         super();
         this.var_1349 = param1;
         this._furniId = param2;
         this.var_2335 = param3;
         this.var_2276 = param4;
         this.var_2160 = param5;
         this.var_438 = param6;
         this.var_2334 = param7;
         this.var_2159 = param8;
      }
      
      public function dispose() : void
      {
         if(this.var_49)
         {
            this.var_49.dispose();
            this.var_49 = null;
         }
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
      
      public function get averagePrice() : int
      {
         return this.var_2334;
      }
      
      public function get image() : BitmapData
      {
         return this.var_49;
      }
      
      public function set image(param1:BitmapData) : void
      {
         if(this.var_49 != null)
         {
            this.var_49.dispose();
         }
         this.var_49 = param1;
      }
      
      public function set imageCallback(param1:int) : void
      {
         this.var_3012 = param1;
      }
      
      public function get imageCallback() : int
      {
         return this.var_3012;
      }
      
      public function get status() : int
      {
         return this.var_438;
      }
      
      public function get timeLeftMinutes() : int
      {
         return this.var_2333;
      }
      
      public function set timeLeftMinutes(param1:int) : void
      {
         this.var_2333 = param1;
      }
      
      public function set price(param1:int) : void
      {
         this.var_2160 = param1;
      }
      
      public function set offerId(param1:int) : void
      {
         this.var_1349 = param1;
      }
      
      public function get offerCount() : int
      {
         return this.var_2159;
      }
      
      public function set offerCount(param1:int) : void
      {
         this.var_2159 = param1;
      }
   }
}
