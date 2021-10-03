package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.enum.CatalogPageName;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.session.HabboClubLevelEnum;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.tracking.HabboTracking;
   
   public class PurchaseCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
       
      
      private var var_2623:XML;
      
      private var var_2626:XML;
      
      private var var_2622:XML;
      
      private var var_2627:XML;
      
      private var var_2625:XML;
      
      private var var_2624:XML;
      
      private var var_1022:IWindowContainer;
      
      private var var_670:IButtonWindow;
      
      private var var_3149:IButtonWindow;
      
      private var var_1904:IButtonWindow;
      
      private var var_1902:ITextWindow;
      
      private var var_1905:ITextWindow;
      
      private var var_1906:ITextWindow;
      
      private var var_3109:ITextWindow;
      
      private var var_107:Offer;
      
      private var var_1903:String = "";
      
      private var var_1530:Function;
      
      private var var_33:ISessionDataManager;
      
      public function PurchaseCatalogWidget(param1:IWindowContainer, param2:ISessionDataManager)
      {
         super(param1);
         this.var_33 = param2;
      }
      
      override public function dispose() : void
      {
         events.removeEventListener(WidgetEvent.CWE_SELECT_PRODUCT,this.onSelectProduct);
         events.removeEventListener(WidgetEvent.const_737,this.onSetParameter);
         events.removeEventListener(WidgetEvent.CWE_PURCHASE_OVERRIDE,this.onPurchaseOverride);
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsStub") as XmlAsset;
         if(_loc1_ != null)
         {
            this.var_2623 = _loc1_.content as XML;
         }
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetPixelsStub") as XmlAsset;
         if(_loc2_ != null)
         {
            this.var_2626 = _loc2_.content as XML;
         }
         var _loc3_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsPixelsStub") as XmlAsset;
         if(_loc3_ != null)
         {
            this.var_2622 = _loc3_.content as XML;
         }
         var _loc4_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetCreditsOrCreditsAndPixelsStub") as XmlAsset;
         var _loc5_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyClubStub") as XmlAsset;
         if(_loc5_ != null)
         {
            this.var_2627 = _loc5_.content as XML;
         }
         var _loc6_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset;
         if(_loc6_ != null)
         {
            this.var_2625 = _loc6_.content as XML;
         }
         var _loc7_:XmlAsset = page.viewer.catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset;
         if(_loc7_ != null)
         {
            this.var_2624 = _loc7_.content as XML;
         }
         events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT,this.onSelectProduct);
         events.addEventListener(WidgetEvent.const_737,this.onSetParameter);
         events.addEventListener(WidgetEvent.CWE_PURCHASE_OVERRIDE,this.onPurchaseOverride);
         events.addEventListener(WidgetEvent.CWE_INIT_PURCHASE,this.initPurchase);
         return true;
      }
      
      private function onPurchaseOverride(param1:CatalogWidgetPurchaseOverrideEvent) : void
      {
         this.var_1530 = param1.callback;
      }
      
      private function attachStub(param1:String, param2:int) : void
      {
         var _loc3_:* = null;
         if(this.var_33.hasUserRight(null,param2))
         {
            switch(param1)
            {
               case Offer.const_883:
                  _loc3_ = page.viewer.catalog.windowManager.buildFromXML(this.var_2623) as IWindowContainer;
                  break;
               case Offer.const_1342:
                  _loc3_ = page.viewer.catalog.windowManager.buildFromXML(this.var_2626) as IWindowContainer;
                  break;
               case Offer.const_1279:
                  _loc3_ = page.viewer.catalog.windowManager.buildFromXML(this.var_2622) as IWindowContainer;
                  break;
               default:
                  Logger.log("Unknown price-type, can\'t attach..." + this.var_107.priceType);
            }
         }
         else
         {
            switch(param2)
            {
               case HabboClubLevelEnum.const_33:
                  _loc3_ = page.viewer.catalog.windowManager.buildFromXML(this.var_2627) as IWindowContainer;
                  break;
               case HabboClubLevelEnum.const_35:
                  if(!this.var_33.hasUserRight(null,HabboClubLevelEnum.const_33))
                  {
                     _loc3_ = page.viewer.catalog.windowManager.buildFromXML(this.var_2625) as IWindowContainer;
                  }
                  else
                  {
                     _loc3_ = page.viewer.catalog.windowManager.buildFromXML(this.var_2624) as IWindowContainer;
                  }
            }
         }
         if(_loc3_ != null)
         {
            if(this.var_1022 != null)
            {
               _window.removeChild(this.var_1022);
               this.var_1022.dispose();
            }
            this.var_1022 = _loc3_;
            _window.addChild(_loc3_);
            this.var_1022.x = 0;
            this.var_1022.y = 0;
         }
         this.var_1902 = _window.findChildByName("ctlg_price_credits") as ITextWindow;
         this.var_1905 = _window.findChildByName("ctlg_price_pixels") as ITextWindow;
         this.var_1906 = _window.findChildByName("ctlg_price_credits_pixels") as ITextWindow;
         this.var_3109 = _window.findChildByName("ctlg_special_txt") as ITextWindow;
         this.var_670 = window.findChildByName("ctlg_buy_button") as IButtonWindow;
         this.var_1904 = window.findChildByName("ctlg_buy_club_button") as IButtonWindow;
         if(this.var_670 != null)
         {
            if(this.var_1530 != null)
            {
               this.var_670.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.var_1530);
            }
            else
            {
               this.var_670.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.var_1530);
               this.var_670.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onPurchase);
            }
            this.var_670.disable();
         }
         if(this.var_1904 != null)
         {
            this.var_1904.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onBuyClub);
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:ICoreLocalizationManager = (page.viewer.catalog as HabboCatalog).localization;
         this.var_107 = param1.offer;
         this.attachStub(this.var_107.priceType,this.var_107.clubLevel);
         if(this.var_1902 != null)
         {
            _loc2_.registerParameter("catalog.purchase.price.credits","credits",String(this.var_107.priceInCredits));
            this.var_1902.caption = "${catalog.purchase.price.credits}";
         }
         var _loc3_:String = this.var_107.activityPointType == ActivityPointTypeEnum.PIXEL ? "pixels" : "activitypoints";
         if(this.var_1905 != null)
         {
            _loc4_ = "catalog.purchase.price.activitypoints." + this.var_107.activityPointType;
            _loc2_.registerParameter(_loc4_,_loc3_,this.var_107.priceInActivityPoints.toString());
            this.var_1905.caption = _loc2_.getKey(_loc4_);
         }
         if(this.var_1906 != null)
         {
            _loc4_ = "catalog.purchase.price.credits_and_activitypoints." + this.var_107.activityPointType;
            _loc2_.registerParameter(_loc4_,"credits",String(this.var_107.priceInCredits));
            _loc2_.registerParameter(_loc4_,_loc3_,String(this.var_107.priceInActivityPoints));
            this.var_1906.caption = _loc2_.getKey(_loc4_);
         }
         var _loc5_:IWindow = _window.findChildByName("activity_points_bg");
         if(_loc5_ != null)
         {
            _loc5_.color = this.var_107.activityPointType == 0 ? 6737151 : uint(13421772);
         }
         if(this.var_670 != null)
         {
            this.var_670.enable();
         }
      }
      
      private function onSetParameter(param1:SetExtraPurchaseParameterEvent) : void
      {
         this.var_1903 = param1.parameter;
      }
      
      private function onPurchase(param1:WindowMouseEvent) : void
      {
         if(this.var_107 != null)
         {
            (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this.var_107,page.pageId,this.var_1903);
         }
      }
      
      private function initPurchase(param1:CatalogWidgetInitPurchaseEvent) : void
      {
         if(this.var_107 != null)
         {
            (page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this.var_107,page.pageId,this.var_1903,param1.enableBuyAsGift);
         }
      }
      
      private function onBuyClub(param1:WindowMouseEvent) : void
      {
         (page.viewer.catalog as HabboCatalog).openCatalogPage(CatalogPageName.const_176,true);
         HabboTracking.getInstance().trackEventLog("Catalog","click","BUY_CLUB");
      }
   }
}
