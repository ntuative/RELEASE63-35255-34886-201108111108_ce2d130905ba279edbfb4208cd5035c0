package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class HabboGroupDetailsData
   {
      
      public static const const_2011:int = 0;
      
      public static const const_2170:int = 1;
      
      public static const const_1875:int = 2;
       
      
      private var var_2550:int;
      
      private var var_2555:String;
      
      private var var_2158:String;
      
      private var var_2554:String;
      
      private var _roomId:int = -1;
      
      private var var_1073:String = "";
      
      private var var_438:int;
      
      private var var_2908:int;
      
      private var var_2553:Boolean;
      
      public function HabboGroupDetailsData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2550 = param1.readInteger();
         this.var_2555 = param1.readString();
         this.var_2158 = param1.readString();
         this.var_2554 = param1.readString();
         this._roomId = param1.readInteger();
         this.var_1073 = param1.readString();
         this.var_438 = param1.readInteger();
         this.var_2908 = param1.readInteger();
         this.var_2553 = param1.readBoolean();
      }
      
      public function get groupId() : int
      {
         return this.var_2550;
      }
      
      public function get groupName() : String
      {
         return this.var_2555;
      }
      
      public function get description() : String
      {
         return this.var_2158;
      }
      
      public function get badgeCode() : String
      {
         return this.var_2554;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomName() : String
      {
         return this.var_1073;
      }
      
      public function get status() : int
      {
         return this.var_438;
      }
      
      public function get totalMembers() : int
      {
         return this.var_2908;
      }
      
      public function get favourite() : Boolean
      {
         return this.var_2553;
      }
   }
}
