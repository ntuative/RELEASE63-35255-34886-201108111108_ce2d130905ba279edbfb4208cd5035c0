package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class RoomThumbnailData implements IDisposable
   {
       
      
      private var var_729:int;
      
      private var var_905:int;
      
      private var _objects:Array;
      
      private var _disposed:Boolean;
      
      public function RoomThumbnailData(param1:IMessageDataWrapper)
      {
         var _loc4_:* = null;
         this._objects = new Array();
         super();
         if(param1 == null)
         {
            return;
         }
         this.var_729 = param1.readInteger();
         this.var_905 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new RoomThumbnailObjectData();
            _loc4_.pos = param1.readInteger();
            _loc4_.imgId = param1.readInteger();
            this._objects.push(_loc4_);
            _loc3_++;
         }
         if(this.var_729 == 0)
         {
            this.setDefaults();
         }
      }
      
      private function setDefaults() : void
      {
         this.var_729 = 1;
         this.var_905 = 0;
         var _loc1_:RoomThumbnailObjectData = new RoomThumbnailObjectData();
         _loc1_.pos = 4;
         _loc1_.imgId = 1;
         this._objects.push(_loc1_);
      }
      
      public function getCopy() : RoomThumbnailData
      {
         var _loc2_:* = null;
         var _loc1_:RoomThumbnailData = new RoomThumbnailData(null);
         _loc1_.var_729 = this.var_729;
         _loc1_.var_905 = this.var_905;
         for each(_loc2_ in this._objects)
         {
            _loc1_._objects.push(_loc2_.getCopy());
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         this._objects = null;
      }
      
      public function getAsString() : String
      {
         var _loc2_:* = null;
         var _loc1_:* = this.var_905 + ";";
         _loc1_ += this.var_729 + ";";
         for each(_loc2_ in this._objects)
         {
            _loc1_ += _loc2_.imgId + "," + _loc2_.pos + ";";
         }
         return _loc1_;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get bgImgId() : int
      {
         return this.var_729;
      }
      
      public function get frontImgId() : int
      {
         return this.var_905;
      }
      
      public function get objects() : Array
      {
         return this._objects;
      }
      
      public function set bgImgId(param1:int) : void
      {
         this.var_729 = param1;
      }
      
      public function set frontImgId(param1:int) : void
      {
         this.var_905 = param1;
      }
   }
}
