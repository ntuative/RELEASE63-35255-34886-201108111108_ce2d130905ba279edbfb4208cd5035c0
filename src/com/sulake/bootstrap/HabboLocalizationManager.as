package com.sulake.bootstrap
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IContext;
   import com.sulake.habbo.localization.HabboLocalizationManager;
   
   public class HabboLocalizationManager extends com.sulake.habbo.localization.HabboLocalizationManager
   {
       
      
      public function HabboLocalizationManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
   }
}
