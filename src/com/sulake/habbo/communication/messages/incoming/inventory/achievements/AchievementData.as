package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class AchievementData
   {
       
      
      private var _type:int;
      
      private var var_1354:int;
      
      private var var_2439:String;
      
      private var var_1801:int;
      
      private var var_2437:int;
      
      private var var_2438:int;
      
      private var var_1800:int;
      
      private var var_1799:Boolean;
      
      private var _category:String;
      
      private var var_2436:int;
      
      public function AchievementData(param1:IMessageDataWrapper)
      {
         super();
         this._type = param1.readInteger();
         this.var_1354 = param1.readInteger();
         this.var_2439 = param1.readString();
         this.var_1801 = Math.max(1,param1.readInteger());
         this.var_2437 = param1.readInteger();
         this.var_2438 = param1.readInteger();
         this.var_1800 = param1.readInteger();
         this.var_1799 = param1.readBoolean();
         this._category = param1.readString();
         this.var_2436 = param1.readInteger();
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get badgeId() : String
      {
         return this.var_2439;
      }
      
      public function get level() : int
      {
         return this.var_1354;
      }
      
      public function get scoreLimit() : int
      {
         return this.var_1801;
      }
      
      public function get levelRewardPoints() : int
      {
         return this.var_2437;
      }
      
      public function get levelRewardPointType() : int
      {
         return this.var_2438;
      }
      
      public function get currentPoints() : int
      {
         return this.var_1800;
      }
      
      public function get finalLevel() : Boolean
      {
         return this.var_1799;
      }
      
      public function get category() : String
      {
         return this._category;
      }
      
      public function get levelCount() : int
      {
         return this.var_2436;
      }
      
      public function get firstLevelAchieved() : Boolean
      {
         return this.var_1354 > 1 || this.var_1799;
      }
      
      public function setMaxProgress() : void
      {
         this.var_1800 = this.var_1801;
      }
   }
}
