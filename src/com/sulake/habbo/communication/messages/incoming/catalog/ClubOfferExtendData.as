package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ClubOfferExtendData extends ClubOfferData
   {
       
      
      private var var_1812:int;
      
      private var var_2458:int;
      
      public function ClubOfferExtendData(param1:IMessageDataWrapper)
      {
         super(param1);
         this.var_1812 = param1.readInteger();
         this.var_2458 = param1.readInteger();
      }
      
      public function get originalPrice() : int
      {
         return this.var_1812;
      }
      
      public function get discountAmount() : int
      {
         return this.var_1812 - this.price;
      }
      
      public function get subscriptionDaysLeft() : int
      {
         return this.var_2458;
      }
   }
}
