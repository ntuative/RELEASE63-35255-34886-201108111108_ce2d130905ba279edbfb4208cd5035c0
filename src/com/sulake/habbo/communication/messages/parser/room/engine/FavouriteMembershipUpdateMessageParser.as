package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class FavouriteMembershipUpdateMessageParser implements IMessageParser
   {
       
      
      private var var_2596:int;
      
      private var var_2597:int;
      
      private var var_438:int;
      
      public function FavouriteMembershipUpdateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2596 = param1.readInteger();
         this.var_2597 = param1.readInteger();
         this.var_438 = param1.readInteger();
         return true;
      }
      
      public function get roomIndex() : int
      {
         return this.var_2596;
      }
      
      public function get habboGroupId() : int
      {
         return this.var_2597;
      }
      
      public function get status() : int
      {
         return this.var_438;
      }
   }
}
