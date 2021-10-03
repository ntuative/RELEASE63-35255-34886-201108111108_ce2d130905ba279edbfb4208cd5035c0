package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
   
   public class QuestCompleted implements IDisposable
   {
      
      private static const const_1122:int = 2000;
      
      private static const const_1581:int = 5;
      
      private static const const_1582:int = 31;
       
      
      private var _window:IFrameWindow;
      
      private var var_50:HabboQuestEngine;
      
      private var var_136:QuestMessageData;
      
      private var var_698:Animation;
      
      private var var_1284:int;
      
      public function QuestCompleted(param1:HabboQuestEngine)
      {
         super();
         this.var_50 = param1;
      }
      
      public function dispose() : void
      {
         this.var_50 = null;
         this.var_136 = null;
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
         if(this.var_698)
         {
            this.var_698.dispose();
            this.var_698 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._window == null;
      }
      
      public function onQuest(param1:QuestMessageData) : void
      {
         this.close();
      }
      
      public function onQuestCancelled() : void
      {
         this.close();
      }
      
      public function onQuestCompleted(param1:QuestMessageData) : void
      {
         this.prepare(param1);
         this.var_1284 = const_1122;
      }
      
      private function close() : void
      {
         if(this._window)
         {
            this._window.visible = false;
         }
      }
      
      private function onNextQuest(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this._window.visible = false;
         this.var_50.questController.questDetails.openForNextQuest = this.var_50.configuration.getKey("questing.showDetailsForNextQuest") == "true";
         this.var_50.send(new OpenQuestTrackerMessageComposer());
      }
      
      private function onMoreQuests(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this._window.visible = false;
            this.var_50.send(new GetQuestsMessageComposer());
         }
      }
      
      public function prepare(param1:QuestMessageData) : void
      {
         this.var_136 = param1;
         if(this._window == null)
         {
            this._window = IFrameWindow(this.var_50.getXmlWindow("QuestCompletedDialog"));
            this._window.findChildByTag("close").procedure = this.onNextQuest;
            this._window.findChildByName("next_quest_button").procedure = this.onNextQuest;
            this._window.findChildByName("more_quests_button").procedure = this.onMoreQuests;
            new PendingImage(this.var_50,this._window.findChildByName("reward_icon"),"quest_doneicon");
            new PendingImage(this.var_50,this._window.findChildByName("campaign_reward_icon"),"ach_receive_star");
            this._window.findChildByName("catalog_link_region").procedure = this.onCatalogLink;
            this.var_698 = this.var_50.getTwinkleAnimation(this._window);
         }
         this._window.findChildByName("catalog_link_txt").caption = this.var_50.localization.getKey("quests.completed.cataloglink." + this.var_136.activityPointType);
         var _loc2_:String = "quests.completed.reward." + this.var_136.activityPointType;
         this.var_50.localization.registerParameter(_loc2_,"amount",this.var_136.rewardCurrencyAmount.toString());
         this._window.findChildByName("reward_txt").caption = this.var_50.localization.getKey(_loc2_,_loc2_);
         this._window.visible = false;
         this._window.findChildByName("congrats_txt").caption = this.var_50.localization.getKey(!!this.var_136.lastQuestInCampaign ? "quests.completed.campaign.caption" : "quests.completed.quest.caption");
         this._window.findChildByName("more_quests_button").visible = this.var_136.lastQuestInCampaign;
         this._window.findChildByName("campaign_reward_icon").visible = this.var_136.lastQuestInCampaign;
         this._window.findChildByName("catalog_link_region").visible = !this.var_136.lastQuestInCampaign;
         this._window.findChildByName("next_quest_button").visible = !this.var_136.lastQuestInCampaign;
         this._window.findChildByName("reward_icon").visible = !this.var_136.lastQuestInCampaign;
         this._window.findChildByName("campaign_reward_icon").visible = this.var_136.lastQuestInCampaign;
         this._window.findChildByName("campaign_pic_bitmap").visible = this.var_136.lastQuestInCampaign;
         this.setWindowTitle(!!this.var_136.lastQuestInCampaign ? "quests.completed.campaign.title" : "quests.completed.quest.title");
         this.var_50.setupCampaignImage(this._window,param1,this.var_136.lastQuestInCampaign);
         var _loc3_:ITextWindow = ITextWindow(this._window.findChildByName("desc_txt"));
         var _loc4_:int = _loc3_.height;
         this.setDesc(this.var_136.getQuestLocalizationKey() + ".completed");
         _loc3_.height = Math.max(const_1582,_loc3_.textHeight + const_1581);
         var _loc5_:int = _loc3_.height - _loc4_;
         this._window.height += _loc5_;
      }
      
      private function setWindowTitle(param1:String) : void
      {
         this.var_50.localization.registerParameter(param1,"category",this.var_50.getCampaignName(this.var_136));
         this._window.caption = this.var_50.localization.getKey(param1,param1);
      }
      
      private function setDesc(param1:String) : void
      {
         this._window.findChildByName("desc_txt").caption = this.var_50.localization.getKey(param1,param1);
      }
      
      private function onCatalogLink(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this.var_50.openCatalog(this.var_136);
         }
      }
      
      public function update(param1:uint) : void
      {
         if(this.var_1284 > 0)
         {
            this.var_1284 -= param1;
            if(this.var_1284 < 1)
            {
               this._window.center();
               this._window.visible = true;
               this._window.activate();
               if(this.var_136.lastQuestInCampaign)
               {
                  this.var_698.restart();
               }
               else
               {
                  this.var_698.stop();
               }
            }
         }
         if(this.var_698 != null)
         {
            this.var_698.update(param1);
         }
      }
   }
}
