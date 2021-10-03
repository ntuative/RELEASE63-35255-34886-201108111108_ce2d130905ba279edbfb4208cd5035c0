package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
   import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.catalog.HabboClubExtendOfferMessageParser;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class ClubExtendController
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var var_208:ClubExtendConfirmationDialog;
      
      private var var_107:ClubOfferExtendData;
      
      private var _disposed:Boolean = false;
      
      public function ClubExtendController(param1:HabboCatalog)
      {
         super();
         this._catalog = param1;
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this.closeConfirmation();
         this.var_107 = null;
         this._catalog = null;
         this._disposed = true;
      }
      
      public function onOffer(param1:HabboClubExtendOfferMessageEvent) : void
      {
         if(this._disposed)
         {
            return;
         }
         var _loc2_:HabboClubExtendOfferMessageParser = param1.getParser();
         this.var_107 = _loc2_.offer();
         this.showConfirmation();
         if(this._catalog.connection)
         {
            if(this.var_107.vip)
            {
               this._catalog.connection.send(new EventLogMessageComposer("Catalog","dialog_show","vip.membership.extension.purchase"));
            }
            else
            {
               this._catalog.connection.send(new EventLogMessageComposer("Catalog","dialog_show","basic.membership.extension.purchase"));
            }
         }
      }
      
      public function closeConfirmation() : void
      {
         if(this.var_208)
         {
            this.var_208.dispose();
            this.var_208 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         this.closeConfirmation();
         this.var_208 = new ClubExtendConfirmationDialog(this,this.var_107);
         this.var_208.showConfirmation();
      }
      
      public function confirmSelection() : void
      {
         if(!this._catalog || !this._catalog.connection || !this.var_107)
         {
            return;
         }
         if(this.var_107.vip)
         {
            this._catalog.purchaseVipMembershipExtension(this.var_107.offerId);
         }
         else
         {
            this._catalog.purchaseBasicMembershipExtension(this.var_107.offerId);
         }
         this.closeConfirmation();
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         if(!this._catalog)
         {
            return null;
         }
         return this._catalog.windowManager;
      }
      
      public function get localization() : ICoreLocalizationManager
      {
         if(!this._catalog)
         {
            return null;
         }
         return this._catalog.localization;
      }
      
      public function get assets() : IAssetLibrary
      {
         if(!this._catalog)
         {
            return null;
         }
         return this._catalog.assets;
      }
   }
}
