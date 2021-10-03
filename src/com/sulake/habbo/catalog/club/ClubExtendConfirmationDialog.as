package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
   import com.sulake.habbo.window.enum.HabboIconType;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class ClubExtendConfirmationDialog
   {
      
      private static const const_388:int = 7;
      
      private static const const_1464:String = "your_price_icon";
      
      private static const const_1466:String = "http://images.habbo.com/c_images/catalogue/vip_extend_tsr.png";
      
      private static const const_1462:String = "image/png";
      
      private static const const_1465:int = 2000;
      
      private static const const_1463:int = 75;
      
      private static const const_1461:uint = 0;
      
      private static const LINK_COLOR_HOVER:uint = 9552639;
       
      
      private var var_26:ClubExtendController;
      
      private var _view:IFrameWindow;
      
      private var var_107:ClubOfferExtendData;
      
      private var var_626:IRegionWindow;
      
      private var var_628:ITextWindow;
      
      private var var_367:IBitmapWrapperWindow;
      
      private var var_627:Vector.<BitmapData>;
      
      private var var_770:Timer;
      
      private var var_442:Timer;
      
      private var var_625:int = 0;
      
      private var var_1457:int = 0;
      
      private var _disposed:Boolean = false;
      
      private var var_318:String = "catalog.club.extend.";
      
      public function ClubExtendConfirmationDialog(param1:ClubExtendController, param2:ClubOfferExtendData)
      {
         super();
         this.var_26 = param1;
         this.var_107 = param2;
         this.var_627 = new Vector.<BitmapData>(const_388);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(this._disposed)
         {
            return;
         }
         this.var_107 = null;
         this.var_26 = null;
         this.clearAnimation();
         if(this.var_626)
         {
            this.var_626.removeEventListener(WindowMouseEvent.const_25,this.onMouseOutLaterRegion);
            this.var_626.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onMouseOverLaterRegion);
            this.var_626 = null;
         }
         if(this.var_628)
         {
            this.var_628 = null;
         }
         if(this.var_367)
         {
            this.var_367 = null;
         }
         if(this.var_627)
         {
            while(_loc1_ < const_388)
            {
               this.var_627[_loc1_].dispose();
               this.var_627[_loc1_] = null;
               _loc1_++;
            }
            this.var_627 = null;
         }
         if(this._view)
         {
            this._view.dispose();
            this._view = null;
         }
         this._disposed = true;
      }
      
      public function showConfirmation() : void
      {
         var _loc2_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         if(!this.var_107 || !this.var_26 || this._disposed)
         {
            return;
         }
         this._view = this.createWindow("club_extend_confirmation") as IFrameWindow;
         if(!this._view)
         {
            return;
         }
         this._view.procedure = this.windowEventHandler;
         this._view.center();
         if(!this.var_107.vip)
         {
            this.var_318 += "basic.";
            _loc9_ = this._view.findChildByName("club_level_icon") as IIconWindow;
            if(_loc9_)
            {
               _loc9_.style = HabboIconType.const_1324;
               _loc9_.x += 15;
            }
         }
         var _loc1_:ICoreLocalizationManager = this.var_26.localization;
         this._view.findChildByName("normal_price_price").caption = this.var_107.originalPrice.toString();
         this._view.findChildByName("you_save_price").caption = this.var_107.discountAmount.toString();
         this._view.findChildByName("your_price_price").caption = this.var_107.price.toString();
         this._view.title.caption = _loc1_.getKey(this.var_318 + "confirm.caption");
         this._view.findChildByName("extend_title").caption = _loc1_.getKey(this.var_318 + "confirm.title");
         this._view.findChildByName("normal_price_label").caption = _loc1_.getKey(this.var_318 + "normal.label");
         this._view.findChildByName("you_save_label").caption = _loc1_.getKey(this.var_318 + "save.label");
         this._view.findChildByName("your_price_label").caption = _loc1_.getKey(this.var_318 + "price.label");
         this._view.findChildByName("buy_now_button").caption = _loc1_.getKey(this.var_318 + "buy.button");
         this._view.findChildByName("maybe_later_link").caption = _loc1_.getKey(this.var_318 + "later.link");
         if(this.var_107.subscriptionDaysLeft > 1)
         {
            _loc1_.registerParameter(this.var_318 + "expiration_days_left","day",this.var_107.subscriptionDaysLeft.toString());
            _loc2_ = _loc1_.getKey(this.var_318 + "expiration_days_left");
         }
         else
         {
            _loc2_ = _loc1_.getKey(this.var_318 + "expires_today");
         }
         this._view.findChildByName("offer_expiration").caption = _loc2_;
         this.var_626 = this._view.findChildByName("maybe_later_region") as IRegionWindow;
         this.var_628 = this._view.findChildByName("maybe_later_link") as ITextWindow;
         if(!this.var_626 || !this.var_628)
         {
            return;
         }
         this.var_626.addEventListener(WindowMouseEvent.const_25,this.onMouseOutLaterRegion);
         this.var_626.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onMouseOverLaterRegion);
         var _loc3_:BitmapData = this.getBitmapDataFromAsset("icon_credit_0");
         this.setElementBitmapData("normal_price_icon",_loc3_);
         this.setElementBitmapData("you_save_icon",_loc3_);
         var _loc4_:IBitmapWrapperWindow = this._view.findChildByName("club_teaser") as IBitmapWrapperWindow;
         _loc4_.x = 1;
         _loc4_.y = this._view.height - 144;
         _loc4_.height = 144;
         _loc4_.width = 133;
         this.loadAssetFromUrl("club_teaser","club_teaser",const_1466,const_1462,this.onTeaserLoaded);
         var _loc5_:IItemListWindow = this._view.findChildByName("itemlist_vertical") as IItemListWindow;
         if(!_loc5_)
         {
            return;
         }
         var _loc6_:IWindowContainer = this._view.findChildByName("total_amount_line") as IWindowContainer;
         if(!_loc6_)
         {
            return;
         }
         var _loc7_:IWindowContainer = this._view.findChildByName("background_container") as IWindowContainer;
         if(!_loc7_)
         {
            return;
         }
         _loc7_.height = _loc5_.y + _loc6_.height + _loc6_.y;
         this.var_367 = this._view.findChildByName(const_1464) as IBitmapWrapperWindow;
         if(this.var_367 == null)
         {
            return;
         }
         var _loc8_:int = 0;
         while(_loc8_ < const_388)
         {
            _loc10_ = this.var_26.assets.getAssetByName("icon_credit_" + _loc8_) as BitmapDataAsset;
            _loc11_ = _loc10_.content as BitmapData;
            this.var_627[_loc8_] = _loc11_.clone();
            _loc8_++;
         }
         this.startAnimation();
      }
      
      private function onMouseOutLaterRegion(param1:WindowMouseEvent) : void
      {
         if(this.var_628)
         {
            this.var_628.textColor = const_1461;
         }
      }
      
      private function onMouseOverLaterRegion(param1:WindowMouseEvent) : void
      {
         if(this.var_628)
         {
            this.var_628.textColor = LINK_COLOR_HOVER;
         }
      }
      
      private function startAnimation() : void
      {
         if(this.var_770)
         {
            this.clearAnimation();
         }
         this.setAnimationFrame();
         this.var_770 = new Timer(const_1465);
         this.var_770.addEventListener(TimerEvent.TIMER,this.onAnimationTrigger);
         this.var_770.start();
      }
      
      private function clearAnimation() : void
      {
         this.var_625 = 0;
         this.var_1457 = 0;
         if(this.var_442)
         {
            this.var_442.stop();
            this.var_442 = null;
         }
         if(this.var_770)
         {
            this.var_770.stop();
            this.var_770 = null;
         }
      }
      
      private function setAnimationFrame() : void
      {
         if(!this.var_367)
         {
            return;
         }
         if(this.var_367.bitmap)
         {
            this.var_367.bitmap.dispose();
         }
         if(this.var_625 < const_388)
         {
            this.var_367.bitmap = new BitmapData(this.var_367.width,this.var_367.height,true,0);
            this.var_367.bitmap.copyPixels(this.var_627[this.var_625],this.var_627[this.var_625].rect,new Point(0,0));
         }
         else
         {
            Logger.log("Animation frame " + this.var_625);
         }
      }
      
      private function startAnimationFrame() : void
      {
         this.var_442 = new Timer(const_1463,const_388 - 1);
         this.var_442.addEventListener(TimerEvent.TIMER,this.onAnimationFrame);
         this.var_442.addEventListener(TimerEvent.TIMER_COMPLETE,this.onAnimationFrameComplete);
         this.var_442.start();
      }
      
      private function onAnimationTrigger(param1:TimerEvent) : void
      {
         this.startAnimationFrame();
      }
      
      private function onAnimationFrame(param1:TimerEvent) : void
      {
         this.var_625 += 1;
         this.setAnimationFrame();
      }
      
      private function onAnimationFrameComplete(param1:TimerEvent) : void
      {
         if(this.var_442)
         {
            this.var_442.stop();
            this.var_442 = null;
         }
         this.var_625 = 0;
         this.setAnimationFrame();
         if(this.var_1457 == 0)
         {
            this.var_1457 = 1;
            this.startAnimationFrame();
         }
         else
         {
            this.var_1457 = 0;
         }
      }
      
      private function getBitmapDataFromAsset(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataAsset = this.var_26.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ != null)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
      
      private function setElementBitmapData(param1:String, param2:BitmapData) : void
      {
         var _loc3_:IBitmapWrapperWindow = this._view.findChildByName(param1) as IBitmapWrapperWindow;
         if(_loc3_.bitmap != null)
         {
            _loc3_.bitmap.dispose();
         }
         if(param2 != null && _loc3_ != null)
         {
            if(_loc3_.width != param2.width)
            {
               _loc3_.width = param2.width;
            }
            if(_loc3_.height != param2.height)
            {
               _loc3_.height = param2.height;
            }
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
      }
      
      private function loadAssetFromUrl(param1:String, param2:String, param3:String, param4:String, param5:Function) : Boolean
      {
         var _loc6_:BitmapData = this.getBitmapDataFromAsset(param2);
         if(_loc6_ != null)
         {
            this.setElementBitmapData(param1,_loc6_);
            return true;
         }
         var _loc7_:URLRequest = new URLRequest(param3);
         var _loc8_:AssetLoaderStruct = this.var_26.assets.loadAssetFromFile(param2,_loc7_,param4);
         if(!_loc8_)
         {
            return false;
         }
         _loc8_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,param5);
         return true;
      }
      
      private function onTeaserLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            _loc3_ = this.getBitmapDataFromAsset(_loc2_.assetName);
            this.setElementBitmapData("club_teaser",_loc3_);
         }
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(!param1 || !param2 || !this.var_26 || !this.var_107 || this._disposed)
         {
            return;
         }
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "buy_now_button":
               this.var_26.confirmSelection();
               break;
            case "header_button_close":
            case "maybe_later_region":
               this.var_26.closeConfirmation();
         }
      }
      
      private function createWindow(param1:String) : IWindow
      {
         if(!this.var_26 || !this.var_26.assets || !this.var_26.windowManager || this._disposed)
         {
            return null;
         }
         var _loc2_:XmlAsset = this.var_26.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc2_ || !_loc2_.content)
         {
            return null;
         }
         var _loc3_:XML = _loc2_.content as XML;
         if(!_loc3_)
         {
            return null;
         }
         return this.var_26.windowManager.buildFromXML(_loc3_);
      }
   }
}
