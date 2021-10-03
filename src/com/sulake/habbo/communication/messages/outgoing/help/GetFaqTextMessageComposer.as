package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetFaqTextMessageComposer implements IMessageComposer
   {
       
      
      private var var_2028:int;
      
      public function GetFaqTextMessageComposer(param1:int)
      {
         super();
         this.var_2028 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2028];
      }
      
      public function dispose() : void
      {
      }
   }
}
