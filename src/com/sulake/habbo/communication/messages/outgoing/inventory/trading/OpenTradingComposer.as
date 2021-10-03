package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class OpenTradingComposer implements IMessageComposer
   {
       
      
      private var var_2878:int;
      
      public function OpenTradingComposer(param1:int)
      {
         super();
         this.var_2878 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2878];
      }
   }
}
