package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class ObjectMessageData
   {
       
      
      private var _id:int = 0;
      
      private var _x:Number = 0;
      
      private var var_185:Number = 0;
      
      private var var_186:Number = 0;
      
      private var var_450:int = 0;
      
      private var var_541:int = 0;
      
      private var var_643:int = 0;
      
      private var _type:int = 0;
      
      private var var_3140:String = "";
      
      private var var_2225:int = -1;
      
      private var _state:int = 0;
      
      private var _data:String = "";
      
      private var var_2462:int = 0;
      
      private var var_2464:Boolean;
      
      private var var_2463:String = null;
      
      private var var_195:Boolean = false;
      
      public function ObjectMessageData(param1:int)
      {
         super();
         this._id = param1;
      }
      
      public function setReadOnly() : void
      {
         this.var_195 = true;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(param1:Number) : void
      {
         if(!this.var_195)
         {
            this._x = param1;
         }
      }
      
      public function get y() : Number
      {
         return this.var_185;
      }
      
      public function set y(param1:Number) : void
      {
         if(!this.var_195)
         {
            this.var_185 = param1;
         }
      }
      
      public function get z() : Number
      {
         return this.var_186;
      }
      
      public function set z(param1:Number) : void
      {
         if(!this.var_195)
         {
            this.var_186 = param1;
         }
      }
      
      public function get dir() : int
      {
         return this.var_450;
      }
      
      public function set dir(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_450 = param1;
         }
      }
      
      public function get sizeX() : int
      {
         return this.var_541;
      }
      
      public function set sizeX(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_541 = param1;
         }
      }
      
      public function get sizeY() : int
      {
         return this.var_643;
      }
      
      public function set sizeY(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_643 = param1;
         }
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set type(param1:int) : void
      {
         if(!this.var_195)
         {
            this._type = param1;
         }
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         if(!this.var_195)
         {
            this._state = param1;
         }
      }
      
      public function get data() : String
      {
         return this._data;
      }
      
      public function set data(param1:String) : void
      {
         if(!this.var_195)
         {
            this._data = param1;
         }
      }
      
      public function get staticClass() : String
      {
         return this.var_2463;
      }
      
      public function set staticClass(param1:String) : void
      {
         if(!this.var_195)
         {
            this.var_2463 = param1;
         }
      }
      
      public function get extra() : int
      {
         return this.var_2225;
      }
      
      public function set extra(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_2225 = param1;
         }
      }
      
      public function get expiryTime() : int
      {
         return this.var_2462;
      }
      
      public function set expiryTime(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_2462 = param1;
         }
      }
      
      public function get knownAsUsable() : Boolean
      {
         return this.var_2464;
      }
      
      public function set knownAsUsable(param1:Boolean) : void
      {
         this.var_2464 = param1;
      }
   }
}
