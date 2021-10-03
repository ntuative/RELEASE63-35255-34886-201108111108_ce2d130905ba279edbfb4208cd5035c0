package com.sulake.habbo.session
{
   public class UserData implements IUserData
   {
       
      
      private var _id:int = -1;
      
      private var _name:String = "";
      
      private var _type:int = 0;
      
      private var var_1079:String = "";
      
      private var var_727:String = "";
      
      private var var_2337:String = "";
      
      private var var_2341:int;
      
      private var var_2338:int = 0;
      
      private var var_2342:String = "";
      
      private var var_2339:int = 0;
      
      private var var_2336:int = 0;
      
      public function UserData(param1:int)
      {
         super();
         this._id = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get achievementScore() : int
      {
         return this.var_2341;
      }
      
      public function set achievementScore(param1:int) : void
      {
         this.var_2341 = param1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set type(param1:int) : void
      {
         this._type = param1;
      }
      
      public function get sex() : String
      {
         return this.var_1079;
      }
      
      public function set sex(param1:String) : void
      {
         this.var_1079 = param1;
      }
      
      public function get figure() : String
      {
         return this.var_727;
      }
      
      public function set figure(param1:String) : void
      {
         this.var_727 = param1;
      }
      
      public function get custom() : String
      {
         return this.var_2337;
      }
      
      public function set custom(param1:String) : void
      {
         this.var_2337 = param1;
      }
      
      public function get webID() : int
      {
         return this.var_2338;
      }
      
      public function set webID(param1:int) : void
      {
         this.var_2338 = param1;
      }
      
      public function get groupID() : String
      {
         return this.var_2342;
      }
      
      public function set groupID(param1:String) : void
      {
         this.var_2342 = param1;
      }
      
      public function get groupStatus() : int
      {
         return this.var_2339;
      }
      
      public function set groupStatus(param1:int) : void
      {
         this.var_2339 = param1;
      }
      
      public function get xp() : int
      {
         return this.var_2336;
      }
      
      public function set xp(param1:int) : void
      {
         this.var_2336 = param1;
      }
   }
}
