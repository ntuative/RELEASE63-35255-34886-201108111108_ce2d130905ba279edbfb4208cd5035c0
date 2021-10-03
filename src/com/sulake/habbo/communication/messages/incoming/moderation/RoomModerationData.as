package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class RoomModerationData implements IDisposable
   {
       
      
      private var var_429:int;
      
      private var var_2435:int;
      
      private var var_3023:Boolean;
      
      private var var_2617:int;
      
      private var _ownerName:String;
      
      private var var_139:RoomData;
      
      private var var_815:RoomData;
      
      private var _disposed:Boolean;
      
      public function RoomModerationData(param1:IMessageDataWrapper)
      {
         super();
         this.var_429 = param1.readInteger();
         this.var_2435 = param1.readInteger();
         this.var_3023 = param1.readBoolean();
         this.var_2617 = param1.readInteger();
         this._ownerName = param1.readString();
         this.var_139 = new RoomData(param1);
         this.var_815 = new RoomData(param1);
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         if(this.var_139 != null)
         {
            this.var_139.dispose();
            this.var_139 = null;
         }
         if(this.var_815 != null)
         {
            this.var_815.dispose();
            this.var_815 = null;
         }
      }
      
      public function get flatId() : int
      {
         return this.var_429;
      }
      
      public function get userCount() : int
      {
         return this.var_2435;
      }
      
      public function get ownerInRoom() : Boolean
      {
         return this.var_3023;
      }
      
      public function get ownerId() : int
      {
         return this.var_2617;
      }
      
      public function get ownerName() : String
      {
         return this._ownerName;
      }
      
      public function get room() : RoomData
      {
         return this.var_139;
      }
      
      public function get event() : RoomData
      {
         return this.var_815;
      }
   }
}
