package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class UserUpdateMessageData
   {
       
      
      private var _id:int = 0;
      
      private var _x:Number = 0;
      
      private var var_185:Number = 0;
      
      private var var_186:Number = 0;
      
      private var var_2568:Number = 0;
      
      private var var_2570:Number = 0;
      
      private var var_2571:Number = 0;
      
      private var var_2567:Number = 0;
      
      private var var_450:int = 0;
      
      private var var_2569:int = 0;
      
      private var var_363:Array;
      
      private var var_2572:Boolean = false;
      
      public function UserUpdateMessageData(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:int, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Array)
      {
         this.var_363 = [];
         super();
         this._id = param1;
         this._x = param2;
         this.var_185 = param3;
         this.var_186 = param4;
         this.var_2568 = param5;
         this.var_450 = param6;
         this.var_2569 = param7;
         this.var_2570 = param8;
         this.var_2571 = param9;
         this.var_2567 = param10;
         this.var_2572 = param11;
         this.var_363 = param12;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this.var_185;
      }
      
      public function get z() : Number
      {
         return this.var_186;
      }
      
      public function get localZ() : Number
      {
         return this.var_2568;
      }
      
      public function get targetX() : Number
      {
         return this.var_2570;
      }
      
      public function get targetY() : Number
      {
         return this.var_2571;
      }
      
      public function get targetZ() : Number
      {
         return this.var_2567;
      }
      
      public function get dir() : int
      {
         return this.var_450;
      }
      
      public function get dirHead() : int
      {
         return this.var_2569;
      }
      
      public function get isMoving() : Boolean
      {
         return this.var_2572;
      }
      
      public function get actions() : Array
      {
         return this.var_363.slice();
      }
   }
}
