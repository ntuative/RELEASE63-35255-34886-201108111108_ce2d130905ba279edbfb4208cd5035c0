package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class BadgesParser implements IMessageParser
   {
       
      
      private var var_1998:Array;
      
      private var var_1997:Array;
      
      private var var_1310:Map;
      
      public function BadgesParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         this.var_1998 = new Array();
         this.var_1310 = new Map();
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            this.var_1310.add(_loc3_,_loc2_);
            this.var_1998.push(_loc3_);
            _loc5_++;
         }
         this.var_1997 = new Array();
         var _loc6_:int = param1.readInteger();
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = param1.readInteger();
            _loc3_ = param1.readString();
            this.var_1997.push(_loc3_);
            _loc7_++;
         }
         return true;
      }
      
      public function getBadgeId(param1:String) : int
      {
         return this.var_1310.getValue(param1);
      }
      
      public function getAllBadgeCodes() : Array
      {
         return this.var_1998;
      }
      
      public function getActiveBadgeCodes() : Array
      {
         return this.var_1997;
      }
   }
}
