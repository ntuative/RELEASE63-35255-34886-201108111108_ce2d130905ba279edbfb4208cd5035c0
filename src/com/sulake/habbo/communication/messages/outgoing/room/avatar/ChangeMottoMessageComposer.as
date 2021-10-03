package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class ChangeMottoMessageComposer implements IMessageComposer
   {
       
      
      private var var_1815:String;
      
      public function ChangeMottoMessageComposer(param1:String)
      {
         super();
         this.var_1815 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_1815];
      }
   }
}
