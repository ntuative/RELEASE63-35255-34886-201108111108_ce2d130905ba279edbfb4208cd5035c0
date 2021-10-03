package com.sulake.habbo.ui.widget.chatinput
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomChatInputWidget extends RoomWidgetBase
   {
      
      private static const const_1746:int = 5000;
       
      
      private var _visualization:RoomChatInputView;
      
      private var var_2166:String = "";
      
      private var var_1687:Boolean = false;
      
      private var var_350:Timer = null;
      
      private var var_3016:int;
      
      private var var_22:Component = null;
      
      private var _configuration:IHabboConfigurationManager;
      
      public function RoomChatInputWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IHabboConfigurationManager, param6:Component)
      {
         super(param1,param2,param3,param4);
         this.var_22 = param6;
         this._configuration = param5;
         this._visualization = new RoomChatInputView(this);
      }
      
      public function get floodBlocked() : Boolean
      {
         return this.var_1687;
      }
      
      public function get config() : IHabboConfigurationManager
      {
         return this._configuration;
      }
      
      override public function dispose() : void
      {
         if(this._visualization != null)
         {
            this._visualization.dispose();
            this._visualization = null;
         }
         if(this.var_350 != null)
         {
            this.var_350.stop();
            this.var_350 = null;
         }
         this.var_22 = null;
         this._configuration = null;
         super.dispose();
      }
      
      public function get allowPaste() : Boolean
      {
         return getTimer() - this.var_3016 > const_1746;
      }
      
      public function setLastPasteTime() : void
      {
         this.var_3016 = getTimer();
      }
      
      public function sendChat(param1:String, param2:int, param3:String = "") : void
      {
         if(this.var_1687)
         {
            return;
         }
         var _loc4_:RoomWidgetChatMessage = new RoomWidgetChatMessage(RoomWidgetChatMessage.const_912,param1,param2,param3);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc4_);
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_170,this.onRoomObjectDeselected);
         param1.addEventListener(RoomWidgetChatInputContentUpdateEvent.const_992,this.onChatInputUpdate);
         param1.addEventListener(RoomWidgetUserInfoUpdateEvent.const_161,this.onUserInfo);
         param1.addEventListener(RoomWidgetFloodControlEvent.const_861,this.onFloodControl);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_170,this.onRoomObjectDeselected);
         param1.removeEventListener(RoomWidgetChatInputContentUpdateEvent.const_992,this.onChatInputUpdate);
         param1.removeEventListener(RoomWidgetUserInfoUpdateEvent.const_161,this.onUserInfo);
         param1.removeEventListener(RoomWidgetFloodControlEvent.const_861,this.onFloodControl);
      }
      
      private function onRoomObjectDeselected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         this.var_2166 = "";
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         this.var_2166 = param1.name;
      }
      
      private function onChatInputUpdate(param1:RoomWidgetChatInputContentUpdateEvent) : void
      {
         var _loc2_:String = "";
         switch(param1.messageType)
         {
            case RoomWidgetChatInputContentUpdateEvent.const_1403:
               _loc2_ = localizations.getKey("widgets.chatinput.mode.whisper",":tell");
               this._visualization.displaySpecialChatMessage(_loc2_,param1.userName);
               break;
            case RoomWidgetChatInputContentUpdateEvent.const_2082:
         }
      }
      
      private function onReleaseTimerComplete(param1:TimerEvent) : void
      {
         Logger.log("Releasing flood blocking");
         this.var_1687 = false;
         if(this._visualization != null)
         {
            this._visualization.hideFloodBlocking();
         }
         this.var_350 = null;
      }
      
      private function onReleaseTimerTick(param1:TimerEvent) : void
      {
         if(this._visualization != null)
         {
            this._visualization.updateBlockText(this.var_350.repeatCount - this.var_350.currentCount);
         }
      }
      
      public function get selectedUserName() : String
      {
         return this.var_2166;
      }
      
      public function onFloodControl(param1:RoomWidgetFloodControlEvent) : void
      {
         this.var_1687 = true;
         Logger.log("Enabling flood blocking for " + param1.seconds + " seconds");
         if(this.var_350)
         {
            this.var_350.reset();
         }
         else
         {
            this.var_350 = new Timer(1000,param1.seconds);
            this.var_350.addEventListener(TimerEvent.TIMER,this.onReleaseTimerTick);
            this.var_350.addEventListener(TimerEvent.TIMER_COMPLETE,this.onReleaseTimerComplete);
         }
         this.var_350.start();
         if(this._visualization != null)
         {
            this._visualization.updateBlockText(param1.seconds);
            this._visualization.showFloodBlocking();
         }
      }
      
      override public function get mainWindow() : IWindow
      {
         return this._visualization.window;
      }
   }
}
