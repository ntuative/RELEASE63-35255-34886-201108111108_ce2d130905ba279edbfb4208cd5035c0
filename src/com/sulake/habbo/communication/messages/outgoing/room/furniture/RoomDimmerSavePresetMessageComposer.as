package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class RoomDimmerSavePresetMessageComposer implements IMessageComposer
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_2851:int;
      
      private var var_2849:int;
      
      private var var_2990:String;
      
      private var var_2989:int;
      
      private var var_2988:Boolean;
      
      public function RoomDimmerSavePresetMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:int = 0, param7:int = 0)
      {
         super();
         this._roomId = param6;
         this._roomCategory = param7;
         this.var_2851 = param1;
         this.var_2849 = param2;
         this.var_2990 = param3;
         this.var_2989 = param4;
         this.var_2988 = param5;
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_2851,this.var_2849,this.var_2990,this.var_2989,int(this.var_2988)];
      }
      
      public function dispose() : void
      {
      }
   }
}
