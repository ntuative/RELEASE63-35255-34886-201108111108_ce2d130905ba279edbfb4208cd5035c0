package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CatalogPageMessageOfferData
   {
       
      
      private var var_1349:int;
      
      private var var_1809:String;
      
      private var var_1200:int;
      
      private var var_1201:int;
      
      private var var_1810:int;
      
      private var _clubLevel:int;
      
      private var var_1261:Array;
      
      public function CatalogPageMessageOfferData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1349 = param1.readInteger();
         this.var_1809 = param1.readString();
         this.var_1200 = param1.readInteger();
         this.var_1201 = param1.readInteger();
         this.var_1810 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         this.var_1261 = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_1261.push(new CatalogPageMessageProductData(param1));
            _loc3_++;
         }
         this._clubLevel = param1.readInteger();
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
      
      public function get products() : Array
      {
         return this.var_1261;
      }
      
      public function get activityPointType() : int
      {
         return this.var_1810;
      }
      
      public function get clubLevel() : int
      {
         return this._clubLevel;
      }
   }
}
