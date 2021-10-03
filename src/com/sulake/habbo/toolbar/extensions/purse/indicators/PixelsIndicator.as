package com.sulake.habbo.toolbar.extensions.purse.indicators
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.enum.CatalogPageName;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.toolbar.extensions.purse.CurrencyIndicatorBase;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class PixelsIndicator extends CurrencyIndicatorBase
   {
      
      private static const const_1556:uint = 4285767869;
      
      private static const const_1555:uint = 4283664040;
      
      private static const const_471:Array = ["icon_pixel_0_png","icon_pixel_1_png","icon_pixel_2_png","icon_pixel_3_png"];
       
      
      private var var_1908:int = 0;
      
      private var _catalog:IHabboCatalog;
      
      public function PixelsIndicator(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboCatalog, param4:ICoreLocalizationManager)
      {
         super(param1,param2);
         this._catalog = param3;
         this.bgColorLight = const_1556;
         this.bgColorDark = const_1555;
         this.textElementName = "pixels";
         this.textElementShadowName = "pixels_shadow";
         this.iconAnimationSequence = const_471.concat(const_471);
         this.iconAnimationDelay = 50;
         this.amountZeroText = param4.getKey("purse.pixels.zero.amount.text","Get");
         createWindow("purse_indicator_pixels_xml",const_471[0]);
         this.setAmount(0);
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener(PurseEvent.const_344,this.onPixelBalance);
      }
      
      override protected function onContainerClick(param1:WindowMouseEvent) : void
      {
         this._catalog.openCatalogPage(CatalogPageName.const_1973);
      }
      
      private function onPixelBalance(param1:PurseEvent) : void
      {
         this.setAmount(param1.balance);
         if(this.var_1908 != 0)
         {
            if(this.var_1908 > param1.balance)
            {
               animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_FORWARD);
            }
            else
            {
               animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_BACKWARD);
            }
         }
         this.var_1908 = param1.balance;
      }
      
      private function setAmount(param1:int) : void
      {
         var _loc2_:String = param1.toString();
         if(param1 == 0)
         {
            _loc2_ = this.amountZeroText;
            setTextUnderline(true);
         }
         else
         {
            setTextUnderline(false);
         }
         setText(_loc2_);
      }
   }
}
