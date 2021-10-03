package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RecyclerStatusMessageParser implements IMessageParser
   {
       
      
      private var _recyclerStatus:int = -1;
      
      private var var_1805:int = 0;
      
      public function RecyclerStatusMessageParser()
      {
         super();
      }
      
      public function get recyclerStatus() : int
      {
         return this._recyclerStatus;
      }
      
      public function get recyclerTimeoutSeconds() : int
      {
         return this.var_1805;
      }
      
      public function flush() : Boolean
      {
         this._recyclerStatus = -1;
         this.var_1805 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._recyclerStatus = param1.readInteger();
         this.var_1805 = param1.readInteger();
         return true;
      }
   }
}
