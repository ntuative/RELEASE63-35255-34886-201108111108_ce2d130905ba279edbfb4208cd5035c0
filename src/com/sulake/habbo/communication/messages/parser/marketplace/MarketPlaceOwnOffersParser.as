package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
   
   public class MarketPlaceOwnOffersParser implements IMessageParser
   {
       
      
      private const const_2388:int = 500;
      
      private var _offers:Array;
      
      private var var_2413:int;
      
      public function MarketPlaceOwnOffersParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this._offers = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:* = null;
         this._offers = new Array();
         this.var_2413 = param1.readInteger();
         var _loc10_:int = param1.readInteger();
         var _loc11_:int = 0;
         while(_loc11_ < _loc10_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readInteger();
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            _loc6_ = param1.readString();
            _loc7_ = param1.readInteger();
            _loc8_ = param1.readInteger();
            _loc9_ = param1.readInteger();
            _loc12_ = new MarketPlaceOffer(_loc2_,_loc5_,_loc4_,_loc6_,_loc7_,_loc3_,_loc8_,_loc9_);
            if(_loc11_ < this.const_2388)
            {
               this._offers.push(_loc12_);
            }
            _loc11_++;
         }
         return true;
      }
      
      public function get offers() : Array
      {
         return this._offers;
      }
      
      public function get creditsWaiting() : int
      {
         return this.var_2413;
      }
   }
}
