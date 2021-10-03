package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class FavouritesMessageParser implements IMessageParser
   {
       
      
      private var var_2043:int;
      
      private var var_1961:Array;
      
      public function FavouritesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         this.var_1961 = new Array();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2043 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.var_1961.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get limit() : int
      {
         return this.var_2043;
      }
      
      public function get favouriteRoomIds() : Array
      {
         return this.var_1961;
      }
   }
}
