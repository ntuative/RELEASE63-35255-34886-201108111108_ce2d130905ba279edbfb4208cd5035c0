package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
   
   public class FurniListParser implements IMessageParser
   {
       
      
      protected var var_3101:String;
      
      protected var var_3100:int;
      
      protected var var_3099:int;
      
      protected var var_1731:Array;
      
      public function FurniListParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_3101 = param1.readString();
         this.var_3100 = param1.readInteger();
         this.var_3099 = param1.readInteger();
         this.var_1731 = new Array();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_1731.push(this.parseItem(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function parseItem(param1:IMessageDataWrapper) : FurniData
      {
         var _loc14_:* = null;
         var _loc15_:int = 0;
         var _loc2_:int = param1.readInteger();
         var _loc3_:String = param1.readString();
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = param1.readInteger();
         var _loc6_:int = param1.readInteger();
         var _loc7_:String = param1.readString();
         var _loc8_:Boolean = param1.readBoolean();
         var _loc9_:Boolean = param1.readBoolean();
         var _loc10_:Boolean = param1.readBoolean();
         var _loc11_:Boolean = param1.readBoolean();
         var _loc12_:int = param1.readInteger();
         var _loc13_:FurniData = new FurniData(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc10_,_loc8_,_loc9_,_loc11_,_loc12_);
         if(_loc3_ == "S")
         {
            _loc14_ = param1.readString();
            _loc15_ = param1.readInteger();
            _loc13_.setExtraData(_loc14_,_loc15_);
         }
         return _loc13_;
      }
      
      public function flush() : Boolean
      {
         this.var_1731 = null;
         return true;
      }
      
      public function get categoryType() : String
      {
         return this.var_3101;
      }
      
      public function get totalFragments() : int
      {
         return this.var_3100;
      }
      
      public function get fragmentNo() : int
      {
         return this.var_3099;
      }
      
      public function getFurni() : Array
      {
         return this.var_1731;
      }
   }
}
