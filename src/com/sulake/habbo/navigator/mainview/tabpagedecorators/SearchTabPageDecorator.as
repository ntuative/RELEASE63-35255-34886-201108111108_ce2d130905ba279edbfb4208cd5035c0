package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.navigator.HabboNavigator;
   
   public class SearchTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var _navigator:HabboNavigator;
      
      public function SearchTabPageDecorator(param1:HabboNavigator)
      {
         super();
         this._navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
      }
      
      public function tabSelected() : void
      {
      }
      
      public function refreshFooter(param1:IWindowContainer) : void
      {
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         this._navigator.mainViewCtrl.open();
      }
      
      public function get filterCategory() : String
      {
         return null;
      }
   }
}
