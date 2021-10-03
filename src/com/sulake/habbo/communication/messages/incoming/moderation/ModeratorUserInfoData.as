package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class ModeratorUserInfoData
   {
       
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var var_2720:int;
      
      private var var_2718:int;
      
      private var var_777:Boolean;
      
      private var var_2722:int;
      
      private var var_2721:int;
      
      private var var_2719:int;
      
      private var var_2723:int;
      
      public function ModeratorUserInfoData(param1:IMessageDataWrapper)
      {
         super();
         this._userId = param1.readInteger();
         this._userName = param1.readString();
         this.var_2720 = param1.readInteger();
         this.var_2718 = param1.readInteger();
         this.var_777 = param1.readBoolean();
         this.var_2722 = param1.readInteger();
         this.var_2721 = param1.readInteger();
         this.var_2719 = param1.readInteger();
         this.var_2723 = param1.readInteger();
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function get minutesSinceRegistration() : int
      {
         return this.var_2720;
      }
      
      public function get minutesSinceLastLogin() : int
      {
         return this.var_2718;
      }
      
      public function get online() : Boolean
      {
         return this.var_777;
      }
      
      public function get method_13() : int
      {
         return this.var_2722;
      }
      
      public function get abusiveCfhCount() : int
      {
         return this.var_2721;
      }
      
      public function get cautionCount() : int
      {
         return this.var_2719;
      }
      
      public function get banCount() : int
      {
         return this.var_2723;
      }
   }
}
