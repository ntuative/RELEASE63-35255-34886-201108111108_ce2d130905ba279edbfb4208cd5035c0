package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IDropMenuWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.domain.Tabs;
   
   public class RoomsTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_160:IDropMenuWindow;
      
      public function RoomsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         this._navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
         var _loc3_:IWindowContainer = param1.getChildByName("rooms_header") as IWindowContainer;
         if(this.var_160 == null)
         {
            this.var_160 = IDropMenuWindow(_loc3_.findChildByName("roomCtgFilter"));
            this.prepareRoomCategories();
            this.var_160.addEventListener(WindowEvent.const_47,this.onFilterSelected);
         }
         _loc3_.visible = true;
      }
      
      public function tabSelected() : void
      {
         if(this.var_160 != null)
         {
            this.var_160.removeEventListener(WindowEvent.const_47,this.onFilterSelected);
            this.var_160.selection = 0;
            this.var_160.addEventListener(WindowEvent.const_47,this.onFilterSelected);
         }
      }
      
      public function refreshFooter(param1:IWindowContainer) : void
      {
         this._navigator.officialRoomEntryManager.refreshAdFooter(param1);
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         this.startSearch();
      }
      
      public function prepareRoomCategories() : void
      {
         var _loc3_:* = null;
         if(this.var_160 == null)
         {
            return;
         }
         var _loc1_:Array = new Array();
         _loc1_.push(this._navigator.getText("navigator.navisel.popularrooms"));
         _loc1_.push(this._navigator.getText("navigator.navisel.highestscore"));
         for each(_loc3_ in this._navigator.data.visibleCategories)
         {
            _loc1_.push(_loc3_.nodeName);
         }
         this.var_160.populate(_loc1_);
         this.var_160.selection = 0;
      }
      
      private function onFilterSelected(param1:WindowEvent) : void
      {
         this.startSearch();
      }
      
      private function startSearch() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:int = this.var_160 == null ? 0 : int(this.var_160.selection);
         Logger.log("Room filter changed: " + _loc1_);
         if(_loc1_ == 0)
         {
            this._navigator.mainViewCtrl.startSearch(Tabs.const_216,Tabs.const_426);
         }
         else if(_loc1_ == 1)
         {
            this._navigator.mainViewCtrl.startSearch(Tabs.const_216,Tabs.const_799);
         }
         else
         {
            _loc2_ = this._navigator.data.visibleCategories[_loc1_ - 2];
            if(_loc2_ == null)
            {
               Logger.log("No fc found: " + _loc1_ + ", " + this._navigator.data.visibleCategories.length);
               return;
            }
            _loc3_ = _loc2_.nodeId;
            Logger.log("Searching with catId: " + _loc3_);
            this._navigator.mainViewCtrl.startSearch(Tabs.const_216,Tabs.const_426,"" + _loc3_);
         }
         if(this.var_160)
         {
            this._navigator.trackNavigationDataPoint(this.var_160.enumerateSelection()[this.var_160.selection],"category.view");
         }
      }
      
      public function get filterCategory() : String
      {
         return !!this.var_160 ? this.var_160.enumerateSelection()[this.var_160.selection] : null;
      }
   }
}
