package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ChargeInfo
   {
       
      
      private var var_2837:int;
      
      private var var_2980:int;
      
      private var var_1200:int;
      
      private var var_1201:int;
      
      private var var_1810:int;
      
      private var var_2981:int;
      
      public function ChargeInfo(param1:IMessageDataWrapper)
      {
         super();
         this.var_2837 = param1.readInteger();
         this.var_2980 = param1.readInteger();
         this.var_1200 = param1.readInteger();
         this.var_1201 = param1.readInteger();
         this.var_1810 = param1.readInteger();
         this.var_2981 = param1.readInteger();
      }
      
      public function get stuffId() : int
      {
         return this.var_2837;
      }
      
      public function get charges() : int
      {
         return this.var_2980;
      }
      
      public function get priceInCredits() : int
      {
         return this.var_1200;
      }
      
      public function get priceInActivityPoints() : int
      {
         return this.var_1201;
      }
      
      public function get chargePatchSize() : int
      {
         return this.var_2981;
      }
      
      public function get activityPointType() : int
      {
         return this.var_1810;
      }
   }
}
