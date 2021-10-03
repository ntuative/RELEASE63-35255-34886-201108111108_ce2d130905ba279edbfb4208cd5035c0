package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class NotEnoughBalanceMessageParser implements IMessageParser
   {
       
      
      private var var_2066:int = 0;
      
      private var var_2065:int = 0;
      
      private var var_1810:int = 0;
      
      public function NotEnoughBalanceMessageParser()
      {
         super();
      }
      
      public function get notEnoughCredits() : int
      {
         return this.var_2066;
      }
      
      public function get notEnoughActivityPoints() : int
      {
         return this.var_2065;
      }
      
      public function get activityPointType() : int
      {
         return this.var_1810;
      }
      
      public function flush() : Boolean
      {
         this.var_2066 = 0;
         this.var_2065 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2066 = param1.readInteger();
         this.var_2065 = param1.readInteger();
         this.var_1810 = param1.readInteger();
         return true;
      }
   }
}
