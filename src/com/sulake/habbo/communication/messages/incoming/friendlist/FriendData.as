package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class FriendData
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var var_1123:int;
      
      private var var_777:Boolean;
      
      private var var_1814:Boolean;
      
      private var var_727:String;
      
      private var var_1713:int;
      
      private var var_1815:String;
      
      private var var_1778:String;
      
      private var _realName:String;
      
      private var var_2576:String;
      
      public function FriendData(param1:IMessageDataWrapper)
      {
         super();
         this._id = param1.readInteger();
         this._name = param1.readString();
         this.var_1123 = param1.readInteger();
         this.var_777 = param1.readBoolean();
         this.var_1814 = param1.readBoolean();
         this.var_727 = param1.readString();
         this.var_1713 = param1.readInteger();
         this.var_1815 = param1.readString();
         this.var_1778 = param1.readString();
         this._realName = param1.readString();
         this.var_2576 = param1.readString();
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
      
      public function get followingAllowed() : Boolean
      {
         return this.var_1814;
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
      
      public function get facebookId() : String
      {
         return this.var_2576;
      }
   }
}
