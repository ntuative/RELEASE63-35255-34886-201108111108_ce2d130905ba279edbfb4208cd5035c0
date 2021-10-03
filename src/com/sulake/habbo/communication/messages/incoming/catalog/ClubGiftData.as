package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ClubGiftData
   {
       
      
      private var var_1349:int;
      
      private var var_2897:Boolean;
      
      private var var_2484:Boolean;
      
      private var var_2898:int;
      
      public function ClubGiftData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1349 = param1.readInteger();
         this.var_2897 = param1.readBoolean();
         this.var_2898 = param1.readInteger();
         this.var_2484 = param1.readBoolean();
      }
      
      public function get offerId() : int
      {
         return this.var_1349;
      }
      
      public function get isVip() : Boolean
      {
         return this.var_2897;
      }
      
      public function get isSelectable() : Boolean
      {
         return this.var_2484;
      }
      
      public function get daysRequired() : int
      {
         return this.var_2898;
      }
   }
}
