package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.enum.CatalogPageName;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.session.HabboClubLevelEnum;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
   import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetToolbarClickedUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetEffectsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetSettingsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetNavigateToRoomMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetSelectEffectMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetSelectOutfitMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetShowOwnRoomsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStopEffectMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetWaveMessage;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MeMenuWidgetHandler implements IRoomWidgetHandler, IAvatarImageListener
   {
      
      private static const const_480:int = 50;
      
      private static const const_1090:int = 3;
       
      
      private var var_1173:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_12:IHabboInventory;
      
      private var var_398:IHabboToolbar;
      
      private var _catalog:IHabboCatalog;
      
      private var var_1579:String;
      
      private var var_1975:BitmapData;
      
      private var var_1974:BitmapData;
      
      private var _widget:MeMenuWidget;
      
      public function MeMenuWidgetHandler()
      {
         super();
         Logger.log("[MeMenuWidgetHandler]");
      }
      
      public function set widget(param1:MeMenuWidget) : void
      {
         this._widget = param1;
      }
      
      public function dispose() : void
      {
         if(this._container && this._container.avatarEditor)
         {
            this._container.avatarEditor.close(AvatarEditorInstanceId.const_227);
         }
         this.var_1173 = true;
         this.container = null;
         this.var_12 = null;
         this.var_398 = null;
         this._catalog = null;
         this.var_1579 = null;
         this.var_1975 = null;
         this.var_1974 = null;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1173;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_562;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(this._container != null)
         {
            if(this._container.sessionDataManager && !this._container.sessionDataManager.disposed && this._container.sessionDataManager.events)
            {
               this._container.sessionDataManager.events.removeEventListener(HabboSessionFigureUpdatedEvent.const_340,this.onFigureUpdate);
            }
            if(this.var_12 && !this.var_12.disposed && this.var_12.events)
            {
               this.var_12.events.removeEventListener(HabboInventoryEffectsEvent.const_297,this.onAvatarEffectsChanged);
               this.var_12.events.removeEventListener(HabboInventoryHabboClubEvent.const_231,this.onHabboClubSubscriptionChanged);
            }
            if(this.var_398 && !this.var_398.disposed && this.var_398.events)
            {
               this.var_398.events.removeEventListener(HabboToolbarEvent.const_48,this.onHabboToolbarEvent);
            }
            if(this._container.habboHelp && !this._container.habboHelp.disposed && this._container.habboHelp.events)
            {
               this._container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.const_984,this.onHelpTutorialEvent);
               this._container.habboHelp.events.removeEventListener(HabboHelpTutorialEvent.const_123,this.onHelpTutorialEvent);
            }
            if(this._container.catalog && !this._container.catalog.disposed && this._container.catalog.events)
            {
               this._container.catalog.events.removeEventListener(PurseEvent.const_134,this.onCreditBalance);
            }
         }
         this._container = param1;
         if(this._container == null)
         {
            return;
         }
         if(this._container.sessionDataManager != null)
         {
            this._container.sessionDataManager.events.addEventListener(HabboSessionFigureUpdatedEvent.const_340,this.onFigureUpdate);
         }
         this.var_12 = this._container.inventory;
         if(this.var_12 != null)
         {
            this.var_12.events.addEventListener(HabboInventoryEffectsEvent.const_297,this.onAvatarEffectsChanged);
            this.var_12.events.addEventListener(HabboInventoryHabboClubEvent.const_231,this.onHabboClubSubscriptionChanged);
         }
         this.var_398 = this._container.toolbar;
         if(this.var_398 && this.var_398.events)
         {
            this.var_398.events.addEventListener(HabboToolbarEvent.const_48,this.onHabboToolbarEvent);
            this.setMeMenuToolbarIcon();
         }
         if(this._container.habboHelp != null)
         {
            this._container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.const_984,this.onHelpTutorialEvent);
            this._container.habboHelp.events.addEventListener(HabboHelpTutorialEvent.const_123,this.onHelpTutorialEvent);
         }
         this._catalog = this._container.catalog;
         if(this._container.catalog != null)
         {
            this._container.catalog.events.addEventListener(PurseEvent.const_134,this.onCreditBalance);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return this._container;
      }
      
      private function setMeMenuToolbarIcon() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(this._container.avatarRenderManager != null)
         {
            _loc3_ = this._container.sessionDataManager.figure;
            if(_loc3_ != this.var_1579)
            {
               _loc4_ = this._container.sessionDataManager.gender;
               _loc5_ = this._container.avatarRenderManager.createAvatarImage(_loc3_,AvatarScaleType.const_61,_loc4_,this);
               if(_loc5_ != null)
               {
                  _loc5_.setDirection(AvatarSetType.const_42,2);
                  _loc1_ = _loc5_.getCroppedImage(AvatarSetType.const_42);
                  _loc2_ = _loc5_.getCroppedImage(AvatarSetType.const_56);
                  _loc5_.dispose();
               }
               this.var_1579 = _loc3_;
               this.var_1975 = _loc1_;
               this.var_1974 = _loc2_;
            }
            else
            {
               _loc1_ = this.var_1975;
               _loc2_ = this.var_1974;
            }
         }
         if(this.var_398 != null)
         {
            if(_loc1_ != null && _loc2_ != null)
            {
               if(_loc1_.height > const_480)
               {
                  _loc7_ = new BitmapData(_loc1_.width,const_480,true,0);
                  _loc8_ = _loc7_.rect.clone();
                  if(_loc2_.height > const_480 - const_1090)
                  {
                     _loc8_.offset(0,_loc2_.height - const_480 + const_1090);
                  }
                  _loc7_.copyPixels(_loc1_,_loc8_,new Point(0,0));
                  _loc6_ = _loc7_;
               }
               else
               {
                  _loc6_ = _loc1_;
               }
            }
            this.var_398.setIconBitmap(HabboToolbarIconEnum.MEMENU,_loc6_);
         }
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(this.disposed || !this._container || !this._container.events)
         {
            return;
         }
         if(param1.type == HabboToolbarEvent.const_48)
         {
            switch(param1.iconId)
            {
               case HabboToolbarIconEnum.MEMENU:
                  this._container.events.dispatchEvent(new RoomWidgetToolbarClickedUpdateEvent(RoomWidgetToolbarClickedUpdateEvent.ICON_TYPE_ME_MENU));
            }
         }
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomWidgetWaveMessage.const_1005);
         _loc1_.push(RoomWidgetDanceMessage.const_964);
         _loc1_.push(RoomWidgetGetEffectsMessage.const_760);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_1397);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_1236);
         _loc1_.push(RoomWidgetSelectEffectMessage.const_1286);
         _loc1_.push(RoomWidgetOpenInventoryMessage.const_891);
         _loc1_.push(RoomWidgetOpenCatalogMessage.const_846);
         _loc1_.push(RoomWidgetStopEffectMessage.const_948);
         _loc1_.push(RoomWidgetNavigateToRoomMessage.const_1898);
         _loc1_.push(RoomWidgetNavigateToRoomMessage.const_1221);
         _loc1_.push(RoomWidgetAvatarEditorMessage.const_567);
         _loc1_.push(RoomWidgetAvatarEditorMessage.const_1920);
         _loc1_.push(RoomWidgetSelectOutfitMessage.const_1361);
         _loc1_.push(RoomWidgetShowOwnRoomsMessage.const_949);
         _loc1_.push(RoomWidgetRequestWidgetMessage.const_896);
         _loc1_.push(RoomWidgetMeMenuMessage.const_865);
         _loc1_.push(RoomWidgetGetSettingsMessage.const_746);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_1774);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_851);
         _loc1_.push(RoomWidgetStoreSettingsMessage.const_845);
         _loc1_.push(RoomWidgetAvatarEditorMessage.const_1432);
         _loc1_.push(RoomWidgetRequestWidgetMessage.const_448);
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         if(!param1)
         {
            return null;
         }
         switch(param1.type)
         {
            case RoomWidgetRequestWidgetMessage.const_896:
               if(this._container != null && this._container.toolbar != null && this._container.toolbar.events != null)
               {
                  _loc5_ = new HabboToolbarEvent(HabboToolbarEvent.const_48);
                  _loc5_.iconId = HabboToolbarIconEnum.MEMENU;
                  if(!this.disposed && this._container && this._container.toolbar && this._container.toolbar.events)
                  {
                     this._container.toolbar.events.dispatchEvent(_loc5_);
                  }
               }
               break;
            case RoomWidgetWaveMessage.const_1005:
               if(this._container != null && this._container.roomSession != null)
               {
                  this._container.roomSession.sendWaveMessage();
               }
               break;
            case RoomWidgetDanceMessage.const_964:
               if(this._container != null && this._container.roomSession != null)
               {
                  _loc6_ = param1 as RoomWidgetDanceMessage;
                  if(_loc6_ != null)
                  {
                     this._container.roomSession.sendDanceMessage(_loc6_.style);
                  }
               }
               break;
            case RoomWidgetGetEffectsMessage.const_760:
               if(this.var_12 != null)
               {
                  _loc7_ = this.var_12.getAvatarEffects();
                  this._container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc7_));
               }
               break;
            case RoomWidgetSelectEffectMessage.const_1397:
               if(this.var_12 != null)
               {
                  _loc8_ = param1 as RoomWidgetSelectEffectMessage;
                  this.var_12.setEffectSelected(_loc8_.effectType);
               }
               break;
            case RoomWidgetSelectEffectMessage.const_1236:
               if(this.var_12 != null)
               {
                  _loc9_ = param1 as RoomWidgetSelectEffectMessage;
                  this.var_12.setEffectDeselected(_loc9_.effectType);
               }
               break;
            case RoomWidgetOpenCatalogMessage.const_846:
               _loc2_ = param1 as RoomWidgetOpenCatalogMessage;
               if(this._catalog != null && _loc2_.pageKey == RoomWidgetOpenCatalogMessage.const_1253)
               {
                  this._catalog.openCatalogPage(CatalogPageName.const_176,true);
               }
               break;
            case RoomWidgetOpenInventoryMessage.const_891:
               _loc3_ = param1 as RoomWidgetOpenInventoryMessage;
               if(this.var_12 != null)
               {
                  Logger.log("MeMenuWidgetHandler open inventory: " + _loc3_.inventoryType);
                  switch(_loc3_.inventoryType)
                  {
                     case RoomWidgetOpenInventoryMessage.const_1847:
                        this._catalog.openCatalogPage(CatalogPageName.const_1309,true);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_1335:
                        this.var_12.toggleInventoryPage(InventoryCategory.const_293);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_2043:
                        this.var_12.toggleInventoryPage(InventoryCategory.const_74);
                        break;
                     case RoomWidgetOpenInventoryMessage.const_2077:
                        break;
                     default:
                        Logger.log("MeMenuWidgetHandler: unknown inventory type: " + _loc3_.inventoryType);
                  }
               }
               break;
            case RoomWidgetSelectEffectMessage.const_1286:
            case RoomWidgetStopEffectMessage.const_948:
               Logger.log("STOP ALL EFFECTS");
               if(this.var_12 != null)
               {
                  this.var_12.deselectAllEffects();
               }
               break;
            case RoomWidgetNavigateToRoomMessage.const_1221:
               Logger.log("MeMenuWidgetHandler: GO HOME");
               if(this._container != null)
               {
                  this._container.navigator.goToHomeRoom();
               }
               break;
            case RoomWidgetShowOwnRoomsMessage.const_949:
               if(this._container != null)
               {
                  this._container.navigator.showOwnRooms();
               }
               break;
            case RoomWidgetMeMenuMessage.const_865:
               _loc4_ = param1 as RoomWidgetMeMenuMessage;
               if(!_loc4_ || !this._container || !this._container.events)
               {
                  return null;
               }
               if(this.var_12 != null)
               {
                  _loc10_ = false;
                  if(this._container != null && this._container.sessionDataManager != null)
                  {
                     _loc10_ = this._container.sessionDataManager.hasUserRight("fuse_use_club_dance",HabboClubLevelEnum.const_33);
                  }
                  this._container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(this.var_12.clubDays,this.var_12.clubPeriods,this.var_12.clubPastPeriods,_loc10_,this.var_12.clubLevel));
               }
               if(this._catalog != null && this._catalog.getPurse() != null)
               {
                  this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.const_134,this._catalog.getPurse().credits));
               }
               if(this._container.roomSession && this._container.roomSession.userDataManager && this._container.roomEngine)
               {
                  _loc11_ = this._container.sessionDataManager != null ? int(this._container.sessionDataManager.userId) : -1;
                  _loc12_ = this._container.roomSession.userDataManager.getUserData(_loc11_);
                  if(!_loc12_)
                  {
                     return null;
                  }
                  _loc13_ = 0;
                  _loc14_ = 0;
                  this._container.roomEngine.selectAvatar(_loc13_,_loc14_,_loc12_.id);
               }
               break;
            case RoomWidgetAvatarEditorMessage.const_567:
               Logger.log("MeMenuWidgetHandler: Open avatar editor...");
               if(this._container)
               {
                  this._container.avatarEditor.openEditor(AvatarEditorInstanceId.const_227,null,null,true);
                  this._container.avatarEditor.loadOwnAvatarInEditor(AvatarEditorInstanceId.const_227);
                  if(this._container.habboHelp && this._container.habboHelp.events)
                  {
                     this._container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.const_598));
                  }
               }
               break;
            case RoomWidgetGetSettingsMessage.const_746:
               this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_450,this._container.soundManager.volume));
               break;
            case RoomWidgetStoreSettingsMessage.const_851:
               this._container.soundManager.volume = (param1 as RoomWidgetStoreSettingsMessage).volume;
               this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_450,this._container.soundManager.volume));
               break;
            case RoomWidgetStoreSettingsMessage.const_845:
               this._container.soundManager.previewVolume = (param1 as RoomWidgetStoreSettingsMessage).volume;
               this._container.events.dispatchEvent(new RoomWidgetSettingsUpdateEvent(RoomWidgetSettingsUpdateEvent.const_450,this._container.soundManager.volume));
               break;
            case RoomWidgetAvatarEditorMessage.const_1432:
               if(this._container.habboHelp && this._container.habboHelp.events)
               {
                  this._container.habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent(HabboHelpTutorialEvent.const_512));
               }
               break;
            default:
               Logger.log("Unhandled message in MeMenuWidgetHandler: " + param1.type);
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      private function onAvatarEffectsChanged(param1:Event = null) : void
      {
         var _loc2_:* = null;
         if(this._container == null)
         {
            return;
         }
         Logger.log("[MeMenuWidgetHandler] Received Avatar Effects Have Changed Event...\t");
         if(this.var_12 != null)
         {
            _loc2_ = this.var_12.getAvatarEffects();
            this._container.events.dispatchEvent(new RoomWidgetUpdateEffectsUpdateEvent(_loc2_));
         }
      }
      
      private function onHabboClubSubscriptionChanged(param1:Event = null) : void
      {
         var _loc2_:Boolean = false;
         if(this.var_12 != null)
         {
            _loc2_ = false;
            if(this._container != null && this._container.sessionDataManager != null)
            {
               _loc2_ = this._container.sessionDataManager.hasUserRight("fuse_use_club_dance",HabboClubLevelEnum.const_33);
            }
            this._container.events.dispatchEvent(new RoomWidgetHabboClubUpdateEvent(this.var_12.clubDays,this.var_12.clubPeriods,this.var_12.clubPastPeriods,_loc2_,this.var_12.clubLevel));
         }
      }
      
      private function onFigureUpdate(param1:HabboSessionFigureUpdatedEvent) : void
      {
         if(this._container == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc2_:* = param1.userId == this._container.sessionDataManager.userId;
         if(_loc2_)
         {
            this.setMeMenuToolbarIcon();
         }
         if(this._container != null && this._container.events != null)
         {
         }
      }
      
      private function onCreditBalance(param1:PurseEvent) : void
      {
         if(param1 == null || this._container == null || this._container.events == null)
         {
            return;
         }
         this._container.events.dispatchEvent(new RoomWidgetPurseUpdateEvent(RoomWidgetPurseUpdateEvent.const_134,param1.balance));
      }
      
      private function onHelpTutorialEvent(param1:HabboHelpTutorialEvent) : void
      {
         if(this._container == null)
         {
            return;
         }
         switch(param1.type)
         {
            case HabboHelpTutorialEvent.const_123:
               this._container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.const_123));
               break;
            case HabboHelpTutorialEvent.const_984:
               this._container.events.dispatchEvent(new RoomWidgetTutorialEvent(RoomWidgetTutorialEvent.const_497));
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         this.var_1579 = "";
         this.setMeMenuToolbarIcon();
      }
   }
}
