package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.session.product.IProductData;
   
   public class ClubGiftConfirmationDialog
   {
       
      
      private var var_107:Offer;
      
      private var var_26:ClubGiftController;
      
      private var _view:IFrameWindow;
      
      public function ClubGiftConfirmationDialog(param1:ClubGiftController, param2:Offer)
      {
         super();
         this.var_107 = param2;
         this.var_26 = param1;
         this.showConfirmation();
      }
      
      public function dispose() : void
      {
         this.var_26 = null;
         this.var_107 = null;
         if(this._view)
         {
            this._view.dispose();
            this._view = null;
         }
      }
      
      public function showConfirmation() : void
      {
         if(!this.var_107 || !this.var_26)
         {
            return;
         }
         this._view = this.createWindow("club_gift_confirmation") as IFrameWindow;
         if(!this._view)
         {
            return;
         }
         this._view.procedure = this.windowEventHandler;
         this._view.center();
         var _loc1_:ITextWindow = this._view.findChildByName("item_name") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.text = this.getProductName();
         }
         var _loc2_:IWindowContainer = this._view.findChildByName("image_border") as IWindowContainer;
         if(!_loc2_)
         {
            return;
         }
         if(!this.var_107.productContainer)
         {
            return;
         }
         this.var_107.productContainer.view = _loc2_;
         this.var_107.productContainer.initProductIcon(this.var_26.roomEngine);
      }
      
      private function getProductName() : String
      {
         var _loc1_:* = null;
         if(this.var_107 && this.var_107.productContainer && this.var_107.productContainer.firstProduct)
         {
            _loc1_ = this.var_107.productContainer.firstProduct.productData;
            if(_loc1_)
            {
               return _loc1_.name;
            }
         }
         return "";
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(!param1 || !param2 || !this.var_26 || !this.var_107)
         {
            return;
         }
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "select_button":
               this.var_26.confirmSelection(this.var_107.localizationId);
               break;
            case "header_button_close":
            case "cancel_button":
               this.var_26.closeConfirmation();
         }
      }
      
      private function createWindow(param1:String) : IWindow
      {
         if(!this.var_26 || !this.var_26.assets || !this.var_26.windowManager)
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
