package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CatalogPageMessageProductData
   {
      
      public static const const_65:String = "i";
      
      public static const const_71:String = "s";
      
      public static const const_199:String = "e";
       
      
      private var var_1640:String;
      
      private var var_2927:int;
      
      private var var_1094:String;
      
      private var var_1639:int;
      
      private var var_2076:int;
      
      public function CatalogPageMessageProductData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1640 = param1.readString();
         this.var_2927 = param1.readInteger();
         this.var_1094 = param1.readString();
         this.var_1639 = param1.readInteger();
         this.var_2076 = param1.readInteger();
      }
      
      public function get productType() : String
      {
         return this.var_1640;
      }
      
      public function get furniClassId() : int
      {
         return this.var_2927;
      }
      
      public function get extraParam() : String
      {
         return this.var_1094;
      }
      
      public function get productCount() : int
      {
         return this.var_1639;
      }
      
      public function get expiration() : int
      {
         return this.var_2076;
      }
   }
}
