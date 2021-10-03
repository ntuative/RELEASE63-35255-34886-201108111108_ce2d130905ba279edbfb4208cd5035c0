package com.sulake.habbo.toolbar.extensions.purse.indicators
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.enum.CatalogPageName;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.session.HabboClubLevelEnum;
   import com.sulake.habbo.toolbar.extensions.purse.CurrencyIndicatorBase;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class ClubDaysIndicator extends CurrencyIndicatorBase
   {
      
      private static const const_1556:uint = 4286084205;
      
      private static const const_1555:uint = 4283781966;
      
      private static const const_1468:int = 13;
      
      private static const const_1162:int = 14;
       
      
      private var _catalog:IHabboCatalog;
      
      private var var_12:IHabboInventory;
      
      public function ClubDaysIndicator(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboCatalog, param4:IHabboInventory, param5:ICoreLocalizationManager)
      {
         super(param1,param2);
         this._catalog = param3;
         this.var_12 = param4;
         this.bgColorLight = const_1556;
         this.bgColorDark = const_1555;
         this.textElementName = "days";
         this.textElementShadowName = "days_shadow";
         this.amountZeroText = param5.getKey("purse.clubdays.zero.amount.text","Get");
         createWindow("purse_indicator_club_xml","");
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener(HabboInventoryHabboClubEvent.const_231,this.onClubChanged);
      }
      
      override protected function onContainerClick(param1:WindowMouseEvent) : void
      {
         this._catalog.openCatalogPage(CatalogPageName.const_176,true);
      }
      
      private function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         var _loc2_:int = this.var_12.clubPeriods * 31 + this.var_12.clubDays;
         setText(_loc2_.toString());
         switch(this.var_12.clubLevel)
         {
            case HabboClubLevelEnum.const_52:
               this.setClubIcon(const_1162);
               setText(this.amountZeroText);
               setTextUnderline(true);
               break;
            case HabboClubLevelEnum.const_33:
               this.setClubIcon(const_1468);
               setTextUnderline(false);
               break;
            case HabboClubLevelEnum.const_35:
               this.setClubIcon(const_1162);
               setTextUnderline(false);
         }
      }
      
      private function setClubIcon(param1:int) : void
      {
         var _loc2_:IIconWindow = this.view.findChildByName("club_icon") as IIconWindow;
         if(_loc2_)
         {
            _loc2_.style = param1;
            _loc2_.invalidate();
         }
      }
   }
}
