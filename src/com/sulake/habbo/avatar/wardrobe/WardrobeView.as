package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.avatar.common.ISideContentView;
   
   public class WardrobeView implements ISideContentView
   {
       
      
      private var _window:IWindowContainer;
      
      private var var_78:WardrobeModel;
      
      private var var_970:IItemListWindow;
      
      private var var_1187:IItemListWindow;
      
      public function WardrobeView(param1:WardrobeModel)
      {
         super();
         this.var_78 = param1;
         var _loc2_:XmlAsset = this.var_78.controller.manager.assets.getAssetByName("avatareditor_wardrobe_base") as XmlAsset;
         this._window = this.var_78.controller.manager.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         this.var_970 = this._window.findChildByName("hc_slots") as IItemListWindow;
         this.var_1187 = this._window.findChildByName("vip_slots") as IItemListWindow;
         this._window.visible = false;
         this.update();
      }
      
      public function dispose() : void
      {
         this.var_78 = null;
         this.var_970 = null;
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
      }
      
      public function update() : void
      {
         var _loc2_:* = null;
         if(this.var_970)
         {
            this.var_970.removeListItems();
         }
         if(this.var_1187)
         {
            this.var_1187.removeListItems();
         }
         var _loc1_:Array = this.var_78.slots;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            if(_loc3_ < 5)
            {
               if(this.var_970)
               {
                  this.var_970.addListItem(_loc2_.view);
                  _loc2_.view.visible = true;
               }
            }
            else if(this.var_1187)
            {
               this.var_1187.addListItem(_loc2_.view);
               _loc2_.view.visible = true;
            }
            _loc3_++;
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return this._window;
      }
   }
}
