package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.session.HabboClubLevelEnum;
   import com.sulake.habbo.toolbar.ExtensionFixedSlotsEnum;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.IExtensionView;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   
   public class VideoOfferExtension
   {
      
      private static const const_728:String = "video_offer";
      
      private static const const_1158:String = "supersaverAdsOnCampaignsReady";
      
      private static const const_1161:String = "supersaverAdsOnCampaignCompleted";
      
      private static const const_1159:String = "supersaverAdsOnCampaignOpen";
      
      private static const const_1160:String = "supersaverAdsOnCampaignClose";
      
      private static const const_1744:String = "supersaverAdsLoadCampaigns";
      
      private static const const_1743:String = "supersaverAdsCamapaignEngage";
      
      private static const const_1469:uint = 16777215;
      
      private static const const_1470:uint = 12247545;
      
      private static const const_1742:uint = 6710886;
      
      private static const const_1745:uint = 13421772;
       
      
      private var var_914:HabboToolbar;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var _events:IEventDispatcher;
      
      private var _config:IHabboConfigurationManager;
      
      private var _localization:ICoreLocalizationManager;
      
      private var var_12:IHabboInventory;
      
      private var _catalog:IHabboCatalog;
      
      private var _connection:IConnection;
      
      private var _extensionView:IExtensionView;
      
      private var _view:IWindowContainer;
      
      private var _disposed:Boolean = false;
      
      private var var_500:IRegionWindow;
      
      private var var_263:IIconWindow;
      
      private var var_992:Number = -1;
      
      private var var_2162:Boolean = false;
      
      private var var_1394:int = 0;
      
      private var var_2161:int = 0;
      
      public function VideoOfferExtension(param1:HabboToolbar, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IEventDispatcher, param5:IHabboConfigurationManager, param6:ICoreLocalizationManager, param7:IHabboInventory, param8:IHabboCatalog, param9:IConnection)
      {
         super();
         this._windowManager = param2;
         this._assets = param3;
         this._events = param4;
         this._config = param5;
         this._localization = param6;
         this.var_12 = param7;
         this._catalog = param8;
         this._connection = param9;
         this.var_914 = param1;
         this._extensionView = param1.extensionView;
         if(this.var_12)
         {
            this.var_12.events.addEventListener(HabboInventoryHabboClubEvent.const_231,this.onClubChanged);
         }
      }
      
      private function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(this.var_12.clubIsExpiring && !this._view && this.isClubExtensionEnabled())
         {
            this._extensionView.detachExtension(const_728);
            this.destroyWindow();
            return;
         }
         if(false && !this.var_2162 && !this._view)
         {
            ExternalInterface.addCallback(const_1158,this.onCampaignsReady);
            ExternalInterface.addCallback(const_1161,this.onCampaignComplete);
            ExternalInterface.addCallback(const_1159,this.onCampaignOpen);
            ExternalInterface.addCallback(const_1160,this.onCampaignClose);
            ExternalInterface.call(const_1744);
         }
      }
      
      private function isClubExtensionEnabled() : Boolean
      {
         if(this.var_12.clubLevel == HabboClubLevelEnum.const_35 && this._config.getBoolean("club.membership.extend.vip.promotion.enabled",false) || this.var_12.clubLevel == HabboClubLevelEnum.const_33 && this._config.getBoolean("club.membership.extend.basic.promotion.enabled",false))
         {
            return true;
         }
         return false;
      }
      
      private function onCampaignsReady(param1:String) : void
      {
         this.var_1394 = parseInt(param1);
         if(isNaN(this.var_1394))
         {
            this.var_1394 = 0;
         }
         if(this.var_1394 <= 0 || this.var_2162 || this.var_12.clubIsExpiring && this.isClubExtensionEnabled())
         {
            if(this._view)
            {
               this.destroyWindow();
            }
            return;
         }
         if(!this._view)
         {
            this._view = this.createWindow(this._assets,this._windowManager);
         }
      }
      
      private function onCampaignOpen() : void
      {
      }
      
      private function onCampaignClose() : void
      {
         this.turnVolumeUp();
         if(this._connection)
         {
            this._connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.close"));
         }
      }
      
      private function onCampaignComplete() : void
      {
         this.turnVolumeUp();
         if(this._connection)
         {
            this._connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.complete"));
         }
      }
      
      private function createWindow(param1:IAssetLibrary, param2:IHabboWindowManager) : IWindowContainer
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc3_:* = null;
         var _loc4_:XmlAsset = param1.getAssetByName("video_offer_promotion_xml") as XmlAsset;
         if(_loc4_)
         {
            _loc3_ = param2.buildFromXML(_loc4_.content as XML,1) as IWindowContainer;
            if(_loc3_)
            {
               _loc5_ = this._localization.getKey("supersaverads.video.promo.offer","Watch a video and earn a credit!");
               _loc6_ = _loc3_.findChildByName("promo_text") as ITextWindow;
               _loc7_ = _loc3_.findChildByName("promo_text_shadow") as ITextWindow;
               if(_loc6_)
               {
                  _loc6_.text = _loc5_;
               }
               if(_loc7_)
               {
                  _loc7_.text = _loc5_;
               }
               _loc8_ = this._assets.getAssetByName("offer_icon_png") as BitmapDataAsset;
               if(_loc8_ != null)
               {
                  _loc9_ = _loc8_.content as BitmapData;
                  _loc10_ = _loc3_.findChildByName("promo_icon") as IBitmapWrapperWindow;
                  if(_loc9_ != null && _loc10_ != null)
                  {
                     _loc10_.bitmap = new BitmapData(_loc10_.width,_loc10_.height,true,0);
                     _loc10_.bitmap.copyPixels(_loc9_,_loc9_.rect,new Point(0,0));
                  }
               }
               this.var_500 = _loc3_.findChildByName("text_region") as IRegionWindow;
               if(this.var_500)
               {
                  this.var_500.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onTextRegionClicked);
                  this.var_500.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onTextRegionMouseOver);
                  this.var_500.addEventListener(WindowMouseEvent.const_25,this.onTextRegionMouseOut);
               }
               this.var_263 = _loc3_.findChildByName("promo_close_icon") as IIconWindow;
               if(this.var_263)
               {
                  this.var_263.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onCloseClicked);
                  this.var_263.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onCloseMouseOver);
                  this.var_263.addEventListener(WindowMouseEvent.const_25,this.onCloseMouseOut);
               }
               this._extensionView.attachExtension(const_728,_loc3_,ExtensionFixedSlotsEnum.const_1377);
            }
         }
         return _loc3_;
      }
      
      private function destroyWindow() : void
      {
         if(this._view)
         {
            if(this.var_500)
            {
               this.var_500.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onTextRegionClicked);
               this.var_500.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onTextRegionMouseOver);
               this.var_500.removeEventListener(WindowMouseEvent.const_25,this.onTextRegionMouseOut);
               this.var_500 = null;
            }
            if(this.var_263)
            {
               this.var_263.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onCloseClicked);
               this.var_263.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onCloseMouseOver);
               this.var_263.removeEventListener(WindowMouseEvent.const_25,this.onCloseMouseOut);
               this.var_263 = null;
            }
            this._view.dispose();
            this._view = null;
         }
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            if(this._extensionView)
            {
               this._extensionView.detachExtension(const_728);
               this._extensionView = null;
            }
            this.destroyWindow();
            if(false)
            {
               ExternalInterface.addCallback(const_1158,null);
               ExternalInterface.addCallback(const_1161,null);
               ExternalInterface.addCallback(const_1159,null);
               ExternalInterface.addCallback(const_1160,null);
            }
            if(this.var_12)
            {
               this.var_12.events.removeEventListener(HabboInventoryHabboClubEvent.const_231,this.onClubChanged);
               this.var_12 = null;
            }
            this.var_914 = null;
            this.var_12 = null;
            this._catalog = null;
            this._localization = null;
            this._config = null;
            this._assets = null;
            this._events = null;
            this._disposed = true;
         }
      }
      
      private function onCloseClicked(param1:WindowMouseEvent) : void
      {
         this.var_2162 = true;
         this.destroyWindow();
         if(this._connection)
         {
            this._connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.close_clicked"));
         }
      }
      
      private function onCloseMouseOver(param1:WindowMouseEvent) : void
      {
         if(this.var_263)
         {
            this.var_263.color = const_1745;
         }
      }
      
      private function onCloseMouseOut(param1:WindowMouseEvent) : void
      {
         if(this.var_263)
         {
            this.var_263.color = const_1742;
         }
      }
      
      private function onTextRegionClicked(param1:WindowMouseEvent) : void
      {
         if(false)
         {
            this.var_2161 += 1;
            ExternalInterface.call(const_1743);
            this.turnVolumeDown();
            if(this._connection)
            {
               this._connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.launched"));
            }
         }
         if(this.var_1394 == this.var_2161)
         {
            this.destroyWindow();
         }
      }
      
      private function onTextRegionMouseOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = null;
         if(this._view)
         {
            _loc2_ = this._view.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = const_1470;
         }
      }
      
      private function onTextRegionMouseOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = null;
         if(this._view)
         {
            _loc2_ = this._view.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = const_1469;
         }
      }
      
      private function turnVolumeDown() : void
      {
         if(this.var_914.soundManager)
         {
            this.var_992 = this.var_914.soundManager.volume;
            this.var_914.soundManager.volume = 0;
         }
      }
      
      private function turnVolumeUp() : void
      {
         if(this.var_914.soundManager && this.var_992 != -1)
         {
            this.var_914.soundManager.volume = this.var_992;
         }
      }
   }
}
