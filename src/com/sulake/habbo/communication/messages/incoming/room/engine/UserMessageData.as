package com.sulake.habbo.communication.messages.incoming.room.engine
{
   public class UserMessageData
   {
      
      public static const const_1263:String = "M";
      
      public static const const_1968:String = "F";
       
      
      private var _id:int = 0;
      
      private var _x:Number = 0;
      
      private var var_185:Number = 0;
      
      private var var_186:Number = 0;
      
      private var var_450:int = 0;
      
      private var _name:String = "";
      
      private var var_1736:int = 0;
      
      private var var_1079:String = "";
      
      private var var_727:String = "";
      
      private var var_2337:String = "";
      
      private var var_2341:int;
      
      private var var_2338:int = 0;
      
      private var var_2342:String = "";
      
      private var var_2339:int = 0;
      
      private var var_2336:int = 0;
      
      private var var_2340:String = "";
      
      private var var_195:Boolean = false;
      
      public function UserMessageData(param1:int)
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
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         if(!this.var_195)
         {
            this._name = param1;
         }
      }
      
      public function get userType() : int
      {
         return this.var_1736;
      }
      
      public function set userType(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_1736 = param1;
         }
      }
      
      public function get sex() : String
      {
         return this.var_1079;
      }
      
      public function set sex(param1:String) : void
      {
         if(!this.var_195)
         {
            this.var_1079 = param1;
         }
      }
      
      public function get figure() : String
      {
         return this.var_727;
      }
      
      public function set figure(param1:String) : void
      {
         if(!this.var_195)
         {
            this.var_727 = param1;
         }
      }
      
      public function get custom() : String
      {
         return this.var_2337;
      }
      
      public function set custom(param1:String) : void
      {
         if(!this.var_195)
         {
            this.var_2337 = param1;
         }
      }
      
      public function get achievementScore() : int
      {
         return this.var_2341;
      }
      
      public function set achievementScore(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_2341 = param1;
         }
      }
      
      public function get webID() : int
      {
         return this.var_2338;
      }
      
      public function set webID(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_2338 = param1;
         }
      }
      
      public function get groupID() : String
      {
         return this.var_2342;
      }
      
      public function set groupID(param1:String) : void
      {
         if(!this.var_195)
         {
            this.var_2342 = param1;
         }
      }
      
      public function get groupStatus() : int
      {
         return this.var_2339;
      }
      
      public function set groupStatus(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_2339 = param1;
         }
      }
      
      public function get xp() : int
      {
         return this.var_2336;
      }
      
      public function set xp(param1:int) : void
      {
         if(!this.var_195)
         {
            this.var_2336 = param1;
         }
      }
      
      public function get subType() : String
      {
         return this.var_2340;
      }
      
      public function set subType(param1:String) : void
      {
         if(!this.var_195)
         {
            this.var_2340 = param1;
         }
      }
   }
}
