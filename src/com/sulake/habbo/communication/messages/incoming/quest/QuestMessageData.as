package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class QuestMessageData
   {
       
      
      private var var_1885:String;
      
      private var var_1889:int;
      
      private var var_1888:int;
      
      private var var_1810:int;
      
      private var _id:int;
      
      private var var_1887:Boolean;
      
      private var _type:String;
      
      private var var_2584:String;
      
      private var var_2585:int;
      
      private var var_1890:String;
      
      private var var_2583:int;
      
      private var var_2582:int;
      
      private var var_1520:int;
      
      private var var_1886:Date;
      
      public function QuestMessageData(param1:IMessageDataWrapper)
      {
         this.var_1886 = new Date();
         super();
         this.var_1885 = param1.readString();
         this.var_1889 = param1.readInteger();
         this.var_1888 = param1.readInteger();
         this.var_1810 = param1.readInteger();
         this._id = param1.readInteger();
         this.var_1887 = param1.readBoolean();
         this._type = param1.readString();
         this.var_2584 = param1.readString();
         this.var_2585 = param1.readInteger();
         this.var_1890 = param1.readString();
         this.var_2583 = param1.readInteger();
         this.var_2582 = param1.readInteger();
         this.var_1520 = param1.readInteger();
      }
      
      public function get campaignCode() : String
      {
         return this.var_1885;
      }
      
      public function get localizationCode() : String
      {
         return this.var_1890;
      }
      
      public function get completedQuestsInCampaign() : int
      {
         return this.var_1889;
      }
      
      public function get questCountInCampaign() : int
      {
         return this.var_1888;
      }
      
      public function get activityPointType() : int
      {
         return this.var_1810;
      }
      
      public function get accepted() : Boolean
      {
         return this.var_1887;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get imageVersion() : String
      {
         return this.var_2584;
      }
      
      public function get rewardCurrencyAmount() : int
      {
         return this.var_2585;
      }
      
      public function get completedSteps() : int
      {
         return this.var_2583;
      }
      
      public function get totalSteps() : int
      {
         return this.var_2582;
      }
      
      public function get waitPeriodSeconds() : int
      {
         if(this.var_1520 < 1)
         {
            return 0;
         }
         var _loc1_:Date = new Date();
         var _loc2_:int = _loc1_.getTime() - this.var_1886.getTime();
         return int(Math.max(0,this.var_1520 - Math.floor(_loc2_ / 1000)));
      }
      
      public function getCampaignLocalizationKey() : String
      {
         return "quests." + this.var_1885;
      }
      
      public function getQuestLocalizationKey() : String
      {
         return this.getCampaignLocalizationKey() + "." + this.var_1890;
      }
      
      public function get completedCampaign() : Boolean
      {
         return this._id < 1;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function set accepted(param1:Boolean) : void
      {
         this.var_1887 = param1;
      }
      
      public function get lastQuestInCampaign() : Boolean
      {
         return this.var_1889 >= this.var_1888;
      }
      
      public function get receiveTime() : Date
      {
         return this.var_1886;
      }
      
      public function set waitPeriodSeconds(param1:int) : void
      {
         this.var_1520 = param1;
      }
   }
}
