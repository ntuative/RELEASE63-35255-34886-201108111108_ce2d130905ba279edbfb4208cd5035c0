package com.sulake.core.assets
{
   public class AssetTypeDeclaration
   {
       
      
      private var var_2831:String;
      
      private var var_2829:Class;
      
      private var var_2830:Class;
      
      private var var_2010:Array;
      
      public function AssetTypeDeclaration(param1:String, param2:Class, param3:Class, ... rest)
      {
         super();
         this.var_2831 = param1;
         this.var_2829 = param2;
         this.var_2830 = param3;
         if(rest == null)
         {
            this.var_2010 = new Array();
         }
         else
         {
            this.var_2010 = rest;
         }
      }
      
      public function get mimeType() : String
      {
         return this.var_2831;
      }
      
      public function get assetClass() : Class
      {
         return this.var_2829;
      }
      
      public function get loaderClass() : Class
      {
         return this.var_2830;
      }
      
      public function get fileTypes() : Array
      {
         return this.var_2010;
      }
   }
}
