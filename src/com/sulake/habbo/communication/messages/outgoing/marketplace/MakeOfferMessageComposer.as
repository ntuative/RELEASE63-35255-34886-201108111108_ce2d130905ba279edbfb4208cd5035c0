package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class MakeOfferMessageComposer implements IMessageComposer, IDisposable
   {
      
      public static const const_2286:int = 1;
      
      public static const const_2259:int = 2;
       
      
      private var var_34:Array;
      
      public function MakeOfferMessageComposer(param1:int, param2:int, param3:int)
      {
         this.var_34 = new Array();
         super();
         this.var_34.push(param1);
         this.var_34.push(param2);
         this.var_34.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.var_34;
      }
      
      public function dispose() : void
      {
         this.var_34 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}
