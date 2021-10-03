package com.sulake.habbo.communication.messages.outgoing.sound
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class GetSongInfoMessageComposer implements IMessageComposer, IDisposable
   {
       
      
      private var var_34:Array;
      
      public function GetSongInfoMessageComposer(param1:Array)
      {
         var _loc2_:int = 0;
         this.var_34 = new Array();
         super();
         this.var_34.push(param1.length);
         for each(_loc2_ in param1)
         {
            this.var_34.push(_loc2_);
         }
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
