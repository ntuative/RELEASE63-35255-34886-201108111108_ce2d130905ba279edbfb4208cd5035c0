package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class SignMessageComposer implements IMessageComposer
   {
       
      
      private var var_2820:int;
      
      public function SignMessageComposer(param1:int)
      {
         super();
         this.var_2820 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2820];
      }
      
      public function dispose() : void
      {
      }
   }
}
