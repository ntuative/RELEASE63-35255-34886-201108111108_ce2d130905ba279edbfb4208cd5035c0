package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class HabboGroupEntryData
   {
       
      
      private var var_2550:int;
      
      private var var_2555:String;
      
      private var var_2554:String;
      
      private var var_2553:Boolean;
      
      public function HabboGroupEntryData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2550 = param1.readInteger();
         this.var_2555 = param1.readString();
         this.var_2554 = param1.readString();
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
      
      public function get badgeCode() : String
      {
         return this.var_2554;
      }
      
      public function get favourite() : Boolean
      {
         return this.var_2553;
      }
   }
}
