package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class InstantMessageErrorMessageParser implements IMessageParser
   {
       
      
      private var var_1849:int;
      
      private var _userId:int;
      
      public function InstantMessageErrorMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1849 = param1.readInteger();
         this._userId = param1.readInteger();
         return true;
      }
      
      public function get errorCode() : int
      {
         return this.var_1849;
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
   }
}
