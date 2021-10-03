package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class FurniListRemoveParser implements IMessageParser
   {
       
      
      private var var_1894:int;
      
      public function FurniListRemoveParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1894 = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get stripId() : int
      {
         return this.var_1894;
      }
   }
}
