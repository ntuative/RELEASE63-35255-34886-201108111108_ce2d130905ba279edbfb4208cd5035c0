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
   
   public class ShellsIndicator extends CurrencyIndicatorBase
   {
      
      private static const const_471:Array = ["icon_shell_0_png","icon_shell_1_png","icon_shell_2_png","icon_shell_3_png"];
       
      
      private const const_1556:uint = 4.283212437E9;
      
      private const const_1555:uint = 4.282748017E9;
      
      private var var_1752:int = 0;
      
      private var _catalog:IHabboCatalog;
      
      public function ShellsIndicator(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboCatalog, param4:ICoreLocalizationManager)
      {
         super(param1,param2);
         this._catalog = param3;
         this.bgColorLight = this.const_1556;
         this.bgColorDark = this.const_1555;
         this.textElementName = "amount";
         this.textElementShadowName = "amount_shadow";
         this.iconAnimationSequence = const_471.concat(const_471).concat(const_471);
         this.iconAnimationDelay = 50;
         this.amountZeroText = param4.getKey("purse.shells.zero.amount.text","Info");
         createWindow("purse_indicator_shells_xml",const_471[0]);
         this.setAmount(0);
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener(PurseEvent.const_333,this.onShellBalance);
      }
      
      override protected function onContainerClick(param1:WindowMouseEvent) : void
      {
         this._catalog.openCatalogPage(CatalogPageName.const_1780,true);
      }
      
      private function onShellBalance(param1:PurseEvent) : void
      {
         this.setAmount(param1.balance);
         if(this.var_1752 != 0)
         {
            if(this.var_1752 > param1.balance)
            {
               animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_FORWARD);
            }
            else
            {
               animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_BACKWARD);
            }
         }
         this.var_1752 = param1.balance;
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
