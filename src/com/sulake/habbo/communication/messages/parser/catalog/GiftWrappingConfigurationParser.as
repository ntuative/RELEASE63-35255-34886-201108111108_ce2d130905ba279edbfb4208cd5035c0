package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class GiftWrappingConfigurationParser implements IMessageParser
   {
       
      
      private var var_3053:Boolean;
      
      private var var_3054:int;
      
      private var var_2105:Array;
      
      private var var_888:Array;
      
      private var var_887:Array;
      
      public function GiftWrappingConfigurationParser()
      {
         super();
      }
      
      public function get isWrappingEnabled() : Boolean
      {
         return this.var_3053;
      }
      
      public function get wrappingPrice() : int
      {
         return this.var_3054;
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
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         this.var_2105 = [];
         this.var_888 = [];
         this.var_887 = [];
         this.var_3053 = param1.readBoolean();
         this.var_3054 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.var_2105.push(param1.readInteger());
            _loc2_++;
         }
         _loc3_ = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.var_888.push(param1.readInteger());
            _loc2_++;
         }
         _loc3_ = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.var_887.push(param1.readInteger());
            _loc2_++;
         }
         return true;
      }
   }
}
