package com.sulake.bootstrap
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IContext;
   import com.sulake.habbo.notifications.HabboNotifications;
   
   public class HabboNotifications extends com.sulake.habbo.notifications.HabboNotifications
   {
       
      
      public function HabboNotifications(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
   }
}
