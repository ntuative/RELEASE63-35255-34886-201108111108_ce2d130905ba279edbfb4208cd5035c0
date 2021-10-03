package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class HabboAchievementBonusMessageParser implements IMessageParser
   {
       
      
      private var var_2706:int;
      
      private var _realName:String;
      
      public function HabboAchievementBonusMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2706 = param1.readInteger();
         this._realName = param1.readString();
         return true;
      }
      
      public function get bonusPoints() : int
      {
         return this.var_2706;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
   }
}
