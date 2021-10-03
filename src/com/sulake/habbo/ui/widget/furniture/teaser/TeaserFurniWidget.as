package com.sulake.habbo.ui.widget.furniture.teaser
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.configuration.IHabboConfigurationManager;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.enum.InventoryCategory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetTeaserDataUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetConversionPointMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetViralFurniMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class TeaserFurniWidget extends RoomWidgetBase
   {
       
      
      private var var_156:IHabboConfigurationManager;
      
      private var var_12:IHabboInventory;
      
      private var _window:IFrameWindow;
      
      private var var_1618:int = -1;
      
      private var var_438:int = -1;
      
      private var _shareId:String;
      
      private var var_236:int = -1;
      
      private var var_1616:Array;
      
      private var var_1617:String;
      
      private var var_206:String;
      
      private var var_1615:int = 0;
      
      private const const_2136:int = 0;
      
      private const const_2131:int = 1;
      
      private const const_2135:int = 2;
      
      private const const_2130:int = 3;
      
      private const const_2133:int = 4;
      
      private const const_2409:int = 0;
      
      private const const_2408:int = 1;
      
      private const const_2402:int = 2;
      
      private const const_2407:int = 3;
      
      private const const_2404:int = 4;
      
      private const const_2405:int = 5;
      
      private const const_2132:String = "deco_img";
      
      private const const_2134:String = "dialog_bg";
      
      private const const_2401:String = "%campaign%_dialog_bg.png";
      
      private const const_394:String = "%campaign%_gift_package.png";
      
      private const const_2406:String = "%campaign%_gift_content.png";
      
      private const const_2403:String = "%campaign%_friend_gift_package.png";
      
      public function TeaserFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:IHabboConfigurationManager, param6:IHabboInventory)
      {
         super(param1,param2,param3,param4);
         this.var_156 = param5;
         this.var_12 = param6;
         this.var_1616 = new Array();
         this.var_1617 = this.var_156.getKey("image.library.url","http://images.habbo.com/c_images/");
         this.var_1617 += "Viral/";
      }
      
      override public function dispose() : void
      {
         var _loc2_:* = null;
         if(disposed)
         {
            return;
         }
         this.hideInterface();
         if(this._window != null && !this._window.disposed)
         {
            this._window.dispose();
            this._window = null;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.var_1616.length)
         {
            _loc2_ = this.var_1616.pop();
            _loc2_.dispose();
            _loc1_++;
         }
         this.var_156 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetTeaserDataUpdateEvent.const_538,this.onObjectUpdate);
         param1.addEventListener(RoomWidgetTeaserDataUpdateEvent.const_958,this.onObjectUpdate);
         param1.addEventListener(RoomWidgetTeaserDataUpdateEvent.const_1015,this.onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetTeaserDataUpdateEvent.const_538,this.onObjectUpdate);
      }
      
      private function onObjectUpdate(param1:RoomWidgetTeaserDataUpdateEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc3_:String = param1.campaignID;
         switch(param1.type)
         {
            case RoomWidgetTeaserDataUpdateEvent.const_538:
               _loc2_ = this.const_2136;
               this._shareId = null;
               break;
            case RoomWidgetTeaserDataUpdateEvent.const_1015:
               _loc4_ = param1.firstClickUserName;
               _loc5_ = param1.giftWasReceived;
               if(_loc5_)
               {
                  if(_loc4_ && _loc4_ != "")
                  {
                     _loc2_ = this.const_2130;
                     var_77.registerParameter("widget.furni.teaser.notify.unlocked.desc","username",_loc4_);
                  }
                  else
                  {
                     _loc2_ = this.const_2135;
                  }
               }
               else
               {
                  _loc2_ = this.const_2133;
               }
               this._shareId = null;
               this.var_1615 = param1.itemCategory;
               break;
            case RoomWidgetTeaserDataUpdateEvent.const_958:
               _loc2_ = this.const_2131;
               this.var_236 = param1.objectId;
               this._shareId = param1.data;
               this.var_438 = param1.status;
               this.var_1615 = param1.itemCategory;
               var_77.registerParameter("notifications.viral_furni.fb.title","realname",param1.ownRealName);
               var_77.registerParameter("notifications.viral_furni.fb.desc","realname",param1.ownRealName);
               var_77.registerParameter("widget.furni.teaser.gift.unlocked.desc","username",param1.firstClickUserName);
               break;
            default:
               Logger.log("Error, invalid viral widget update message: " + param1.type);
         }
         if(this._window && (this.var_1618 != _loc2_ || _loc3_ != this.var_206))
         {
            this._window.dispose();
            this._window = null;
         }
         this.var_206 = _loc3_;
         this.var_1618 = _loc2_;
         this.mainWindow;
         this.showInterface();
      }
      
      override public function get mainWindow() : IWindow
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(this.var_1618 == -1)
         {
            return null;
         }
         if(!this._window)
         {
            switch(this.var_1618)
            {
               case this.const_2136:
                  _loc1_ = assets.getAssetByName("notification_teaser") as XmlAsset;
                  _loc2_ = this.const_394;
                  this.sendConversionPoint("viral_val11","client.show.teaser");
                  break;
               case this.const_2131:
                  if(this.var_438 == this.const_2409)
                  {
                     _loc1_ = assets.getAssetByName("notification_gift_locked") as XmlAsset;
                     this.sendConversionPoint("viral_" + this.var_206,"client.show.locked");
                     _loc2_ = this.const_394;
                  }
                  else if(this.var_438 == this.const_2408)
                  {
                     _loc1_ = assets.getAssetByName("notification_gift_unlocked") as XmlAsset;
                     this.sendConversionPoint("viral_" + this.var_206,"client.show.unlocked");
                     _loc2_ = this.const_2406;
                  }
                  else if(this.var_438 == this.const_2402)
                  {
                     _loc1_ = assets.getAssetByName("notification_gift_alert") as XmlAsset;
                     this.sendConversionPoint("viral_" + this.var_206,"client.show.no_fb");
                     _loc3_ = var_77.getKey("widget.furni.teaser.gift.no_fb.title");
                     _loc4_ = var_77.getKey("widget.furni.teaser.gift.no_fb.desc");
                     _loc2_ = this.const_394;
                  }
                  else if(this.var_438 == this.const_2407)
                  {
                     _loc1_ = assets.getAssetByName("notification_gift_alert") as XmlAsset;
                     this.sendConversionPoint("viral_" + this.var_206,"client.show.not_enough_fb_friends");
                     _loc3_ = var_77.getKey("widget.furni.teaser.gift.no_spam.title");
                     _loc4_ = var_77.getKey("widget.furni.teaser.gift.no_spam.desc");
                     _loc2_ = this.const_394;
                  }
                  else if(this.var_438 == this.const_2404)
                  {
                     _loc1_ = assets.getAssetByName("notification_gift_alert") as XmlAsset;
                     this.sendConversionPoint("viral_" + this.var_206,"client.show.not_enough_fb_friends");
                     _loc3_ = var_77.getKey("widget.furni.teaser.gift.no_min_fb_friends.title");
                     _loc4_ = var_77.getKey("widget.furni.teaser.gift.no_min_fb_friends.desc");
                     _loc2_ = this.const_394;
                  }
                  else if(this.var_438 == this.const_2405)
                  {
                     _loc1_ = assets.getAssetByName("notification_gift_alert") as XmlAsset;
                     this.sendConversionPoint("viral_" + this.var_206,"client.show.campaign_closed");
                     _loc3_ = var_77.getKey("widget.furni.teaser.gift.campaign_closed.title","widget.furni.teaser.gift.campaign_closed.title");
                     _loc4_ = var_77.getKey("widget.furni.teaser.gift.campaign_closed.desc","widget.furni.teaser.gift.campaign_closed.desc");
                     _loc2_ = this.const_394;
                  }
                  break;
               case this.const_2135:
                  _loc1_ = assets.getAssetByName("notification_gift_received") as XmlAsset;
                  _loc2_ = this.const_2403;
                  break;
               case this.const_2130:
                  _loc1_ = assets.getAssetByName("notification_gift_unlocked_notify") as XmlAsset;
                  _loc2_ = this.const_394;
                  break;
               case this.const_2133:
                  _loc1_ = assets.getAssetByName("notification_gift_alert") as XmlAsset;
                  _loc3_ = var_77.getKey("widget.furni.teaser.gift.campaign_closed.title","widget.furni.teaser.gift.campaign_closed.title");
                  _loc4_ = var_77.getKey("widget.furni.teaser.gift.campaign_closed.desc","widget.furni.teaser.gift.campaign_closed.desc");
            }
            if(_loc1_ == null)
            {
               return null;
            }
            this._window = windowManager.buildFromXML(_loc1_.content as XML) as IFrameWindow;
            this._window.header.controls.visible = false;
            this._window.center();
            this._window.visible = false;
            _loc5_ = this.const_2401.replace("%campaign%",this.var_206);
            this.setDecoImage(_loc5_,this.const_2134);
            _loc2_ = _loc2_.replace("%campaign%",this.var_206);
            this.setDecoImage(_loc2_,this.const_2132);
            if(_loc3_)
            {
               _loc6_ = this._window.findChildByName("alert_title") as ITextWindow;
               _loc6_.text = _loc3_;
            }
            if(_loc4_)
            {
               _loc6_ = this._window.findChildByName("alert_desc") as ITextWindow;
               _loc6_.text = _loc4_;
            }
            _loc7_ = this._window.findChildByName("teaser_ok_btn");
            if(_loc7_ != null)
            {
               _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onTeaserOkButton);
            }
            _loc7_ = this._window.findChildByName("no_fb_btn");
            if(_loc7_ != null)
            {
               _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onNoFbButton);
            }
            _loc7_ = this._window.findChildByName("received_ok_btn");
            if(_loc7_ != null)
            {
               _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onReceivedOkButton);
            }
            _loc7_ = this._window.findChildByName("skip_btn");
            if(_loc7_ != null)
            {
               _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onSkipButton);
            }
            _loc7_ = this._window.findChildByName("post_btn");
            if(_loc7_ != null)
            {
               _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onPostButton);
            }
            _loc7_ = this._window.findChildByName("open_btn");
            if(_loc7_ != null)
            {
               _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onOpenButton);
            }
         }
         return this._window;
      }
      
      private function showInterface() : void
      {
         if(this._window == null)
         {
            return;
         }
         this._window.visible = true;
      }
      
      private function hideInterface() : void
      {
         if(this._window)
         {
            this._window.visible = false;
         }
      }
      
      private function onNoFbButton(param1:WindowEvent) : void
      {
         this.hideInterface();
      }
      
      private function onTeaserOkButton(param1:WindowEvent) : void
      {
         var _loc2_:* = null;
         if(messageListener != null)
         {
            _loc2_ = new RoomWidgetViralFurniMessage(RoomWidgetViralFurniMessage.const_872);
            messageListener.processWidgetMessage(_loc2_);
         }
         this.hideInterface();
      }
      
      private function onReceivedOkButton(param1:WindowEvent) : void
      {
         this.hideInterface();
      }
      
      private function onSkipButton(param1:WindowEvent) : void
      {
         this.sendConversionPoint("viral_" + this.var_206,"client.skip_post");
         this.hideInterface();
      }
      
      private function onPostButton(param1:WindowEvent) : void
      {
         var _loc2_:String = var_77.getKey("notifications.viral_furni.fb.title");
         var _loc3_:String = var_77.getKey("notifications.viral_furni.fb.desc");
         this.sendConversionPoint("viral_" + this.var_206,"client.start_post",this._shareId);
         var _loc4_:String = this.var_156.getKey("viral.furni.post_type","feed");
         HabboWebTools.facebookViralGiftPost(this.var_206,_loc2_,_loc3_,this._shareId,_loc4_);
         this.hideInterface();
      }
      
      private function onOpenButton(param1:WindowEvent) : void
      {
         var _loc2_:* = null;
         if(messageListener != null)
         {
            _loc2_ = new RoomWidgetViralFurniMessage(RoomWidgetViralFurniMessage.const_196);
            _loc2_.objectId = this.var_236;
            messageListener.processWidgetMessage(_loc2_);
         }
         this.hideInterface();
         if(this.var_12)
         {
            if(this.var_1615 != 0)
            {
               this.var_12.toggleInventoryPage(this.var_1615 == 1 ? "null" : InventoryCategory.const_138);
            }
         }
         this.sendConversionPoint("viral_" + this.var_206,"client.open_gift");
      }
      
      private function sendConversionPoint(param1:String, param2:String, param3:String = "", param4:int = 0) : void
      {
         var _loc5_:* = null;
         if(messageListener != null)
         {
            _loc5_ = new RoomWidgetConversionPointMessage(RoomWidgetConversionPointMessage.const_788,"ViralGift",param1,param2,param3,param4);
            messageListener.processWidgetMessage(_loc5_);
         }
      }
      
      private function setDecoImage(param1:String, param2:String) : void
      {
         var _loc3_:IBitmapWrapperWindow = this._window.findChildByName(param2) as IBitmapWrapperWindow;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:IAsset = _assets.getAssetByName(param1);
         if(!_loc4_)
         {
            this.var_1616.push(new ImageDownloader(this,_assets,this.var_206,this.var_1617,param1,param2));
            return;
         }
         var _loc5_:BitmapData = (_loc4_.content as BitmapData).clone();
         switch(param2)
         {
            case this.const_2134:
            case this.const_2132:
               _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
               _loc3_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,_loc3_.height - _loc5_.height),null,null,true);
         }
      }
      
      function onDecoImageReady(param1:ImageDownloader) : void
      {
         if(disposed)
         {
            return;
         }
         if(!this._window || this.var_206 != param1.campaignID)
         {
            return;
         }
         var _loc2_:IAsset = _assets.getAssetByName(param1.imageName);
         if(!_loc2_)
         {
            return;
         }
         this.setDecoImage(param1.imageName,param1.viewElementID);
      }
   }
}
