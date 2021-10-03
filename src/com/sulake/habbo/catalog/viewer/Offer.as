package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.IPurchasableOffer;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   
   public class Offer implements IPurchasableOffer
   {
      
      public static const const_1799:String = "pricing_model_unknown";
      
      public static const const_400:String = "pricing_model_single";
      
      public static const const_403:String = "pricing_model_multi";
      
      public static const const_623:String = "pricing_model_bundle";
      
      public static const const_1901:String = "price_type_none";
      
      public static const const_883:String = "price_type_credits";
      
      public static const const_1342:String = "price_type_activitypoints";
      
      public static const const_1279:String = "price_type_credits_and_activitypoints";
       
      
      private var var_781:String;
      
      private var var_1199:String;
      
      private var var_1349:int;
      
      private var var_1809:String;
      
      private var var_1200:int;
      
      private var var_1201:int;
      
      private var var_1810:int;
      
      private var var_250:ICatalogPage;
      
      private var var_638:IProductContainer;
      
      private var _disposed:Boolean = false;
      
      private var _clubLevel:int = 0;
      
      private var var_2455:int;
      
      public function Offer(param1:int, param2:String, param3:int, param4:int, param5:int, param6:int, param7:Array, param8:ICatalogPage)
      {
         super();
         this.var_1349 = param1;
         this.var_1809 = param2;
         this.var_1200 = param3;
         this.var_1201 = param4;
         this.var_1810 = param5;
         this.var_250 = param8;
         this._clubLevel = param6;
         this.analyzePricingModel(param7);
         this.analyzePriceType();
         this.createProductContainer(param7);
      }
      
      public function get clubLevel() : int
      {
         return this._clubLevel;
      }
      
      public function get page() : ICatalogPage
      {
         return this.var_250;
      }
      
      public function get offerId() : int
      {
         return this.var_1349;
      }
      
      public function get localizationId() : String
      {
         return this.var_1809;
      }
      
      public function get priceInCredits() : int
      {
         return this.var_1200;
      }
      
      public function get priceInActivityPoints() : int
      {
         return this.var_1201;
      }
      
      public function get activityPointType() : int
      {
         return this.var_1810;
      }
      
      public function get productContainer() : IProductContainer
      {
         return this.var_638;
      }
      
      public function get pricingModel() : String
      {
         return this.var_781;
      }
      
      public function get priceType() : String
      {
         return this.var_1199;
      }
      
      public function get previewCallbackId() : int
      {
         return this.var_2455;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         this.var_2455 = param1;
      }
      
      public function dispose() : void
      {
         if(this.disposed)
         {
            return;
         }
         this._disposed = true;
         this.var_1349 = 0;
         this.var_1809 = "";
         this.var_1200 = 0;
         this.var_1201 = 0;
         this.var_1810 = 0;
         this.var_250 = null;
         if(this.var_638 != null)
         {
            this.var_638.dispose();
            this.var_638 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      private function createProductContainer(param1:Array) : void
      {
         switch(this.var_781)
         {
            case const_400:
               this.var_638 = new SingleProductContainer(this,param1);
               break;
            case const_403:
               this.var_638 = new MultiProductContainer(this,param1);
               break;
            case const_623:
               this.var_638 = new BundleProductContainer(this,param1);
               break;
            default:
               Logger.log("[Offer] Unknown pricing model" + this.var_781);
         }
      }
      
      private function analyzePricingModel(param1:Array) : void
      {
         var _loc2_:* = null;
         if(param1.length == 1)
         {
            _loc2_ = param1[0];
            if(_loc2_.productCount == 1)
            {
               this.var_781 = const_400;
            }
            else
            {
               this.var_781 = const_403;
            }
         }
         else if(param1.length > 1)
         {
            this.var_781 = const_623;
         }
         else
         {
            this.var_781 = const_1799;
         }
      }
      
      private function analyzePriceType() : void
      {
         if(this.var_1200 > 0 && this.var_1201 > 0)
         {
            this.var_1199 = const_1279;
         }
         else if(this.var_1200 > 0)
         {
            this.var_1199 = const_883;
         }
         else if(this.var_1201 > 0)
         {
            this.var_1199 = const_1342;
         }
         else
         {
            this.var_1199 = const_1901;
         }
      }
      
      public function clone() : Offer
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc1_:Array = new Array();
         var _loc2_:IProductData = this.var_250.viewer.catalog.getProductData(this.localizationId);
         for each(_loc3_ in this.var_638.products)
         {
            _loc4_ = this.var_250.viewer.catalog.getFurnitureData(_loc3_.productClassId,_loc3_.productType);
            _loc5_ = new Product(_loc3_.productType,_loc3_.productClassId,_loc3_.extraParam,_loc3_.productCount,_loc3_.expiration,_loc2_,_loc4_);
            _loc1_.push(_loc5_);
         }
         return new Offer(this.offerId,this.localizationId,this.priceInCredits,this.priceInActivityPoints,this.activityPointType,this.clubLevel,_loc1_,this.page);
      }
   }
}
