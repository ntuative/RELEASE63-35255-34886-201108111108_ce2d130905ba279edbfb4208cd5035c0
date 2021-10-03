package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class OpenPetPackageMessageComposer implements IMessageComposer
   {
       
      
      private var var_236:int;
      
      private var var_2954:String;
      
      public function OpenPetPackageMessageComposer(param1:int, param2:String)
      {
         super();
         this.var_236 = param1;
         this.var_2954 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_236,this.var_2954];
      }
      
      public function dispose() : void
      {
      }
   }
}
