package com.sulake.habbo.communication.messages.outgoing.room.session
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class OpenConnectionMessageComposer implements IMessageComposer
   {
       
      
      private var _roomId:int;
      
      private var var_2521:Boolean;
      
      private var var_2520:int;
      
      public function OpenConnectionMessageComposer(param1:Boolean, param2:int, param3:int = 0)
      {
         super();
         this._roomId = param2;
         this.var_2521 = param1;
         this.var_2520 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [int(this.var_2521),this._roomId,this.var_2520];
      }
   }
}
