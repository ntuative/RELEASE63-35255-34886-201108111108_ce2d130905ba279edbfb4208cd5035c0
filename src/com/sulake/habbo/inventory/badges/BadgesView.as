package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IButtonWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BadgesView implements IInventoryView
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _view:IWindowContainer;
      
      private var var_78:BadgesModel;
      
      private var var_750:IItemGridWindow;
      
      private var var_1147:IItemGridWindow;
      
      private var _disposed:Boolean = false;
      
      public function BadgesView(param1:BadgesModel, param2:IHabboWindowManager, param3:IAssetLibrary)
      {
         super();
         this.var_78 = param1;
         this._windowManager = param2;
         var _loc4_:IAsset = param3.getAssetByName("inventory_badges_xml");
         var _loc5_:XmlAsset = XmlAsset(_loc4_);
         this._view = IWindowContainer(this._windowManager.buildFromXML(XML(_loc5_.content)));
         this._view.visible = false;
         var _loc6_:IWindow = this._view.findChildByName("wearBadge_button");
         if(_loc6_ != null)
         {
            _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onWearBadgeClick);
         }
         this.var_750 = this._view.findChildByName("inactive_items") as IItemGridWindow;
         this.var_750.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onInactiveBadgeClick);
         this.var_1147 = this._view.findChildByName("active_items") as IItemGridWindow;
         this.var_1147.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onActiveBadgeClick);
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         this._windowManager = null;
         this.var_78 = null;
         this.var_750 = null;
         this.var_1147 = null;
         if(this._view)
         {
            this._view.dispose();
            this._view = null;
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(this._view == null || this._view.disposed)
         {
            return null;
         }
         return this._view;
      }
      
      public function get isVisible() : Boolean
      {
         return this._view.parent != null && this._view.visible;
      }
      
      public function updateAll() : void
      {
         this.updateListViews();
         this.updateActionView();
      }
      
      private function updateListViews() : void
      {
         var _loc3_:* = null;
         if(this._view == null || this._view.disposed)
         {
            return;
         }
         var _loc1_:Number = this.var_750.scrollV;
         this.var_750.removeGridItems();
         this.var_1147.removeGridItems();
         var _loc2_:Array = this.var_78.getBadges(BadgesModel.const_615);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_] as Badge;
            if(!_loc3_.isInUse)
            {
               this.var_750.addGridItem(_loc3_.window);
               _loc3_.window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onInactiveBadgeClick);
            }
            _loc4_++;
         }
         if(_loc1_ > 0)
         {
            this.var_750.scrollV = _loc1_;
         }
         var _loc5_:Array = this.var_78.getBadges(BadgesModel.const_339);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc4_] as Badge;
            this.var_1147.addGridItem(_loc3_.window);
            _loc3_.window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onActiveBadgeClick);
            _loc4_++;
         }
      }
      
      public function updateActionView() : void
      {
         var _loc3_:* = null;
         if(this._view == null || this._view.disposed)
         {
            return;
         }
         var _loc1_:IButtonWindow = this._view.findChildByName("wearBadge_button") as IButtonWindow;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:Badge = this.var_78.getSelectedBadge();
         if(_loc2_ == null)
         {
            _loc1_.disable();
            this.setBadgeName(null);
            this.setBadgeDescriptionText(null);
            this.setBadgeDescriptionImage(null);
         }
         else
         {
            if(_loc2_.isInUse)
            {
               _loc1_.caption = "${inventory.badges.clearbadge}";
            }
            else
            {
               _loc1_.caption = "${inventory.badges.wearbadge}";
            }
            this.setBadgeName(this.var_78.controller.localization.getBadgeName(_loc2_.type));
            this.setBadgeDescriptionText(this.var_78.controller.localization.getBadgeDesc(_loc2_.type));
            this.setBadgeDescriptionImage(_loc2_.iconImage);
            _loc3_ = this.var_78.getBadges(BadgesModel.const_339);
            if(_loc3_ != null && _loc3_.length >= this.var_78.getMaxActiveCount() && !_loc2_.isInUse)
            {
               _loc1_.disable();
            }
            else
            {
               _loc1_.enable();
            }
         }
      }
      
      private function setBadgeDescriptionImage(param1:BitmapData) : void
      {
         if(this._view == null || this._view.disposed)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = this._view.findChildByName("badgeDescriptionImage") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.bitmap != null)
         {
            _loc2_.bitmap.dispose();
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc2_.bitmap.fillRect(_loc2_.bitmap.rect,0);
         if(param1 == null)
         {
            param1 = new BitmapData(_loc2_.width,_loc2_.height);
         }
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,true);
         _loc2_.invalidate();
      }
      
      private function setBadgeName(param1:String) : void
      {
         if(this._view == null || this._view.disposed)
         {
            return;
         }
         var _loc2_:ITextWindow = this._view.findChildByName("badgeName") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc2_.text = "";
         }
         else
         {
            _loc2_.text = "";
            _loc2_.text = param1;
         }
      }
      
      private function setBadgeDescriptionText(param1:String) : void
      {
         if(this._view == null || this._view.disposed)
         {
            return;
         }
         var _loc2_:ITextWindow = this._view.findChildByName("badgeDescriptionText") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc2_.text = "${inventory.effects.defaultdescription}";
         }
         else
         {
            _loc2_.text = "";
            _loc2_.text = param1;
         }
      }
      
      private function onInactiveBadgeClick(param1:WindowEvent) : void
      {
         var _loc2_:int = this.var_750.getGridItemIndex(param1.window);
         var _loc3_:Badge = this.var_78.getBadgeFromInactive(_loc2_);
         if(_loc3_ != null)
         {
            this.var_78.setBadgeSelected(_loc3_.type);
         }
      }
      
      private function onActiveBadgeClick(param1:WindowEvent) : void
      {
         var _loc2_:int = this.var_1147.getGridItemIndex(param1.window);
         var _loc3_:Badge = this.var_78.getBadgeFromActive(_loc2_);
         if(_loc3_ != null)
         {
            this.var_78.setBadgeSelected(_loc3_.type);
         }
      }
      
      private function onWearBadgeClick(param1:WindowEvent) : void
      {
         var _loc2_:Badge = this.var_78.getSelectedBadge();
         if(_loc2_ != null)
         {
            this.var_78.toggleBadgeWearing(_loc2_.type);
         }
      }
   }
}
