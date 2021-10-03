package com.sulake.habbo.friendbar.data
{
   public class FriendEntity implements IFriendEntity
   {
      
      private static var var_1311:int = 0;
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var var_1123:int;
      
      private var var_777:Boolean;
      
      private var _allowFollow:Boolean;
      
      private var var_727:String;
      
      private var var_1713:int;
      
      private var var_1815:String;
      
      private var var_1778:String;
      
      private var _realName:String;
      
      private var var_1027:Vector.<FriendNotification>;
      
      private var var_2846:int = -1;
      
      public function FriendEntity(param1:int, param2:String, param3:String, param4:String, param5:int, param6:Boolean, param7:Boolean, param8:String, param9:int, param10:String)
      {
         super();
         this._id = param1;
         this._name = param2;
         this._realName = param3;
         this.var_1815 = param4;
         this.var_1123 = param5;
         this.var_777 = param6;
         this._allowFollow = param7;
         this.var_727 = param8;
         this.var_1713 = param9;
         this.var_1778 = param10;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get gender() : int
      {
         return this.var_1123;
      }
      
      public function get online() : Boolean
      {
         return this.var_777;
      }
      
      public function get allowFollow() : Boolean
      {
         return this._allowFollow;
      }
      
      public function get figure() : String
      {
         return this.var_727;
      }
      
      public function get categoryId() : int
      {
         return this.var_1713;
      }
      
      public function get motto() : String
      {
         return this.var_1815;
      }
      
      public function get lastAccess() : String
      {
         return this.var_1778;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
      
      public function get logEventId() : int
      {
         return this.var_2846;
      }
      
      public function get notifications() : Vector.<FriendNotification>
      {
         if(!this.var_1027)
         {
            this.var_1027 = new Vector.<FriendNotification>();
         }
         return this.var_1027;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function set gender(param1:int) : void
      {
         this.var_1123 = param1;
      }
      
      public function set online(param1:Boolean) : void
      {
         this.var_777 = param1;
      }
      
      public function set allowFollow(param1:Boolean) : void
      {
         this._allowFollow = param1;
      }
      
      public function set figure(param1:String) : void
      {
         this.var_727 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         this.var_1713 = param1;
      }
      
      public function set motto(param1:String) : void
      {
         this.var_1815 = param1;
      }
      
      public function set lastAccess(param1:String) : void
      {
         this.var_1778 = param1;
      }
      
      public function set realName(param1:String) : void
      {
         this._realName = param1;
      }
      
      public function set logEventId(param1:int) : void
      {
         this.var_2846 = param1;
      }
      
      public function getNextLogEventId() : int
      {
         return ++var_1311;
      }
   }
}
