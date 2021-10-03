package com.sulake.habbo.catalog.club
{
   import com.sulake.habbo.catalog.IPurchasableOffer;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.catalog.viewer.IProductContainer;
   import com.sulake.habbo.catalog.viewer.Offer;
   
   public class ClubBuyOfferData implements IPurchasableOffer
   {
       
      
      private var var_1349:int;
      
      private var var_1795:String;
      
      private var var_2160:int;
      
      private var _upgrade:Boolean;
      
      private var var_2920:Boolean;
      
      private var var_2917:int;
      
      private var var_2919:int;
      
      private var var_250:ICatalogPage;
      
      private var var_2918:int;
      
      private var var_2921:int;
      
      private var var_2922:int;
      
      private var var_1660:String;
      
      private var var_3024:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function ClubBuyOfferData(param1:int, param2:String, param3:int, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:int, param9:int, param10:int)
      {
         super();
         this.var_1349 = param1;
         this.var_1795 = param2;
         this.var_2160 = param3;
         this._upgrade = param4;
         this.var_2920 = param5;
         this.var_2917 = param6;
         this.var_2919 = param7;
         this.var_2918 = param8;
         this.var_2921 = param9;
         this.var_2922 = param10;
      }
      
      public function dispose() : void
      {
         if(this.disposed)
         {
            return;
         }
         this._disposed = true;
         this.var_250 = null;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get extraParameter() : String
      {
         return this.var_1660;
      }
      
      public function set extraParameter(param1:String) : void
      {
         this.var_1660 = param1;
      }
      
      public function get offerId() : int
      {
         return this.var_1349;
      }
      
      public function get productCode() : String
      {
         return this.var_1795;
      }
      
      public function get price() : int
      {
         return this.var_2160;
      }
      
      public function get upgrade() : Boolean
      {
         return this._upgrade;
      }
      
      public function get vip() : Boolean
      {
         return this.var_2920;
      }
      
      public function get periods() : int
      {
         return this.var_2917;
      }
      
      public function get daysLeftAfterPurchase() : int
      {
         return this.var_2919;
      }
      
      public function get year() : int
      {
         return this.var_2918;
      }
      
      public function get month() : int
      {
         return this.var_2921;
      }
      
      public function get day() : int
      {
         return this.var_2922;
      }
      
      public function get priceInActivityPoints() : int
      {
         return 0;
      }
      
      public function get activityPointType() : int
      {
         return ActivityPointTypeEnum.PIXEL;
      }
      
      public function get priceInCredits() : int
      {
         return this.var_2160;
      }
      
      public function get page() : ICatalogPage
      {
         return this.var_250;
      }
      
      public function get priceType() : String
      {
         return Offer.const_883;
      }
      
      public function get productContainer() : IProductContainer
      {
         return null;
      }
      
      public function get localizationId() : String
      {
         return this.var_1795;
      }
      
      public function set page(param1:ICatalogPage) : void
      {
         this.var_250 = param1;
      }
      
      public function get upgradeHcPeriodToVip() : Boolean
      {
         return this.var_3024;
      }
      
      public function set upgradeHcPeriodToVip(param1:Boolean) : void
      {
         this.var_3024 = param1;
      }
   }
}
