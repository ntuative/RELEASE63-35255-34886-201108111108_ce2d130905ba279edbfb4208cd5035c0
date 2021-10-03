package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ClubOfferData
   {
       
      
      private var var_1349:int;
      
      private var var_1795:String;
      
      private var var_2160:int;
      
      private var _upgrade:Boolean;
      
      private var var_2920:Boolean;
      
      private var var_2917:int;
      
      private var var_2919:int;
      
      private var var_2918:int;
      
      private var var_2921:int;
      
      private var var_2922:int;
      
      public function ClubOfferData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1349 = param1.readInteger();
         this.var_1795 = param1.readString();
         this.var_2160 = param1.readInteger();
         this._upgrade = param1.readBoolean();
         this.var_2920 = param1.readBoolean();
         this.var_2917 = param1.readInteger();
         this.var_2919 = param1.readInteger();
         this.var_2918 = param1.readInteger();
         this.var_2921 = param1.readInteger();
         this.var_2922 = param1.readInteger();
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
   }
}
