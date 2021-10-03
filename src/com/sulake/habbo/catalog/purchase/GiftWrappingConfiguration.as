package com.sulake.habbo.catalog.purchase
{
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;
   
   public class GiftWrappingConfiguration
   {
       
      
      private var var_1675:Boolean = false;
      
      private var var_2160:int;
      
      private var var_2105:Array;
      
      private var var_888:Array;
      
      private var var_887:Array;
      
      public function GiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:GiftWrappingConfigurationParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         this.var_1675 = _loc2_.isWrappingEnabled;
         this.var_2160 = _loc2_.wrappingPrice;
         this.var_2105 = _loc2_.stuffTypes;
         this.var_888 = _loc2_.boxTypes;
         this.var_887 = _loc2_.ribbonTypes;
      }
      
      public function get isEnabled() : Boolean
      {
         return this.var_1675;
      }
      
      public function get price() : int
      {
         return this.var_2160;
      }
      
      public function get stuffTypes() : Array
      {
         return this.var_2105;
      }
      
      public function get boxTypes() : Array
      {
         return this.var_888;
      }
      
      public function get ribbonTypes() : Array
      {
         return this.var_887;
      }
   }
}
