package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   
   public class QuestController implements IDisposable, IUpdateReceiver
   {
       
      
      private var var_50:HabboQuestEngine;
      
      private var var_575:QuestsList;
      
      private var var_479:QuestDetails;
      
      private var _questCompleted:QuestCompleted;
      
      private var var_401:QuestTracker;
      
      private var var_703:NextQuestTimer;
      
      public function QuestController(param1:HabboQuestEngine)
      {
         super();
         this.var_50 = param1;
         this.var_401 = new QuestTracker(this.var_50);
         this.var_575 = new QuestsList(this.var_50);
         this.var_479 = new QuestDetails(this.var_50);
         this._questCompleted = new QuestCompleted(this.var_50);
         this.var_703 = new NextQuestTimer(this.var_50);
      }
      
      public function onToolbarClick() : void
      {
         this.var_575.onToolbarClick();
      }
      
      public function onQuests(param1:Array, param2:Boolean) : void
      {
         this.var_575.onQuests(param1,param2);
      }
      
      public function onQuest(param1:QuestMessageData) : void
      {
         this.var_401.onQuest(param1);
         this.var_479.onQuest(param1);
         this._questCompleted.onQuest(param1);
         this.var_703.onQuest(param1);
      }
      
      public function onQuestCompleted(param1:QuestMessageData) : void
      {
         this.var_401.onQuestCompleted(param1);
         this.var_479.onQuestCompleted(param1);
         this._questCompleted.onQuestCompleted(param1);
      }
      
      public function onQuestCancelled() : void
      {
         this.var_401.onQuestCancelled();
         this.var_479.onQuestCancelled();
         this._questCompleted.onQuestCancelled();
         this.var_703.onQuestCancelled();
      }
      
      public function onRoomEnter() : void
      {
         this.var_401.onRoomEnter();
      }
      
      public function onRoomExit() : void
      {
         this.var_575.onRoomExit();
         this.var_401.onRoomExit();
         this.var_479.onRoomExit();
         this.var_703.onRoomExit();
      }
      
      public function update(param1:uint) : void
      {
         this._questCompleted.update(param1);
         this.var_401.update(param1);
         this.var_703.update(param1);
         this.var_575.update(param1);
         this.var_479.update(param1);
      }
      
      public function dispose() : void
      {
         this.var_50 = null;
         if(this.var_575)
         {
            this.var_575.dispose();
            this.var_575 = null;
         }
         if(this.var_401)
         {
            this.var_401.dispose();
            this.var_401 = null;
         }
         if(this.var_479)
         {
            this.var_479.dispose();
            this.var_479 = null;
         }
         if(this._questCompleted)
         {
            this._questCompleted.dispose();
            this._questCompleted = null;
         }
         if(this.var_703)
         {
            this.var_703.dispose();
            this.var_703 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this.var_50 == null;
      }
      
      public function get questsList() : QuestsList
      {
         return this.var_575;
      }
      
      public function get questDetails() : QuestDetails
      {
         return this.var_479;
      }
      
      public function get questTracker() : QuestTracker
      {
         return this.var_401;
      }
   }
}
