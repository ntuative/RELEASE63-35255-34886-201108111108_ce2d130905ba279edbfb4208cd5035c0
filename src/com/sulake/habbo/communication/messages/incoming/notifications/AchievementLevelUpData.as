package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class AchievementLevelUpData
   {
       
      
      private var _type:int;
      
      private var var_1354:int;
      
      private var var_2187:int;
      
      private var var_2437:int;
      
      private var var_2438:int;
      
      private var var_2706:int;
      
      private var var_2439:int;
      
      private var var_2554:String = "";
      
      private var var_2772:String = "";
      
      private var var_2771:int;
      
      private var _category:String;
      
      public function AchievementLevelUpData(param1:IMessageDataWrapper)
      {
         super();
         this._type = param1.readInteger();
         this.var_1354 = param1.readInteger();
         this.var_2439 = param1.readInteger();
         this.var_2554 = param1.readString();
         this.var_2187 = param1.readInteger();
         this.var_2437 = param1.readInteger();
         this.var_2438 = param1.readInteger();
         this.var_2706 = param1.readInteger();
         this.var_2771 = param1.readInteger();
         this.var_2772 = param1.readString();
         this._category = param1.readString();
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get level() : int
      {
         return this.var_1354;
      }
      
      public function get points() : int
      {
         return this.var_2187;
      }
      
      public function get levelRewardPoints() : int
      {
         return this.var_2437;
      }
      
      public function get levelRewardPointType() : int
      {
         return this.var_2438;
      }
      
      public function get bonusPoints() : int
      {
         return this.var_2706;
      }
      
      public function get badgeId() : int
      {
         return this.var_2439;
      }
      
      public function get badgeCode() : String
      {
         return this.var_2554;
      }
      
      public function get removedBadgeCode() : String
      {
         return this.var_2772;
      }
      
      public function get achievementID() : int
      {
         return this.var_2771;
      }
      
      public function get category() : String
      {
         return this._category;
      }
   }
}
