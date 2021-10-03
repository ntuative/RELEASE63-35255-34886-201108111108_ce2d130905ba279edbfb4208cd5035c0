package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class TradingOpenParser implements IMessageParser
   {
       
      
      private var _userID:int;
      
      private var var_2020:Boolean;
      
      private var var_2021:int;
      
      private var var_2019:Boolean;
      
      public function TradingOpenParser()
      {
         super();
      }
      
      public function get userID() : int
      {
         return this._userID;
      }
      
      public function get userCanTrade() : Boolean
      {
         return this.var_2020;
      }
      
      public function get otherUserID() : int
      {
         return this.var_2021;
      }
      
      public function get otherUserCanTrade() : Boolean
      {
         return this.var_2019;
      }
      
      public function flush() : Boolean
      {
         this._userID = -1;
         this.var_2020 = false;
         this.var_2021 = -1;
         this.var_2019 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._userID = param1.readInteger();
         this.var_2020 = param1.readInteger() == 1;
         this.var_2021 = param1.readInteger();
         this.var_2019 = param1.readInteger() == 1;
         return true;
      }
   }
}
