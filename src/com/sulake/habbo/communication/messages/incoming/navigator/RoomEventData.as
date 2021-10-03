package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class RoomEventData implements IDisposable
   {
       
      
      private var var_2087:Boolean;
      
      private var var_2935:int;
      
      private var var_2933:String;
      
      private var var_429:int;
      
      private var var_2934:int;
      
      private var var_2149:String;
      
      private var var_2936:String;
      
      private var var_2932:String;
      
      private var var_953:Array;
      
      private var _disposed:Boolean;
      
      public function RoomEventData(param1:IMessageDataWrapper)
      {
         var _loc5_:* = null;
         this.var_953 = new Array();
         super();
         var _loc2_:String = param1.readString();
         if(_loc2_ == "-1")
         {
            Logger.log("Got null room event");
            this.var_2087 = false;
            return;
         }
         this.var_2087 = true;
         this.var_2935 = int(_loc2_);
         this.var_2933 = param1.readString();
         this.var_429 = int(param1.readString());
         this.var_2934 = param1.readInteger();
         this.var_2149 = param1.readString();
         this.var_2936 = param1.readString();
         this.var_2932 = param1.readString();
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.readString();
            this.var_953.push(_loc5_);
            _loc4_++;
         }
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
      
      public function get ownerAvatarId() : int
      {
         return this.var_2935;
      }
      
      public function get ownerAvatarName() : String
      {
         return this.var_2933;
      }
      
      public function get flatId() : int
      {
         return this.var_429;
      }
      
      public function get eventType() : int
      {
         return this.var_2934;
      }
      
      public function get eventName() : String
      {
         return this.var_2149;
      }
      
      public function get eventDescription() : String
      {
         return this.var_2936;
      }
      
      public function get creationTime() : String
      {
         return this.var_2932;
      }
      
      public function get tags() : Array
      {
         return this.var_953;
      }
      
      public function get exists() : Boolean
      {
         return this.var_2087;
      }
   }
}
