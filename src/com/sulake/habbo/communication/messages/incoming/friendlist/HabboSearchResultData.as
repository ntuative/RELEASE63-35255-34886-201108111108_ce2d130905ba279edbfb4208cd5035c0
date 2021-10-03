package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class HabboSearchResultData
   {
       
      
      private var var_2456:int;
      
      private var var_1777:String;
      
      private var var_2383:String;
      
      private var var_2647:Boolean;
      
      private var var_2646:Boolean;
      
      private var var_2645:int;
      
      private var var_2382:String;
      
      private var var_2648:String;
      
      private var _realName:String;
      
      public function HabboSearchResultData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2456 = param1.readInteger();
         this.var_1777 = param1.readString();
         this.var_2383 = param1.readString();
         this.var_2647 = param1.readBoolean();
         this.var_2646 = param1.readBoolean();
         param1.readString();
         this.var_2645 = param1.readInteger();
         this.var_2382 = param1.readString();
         this.var_2648 = param1.readString();
         this._realName = param1.readString();
      }
      
      public function get avatarId() : int
      {
         return this.var_2456;
      }
      
      public function get avatarName() : String
      {
         return this.var_1777;
      }
      
      public function get avatarMotto() : String
      {
         return this.var_2383;
      }
      
      public function get isAvatarOnline() : Boolean
      {
         return this.var_2647;
      }
      
      public function get canFollow() : Boolean
      {
         return this.var_2646;
      }
      
      public function get avatarGender() : int
      {
         return this.var_2645;
      }
      
      public function get avatarFigure() : String
      {
         return this.var_2382;
      }
      
      public function get lastOnlineDate() : String
      {
         return this.var_2648;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
   }
}
