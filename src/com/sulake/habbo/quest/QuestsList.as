package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.RejectQuestMessageComposer;
   import com.sulake.habbo.help.WelcomeNotification;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.utils.IAlertDialog;
   
   public class QuestsList implements IDisposable
   {
      
      private static const const_1480:int = 5;
      
      private static const const_1479:int = 10;
      
      private static const const_1481:int = 10;
      
      private static const const_1482:int = 30;
       
      
      private var var_50:HabboQuestEngine;
      
      private var _window:IFrameWindow;
      
      private var var_62:IItemListWindow;
      
      private var var_613:IScrollbarWindow;
      
      private var var_1765:Boolean = true;
      
      private var var_1766:Boolean;
      
      private var var_773:WindowToggle;
      
      private var var_1469:Array;
      
      private var var_1468:int = 1000;
      
      public function QuestsList(param1:HabboQuestEngine)
      {
         super();
         this.var_50 = param1;
      }
      
      public function dispose() : void
      {
         this.var_50 = null;
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
         if(this.var_773)
         {
            this.var_773.dispose();
            this.var_773 = null;
         }
         this.var_62 = null;
         this.var_613 = null;
         this.var_1469 = null;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_50 == null;
      }
      
      public function isVisible() : Boolean
      {
         return this._window && this._window.visible;
      }
      
      public function close() : void
      {
         if(this._window)
         {
            this._window.visible = false;
         }
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function onToolbarClick() : void
      {
         if(!this._window)
         {
            this.requestQuests();
            return;
         }
         if(!this.var_773 || this.var_773.disposed)
         {
            this.var_773 = new WindowToggle(this._window,this._window.desktop,this.requestQuests,this.close);
         }
         this.var_773.toggle();
         this.var_1765 = false;
      }
      
      private function requestQuests() : void
      {
         this.var_50.send(new GetQuestsMessageComposer());
      }
      
      public function onQuests(param1:Array, param2:Boolean) : void
      {
         var _loc3_:* = null;
         this.var_1469 = param1;
         if(!this.isVisible() && !param2)
         {
            return;
         }
         this.refresh(false);
         this._window.visible = true;
         this._window.activate();
         this.var_1766 = false;
         for each(_loc3_ in param1)
         {
            if(_loc3_.accepted)
            {
               this.var_1766 = true;
            }
         }
      }
      
      private function refresh(param1:Boolean) : void
      {
         var _loc3_:Boolean = false;
         this.prepareWindow();
         this.var_62.autoArrangeItems = false;
         var _loc2_:int = 0;
         while(true)
         {
            if(_loc2_ < this.var_1469.length)
            {
               this.refreshEntry(true,_loc2_,this.var_1469[_loc2_],param1);
            }
            else
            {
               _loc3_ = this.refreshEntry(false,_loc2_,null,param1);
               if(_loc3_)
               {
                  break;
               }
            }
            _loc2_++;
         }
         this.var_62.autoArrangeItems = true;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         this._window = IFrameWindow(this.var_50.getXmlWindow("Quests"));
         this._window.findChildByTag("close").procedure = this.onWindowClose;
         this.var_62 = IItemListWindow(this._window.findChildByName("quest_list"));
         this.var_613 = IScrollbarWindow(this._window.findChildByName("scroller"));
         this._window.center();
         this.var_62.spacing = const_1479;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:QuestMessageData, param4:Boolean) : Boolean
      {
         var _loc5_:IWindowContainer = IWindowContainer(this.var_62.getListItemAt(param2));
         var _loc6_:Boolean = false;
         if(_loc5_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc5_ = this.createListEntry();
            this.var_62.addListItem(_loc5_);
            _loc6_ = true;
         }
         if(param1)
         {
            if(param4)
            {
               this.refreshDelay(_loc5_,param3);
            }
            else
            {
               this.refreshEntryDetails(_loc5_,param3);
            }
            _loc5_.visible = true;
         }
         else
         {
            _loc5_.visible = false;
         }
         return false;
      }
      
      public function createListEntry() : IWindowContainer
      {
         var _loc1_:IWindowContainer = IWindowContainer(this.var_50.getXmlWindow("QuestEntry"));
         var _loc2_:IWindowContainer = IWindowContainer(this.var_50.getXmlWindow("Campaign"));
         var _loc3_:IWindowContainer = IWindowContainer(this.var_50.getXmlWindow("Quest"));
         var _loc4_:IWindowContainer = IWindowContainer(this.var_50.getXmlWindow("EntryArrows"));
         var _loc5_:IWindowContainer = IWindowContainer(this.var_50.getXmlWindow("CampaignCompleted"));
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(_loc5_);
         _loc1_.addChild(_loc4_);
         _loc3_.findChildByName("accept_button").procedure = this.onAcceptQuest;
         _loc3_.findChildByName("cancel_region").procedure = this.onCancelQuest;
         _loc1_.findChildByName("hint_txt").visible = false;
         _loc1_.findChildByName("link_region").visible = false;
         var _loc6_:IWindow = _loc1_.findChildByName("cancel_region");
         var _loc7_:IWindow = _loc1_.findChildByName("cancel_txt");
         _loc6_.width = _loc7_.width;
         _loc6_.x = _loc3_.width - _loc6_.width - const_1481;
         new PendingImage(this.var_50,IBitmapWrapperWindow(_loc4_.findChildByName("arrow_0")),"quest_arrow1");
         new PendingImage(this.var_50,IBitmapWrapperWindow(_loc4_.findChildByName("arrow_1")),"quest_arrow2");
         new PendingImage(this.var_50,IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_red_bitmap")),"quest_counterbkg_disabled");
         new PendingImage(this.var_50,IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_blue_bitmap")),"quest_counterbkg_active");
         new PendingImage(this.var_50,IBitmapWrapperWindow(_loc2_.findChildByName("completion_bg_green_bitmap")),"quest_counterbkg_completed");
         new PendingImage(this.var_50,IBitmapWrapperWindow(_loc5_.findChildByName("completed_pic_bitmap")),"category_completed");
         _loc3_.x = _loc2_.x + _loc2_.width + const_1480;
         _loc1_.width = _loc3_.x + _loc3_.width;
         _loc5_.x = _loc3_.x;
         this.setEntryHeight(_loc1_);
         return _loc1_;
      }
      
      public function setEntryHeight(param1:IWindowContainer) : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(param1.findChildByName("campaign_container"));
         var _loc3_:IWindowContainer = IWindowContainer(param1.findChildByName("quest_container"));
         var _loc4_:IWindowContainer = IWindowContainer(param1.findChildByName("entry_arrows_cont"));
         _loc2_.height = _loc3_.height;
         param1.height = _loc3_.height;
         _loc4_.x = _loc2_.x + _loc2_.width - 2;
         _loc4_.y = Math.floor((_loc2_.height - _loc4_.height) / 2) + 1;
         _loc2_.findChildByName("completion_txt").y = _loc2_.height - const_1482;
         var _loc6_:IWindow = _loc2_.findChildByName("bg_bottom");
         _loc6_.height = Math.floor((_loc2_.height - 2 * 2) / 2);
         _loc6_.y = 2 + _loc6_.height;
      }
      
      public function refreshEntryDetails(param1:IWindowContainer, param2:QuestMessageData) : void
      {
         param1.findChildByName("campaign_header_txt").caption = this.var_50.getCampaignName(param2);
         param1.findChildByName("completion_txt").caption = param2.completedQuestsInCampaign + "/" + param2.questCountInCampaign;
         this.var_50.setupCampaignImage(param1,param2,true);
         this.setColor(param1,"bg",param2.accepted,4290944315,4284769380);
         this.setColor(param1,"bg_top",param2.accepted,4294956936,4290427578);
         this.setColor(param1,"bg_bottom",param2.accepted,4294952792,4289440683);
         param1.findChildByName("completion_bg_red_bitmap").visible = !param2.completedCampaign && param2.completedQuestsInCampaign < 1;
         param1.findChildByName("completion_bg_blue_bitmap").visible = !param2.completedCampaign && param2.completedQuestsInCampaign > 0;
         param1.findChildByName("completion_bg_green_bitmap").visible = param2.completedCampaign;
         param1.findChildByName("arrow_0").visible = !param2.accepted;
         param1.findChildByName("arrow_1").visible = param2.accepted;
         param1.findChildByName("quest_container").visible = !param2.completedCampaign;
         param1.findChildByName("campaign_completed_container").visible = param2.completedCampaign;
         if(!param2.completedCampaign)
         {
            this.refreshEntryQuestDetails(IWindowContainer(param1.findChildByName("quest_container")),param2);
            this.refreshDelay(param1,param2);
         }
      }
      
      private function refreshEntryQuestDetails(param1:IWindowContainer, param2:QuestMessageData) : void
      {
         param1.findChildByName("quest_header_txt").caption = this.var_50.getQuestRowTitle(param2);
         param1.findChildByName("desc_txt").caption = this.var_50.getQuestDesc(param2);
         param1.findChildByName("cancel_txt").visible = param2.accepted;
         param1.findChildByName("cancel_region").visible = param2.accepted;
         param1.findChildByName("accept_button").visible = !param2.accepted;
         param1.findChildByName("accept_button").id = param2.id;
         this.setColor(param1,null,param2.accepted,15982264,13158600);
         this.setColor(param1,"quest_header",param2.accepted,15577658,9276813);
         ITextWindow(param1.findChildByName("quest_header_txt")).textColor = !!param2.accepted ? 4294967295 : uint(4281808695);
         this.var_50.setupQuestImage(param1,param2);
         this.var_50.refreshReward(param2.waitPeriodSeconds < 1,param1,param2.activityPointType,param2.rewardCurrencyAmount);
         param1.findChildByName("delay_desc_txt").visible = param2.waitPeriodSeconds > 0;
         param1.findChildByName("delay_txt").visible = param2.waitPeriodSeconds > 0;
         param1.findChildByName("desc_txt").visible = param2.waitPeriodSeconds < 1;
      }
      
      public function refreshDelay(param1:IWindowContainer, param2:QuestMessageData) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(param1.findChildByName("delay_desc_txt").visible)
         {
            _loc3_ = param2.waitPeriodSeconds;
            if(_loc3_ <= 0)
            {
               this.refreshEntryQuestDetails(param1,param2);
               return true;
            }
            _loc4_ = FriendlyTime.getFriendlyTime(this.var_50.localization,_loc3_);
            param1.findChildByName("delay_txt").caption = _loc4_;
         }
         return false;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Boolean = false;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this.close();
            _loc3_ = Boolean(parseInt(this.var_50.configuration.getKey("new.identity","0")));
            if(_loc3_ && this.var_1765 && !this.var_1766)
            {
               this.var_1765 = false;
               this.var_50.habboHelp.showWelcomeScreen(new WelcomeNotification(HabboToolbarIconEnum.QUESTS,"quests.rejectnotification"));
            }
         }
      }
      
      private function onAcceptQuest(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         var _loc3_:int = param2.id;
         Logger.log("Accept quest: " + _loc3_);
         this.var_50.send(new AcceptQuestMessageComposer(_loc3_));
         this._window.visible = false;
      }
      
      private function onCancelQuest(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Reject quest");
         this.var_50.send(new RejectQuestMessageComposer());
      }
      
      private function setColor(param1:IWindowContainer, param2:String, param3:Boolean, param4:uint, param5:uint) : void
      {
         (param2 == null ? param1 : param1.findChildByName(param2)).color = !!param3 ? param4 : param5;
      }
      
      public function onAlert(param1:IAlertDialog, param2:WindowEvent) : void
      {
         if(param2.type == WindowEvent.const_146 || param2.type == WindowEvent.const_532)
         {
            param1.dispose();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(this._window == null || !this._window.visible)
         {
            return;
         }
         this.var_1468 -= param1;
         if(this.var_1468 > 0)
         {
            return;
         }
         this.var_1468 = NextQuestTimer.const_969;
         this.refresh(true);
      }
   }
}
