package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class GuestRoomData implements IDisposable
   {
       
      
      private var var_429:int;
      
      private var var_815:Boolean;
      
      private var var_1073:String;
      
      private var _ownerName:String;
      
      private var var_2364:int;
      
      private var var_2435:int;
      
      private var var_2659:int;
      
      private var var_2158:String;
      
      private var var_2656:int;
      
      private var var_2363:Boolean;
      
      private var var_787:int;
      
      private var var_1713:int;
      
      private var var_2660:String;
      
      private var var_953:Array;
      
      private var var_2657:RoomThumbnailData;
      
      private var var_2661:Boolean;
      
      private var var_2658:Boolean;
      
      private var _disposed:Boolean;
      
      public function GuestRoomData(param1:IMessageDataWrapper)
      {
         var _loc4_:* = null;
         this.var_953 = new Array();
         super();
         this.var_429 = param1.readInteger();
         this.var_815 = param1.readBoolean();
         this.var_1073 = param1.readString();
         this._ownerName = param1.readString();
         this.var_2364 = param1.readInteger();
         this.var_2435 = param1.readInteger();
         this.var_2659 = param1.readInteger();
         this.var_2158 = param1.readString();
         this.var_2656 = param1.readInteger();
         this.var_2363 = param1.readBoolean();
         this.var_787 = param1.readInteger();
         this.var_1713 = param1.readInteger();
         this.var_2660 = param1.readString();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readString();
            this.var_953.push(_loc4_);
            _loc3_++;
         }
         this.var_2657 = new RoomThumbnailData(param1);
         this.var_2661 = param1.readBoolean();
         this.var_2658 = param1.readBoolean();
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         this.var_953 = null;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get flatId() : int
      {
         return this.var_429;
      }
      
      public function get event() : Boolean
      {
         return this.var_815;
      }
      
      public function get roomName() : String
      {
         return this.var_1073;
      }
      
      public function get ownerName() : String
      {
         return this._ownerName;
      }
      
      public function get doorMode() : int
      {
         return this.var_2364;
      }
      
      public function get userCount() : int
      {
         return this.var_2435;
      }
      
      public function get maxUserCount() : int
      {
         return this.var_2659;
      }
      
      public function get description() : String
      {
         return this.var_2158;
      }
      
      public function get srchSpecPrm() : int
      {
         return this.var_2656;
      }
      
      public function get allowTrading() : Boolean
      {
         return this.var_2363;
      }
      
      public function get score() : int
      {
         return this.var_787;
      }
      
      public function get categoryId() : int
      {
         return this.var_1713;
      }
      
      public function get eventCreationTime() : String
      {
         return this.var_2660;
      }
      
      public function get tags() : Array
      {
         return this.var_953;
      }
      
      public function get thumbnail() : RoomThumbnailData
      {
         return this.var_2657;
      }
      
      public function get allowPets() : Boolean
      {
         return this.var_2661;
      }
      
      public function get displayRoomEntryAd() : Boolean
      {
         return this.var_2658;
      }
   }
}
