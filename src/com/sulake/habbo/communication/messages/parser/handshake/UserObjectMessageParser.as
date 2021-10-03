package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class UserObjectMessageParser implements IMessageParser
   {
       
      
      private var _id:int;
      
      private var _name:String;
      
      private var var_727:String;
      
      private var var_1079:String;
      
      private var var_2577:String;
      
      private var _realName:String;
      
      private var var_2579:int;
      
      private var var_2379:int;
      
      private var var_1414:int;
      
      private var var_935:int;
      
      private var var_2578:Boolean;
      
      public function UserObjectMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._id = int(param1.readString());
         this._name = param1.readString();
         this.var_727 = param1.readString();
         this.var_1079 = param1.readString();
         this.var_2577 = param1.readString();
         this._realName = param1.readString();
         this.var_2579 = param1.readInteger();
         this.var_2379 = param1.readInteger();
         this.var_1414 = param1.readInteger();
         this.var_935 = param1.readInteger();
         this.var_2578 = param1.readBoolean();
         return true;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get figure() : String
      {
         return this.var_727;
      }
      
      public function get sex() : String
      {
         return this.var_1079;
      }
      
      public function get customData() : String
      {
         return this.var_2577;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
      
      public function get directMail() : int
      {
         return this.var_2579;
      }
      
      public function get respectTotal() : int
      {
         return this.var_2379;
      }
      
      public function get respectLeft() : int
      {
         return this.var_1414;
      }
      
      public function get petRespectLeft() : int
      {
         return this.var_935;
      }
      
      public function get streamPublishingAllowed() : Boolean
      {
         return this.var_2578;
      }
   }
}
