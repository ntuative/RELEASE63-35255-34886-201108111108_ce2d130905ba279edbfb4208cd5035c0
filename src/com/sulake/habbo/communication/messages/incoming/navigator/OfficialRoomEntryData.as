package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class OfficialRoomEntryData implements IDisposable
   {
      
      public static const const_1204:int = 1;
      
      public static const const_759:int = 2;
      
      public static const const_893:int = 3;
      
      public static const const_1834:int = 4;
       
      
      private var _index:int;
      
      private var var_2563:String;
      
      private var var_2564:String;
      
      private var var_2562:Boolean;
      
      private var var_2566:String;
      
      private var var_1029:String;
      
      private var var_2565:int;
      
      private var var_2435:int;
      
      private var _type:int;
      
      private var var_2411:String;
      
      private var var_1015:GuestRoomData;
      
      private var var_1014:PublicRoomData;
      
      private var _open:Boolean;
      
      private var _disposed:Boolean;
      
      public function OfficialRoomEntryData(param1:IMessageDataWrapper)
      {
         super();
         this._index = param1.readInteger();
         this.var_2563 = param1.readString();
         this.var_2564 = param1.readString();
         this.var_2562 = param1.readInteger() == 1;
         this.var_2566 = param1.readString();
         this.var_1029 = param1.readString();
         this.var_2565 = param1.readInteger();
         this.var_2435 = param1.readInteger();
         this._type = param1.readInteger();
         if(this._type == const_1204)
         {
            this.var_2411 = param1.readString();
         }
         else if(this._type == const_893)
         {
            this.var_1014 = new PublicRoomData(param1);
         }
         else if(this._type == const_759)
         {
            this.var_1015 = new GuestRoomData(param1);
         }
         else
         {
            this._open = param1.readBoolean();
         }
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         if(this.var_1015 != null)
         {
            this.var_1015.dispose();
            this.var_1015 = null;
         }
         if(this.var_1014 != null)
         {
            this.var_1014.dispose();
            this.var_1014 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function get popupCaption() : String
      {
         return this.var_2563;
      }
      
      public function get popupDesc() : String
      {
         return this.var_2564;
      }
      
      public function get showDetails() : Boolean
      {
         return this.var_2562;
      }
      
      public function get picText() : String
      {
         return this.var_2566;
      }
      
      public function get picRef() : String
      {
         return this.var_1029;
      }
      
      public function get folderId() : int
      {
         return this.var_2565;
      }
      
      public function get tag() : String
      {
         return this.var_2411;
      }
      
      public function get userCount() : int
      {
         return this.var_2435;
      }
      
      public function get guestRoomData() : GuestRoomData
      {
         return this.var_1015;
      }
      
      public function get publicRoomData() : PublicRoomData
      {
         return this.var_1014;
      }
      
      public function get open() : Boolean
      {
         return this._open;
      }
      
      public function toggleOpen() : void
      {
         this._open = !this._open;
      }
      
      public function get maxUsers() : int
      {
         if(this.type == const_1204)
         {
            return 0;
         }
         if(this.type == const_759)
         {
            return this.var_1015.maxUserCount;
         }
         if(this.type == const_893)
         {
            return this.var_1014.maxUsers;
         }
         return 0;
      }
   }
}
