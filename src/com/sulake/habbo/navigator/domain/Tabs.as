package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.MainViewCtrl;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;
   
   public class Tabs
   {
      
      public static const const_363:int = 1;
      
      public static const const_216:int = 2;
      
      public static const const_295:int = 3;
      
      public static const const_368:int = 4;
      
      public static const const_296:int = 5;
      
      public static const const_426:int = 1;
      
      public static const const_799:int = 2;
      
      public static const const_925:int = 3;
      
      public static const const_752:int = 4;
      
      public static const const_273:int = 5;
      
      public static const const_763:int = 6;
      
      public static const const_775:int = 7;
      
      public static const const_420:int = 8;
      
      public static const const_603:int = 9;
      
      public static const const_2369:int = 10;
      
      public static const const_868:int = 11;
      
      public static const const_641:int = 12;
       
      
      private var var_484:Array;
      
      private var _navigator:HabboNavigator;
      
      public function Tabs(param1:HabboNavigator)
      {
         super();
         this._navigator = param1;
         this.var_484 = new Array();
         this.var_484.push(new Tab(this._navigator,const_363,const_641,new EventsTabPageDecorator(this._navigator),MainViewCtrl.const_612));
         this.var_484.push(new Tab(this._navigator,const_216,const_426,new RoomsTabPageDecorator(this._navigator),MainViewCtrl.const_612));
         this.var_484.push(new Tab(this._navigator,const_368,const_868,new OfficialTabPageDecorator(this._navigator),MainViewCtrl.const_1284));
         this.var_484.push(new Tab(this._navigator,const_295,const_273,new MyRoomsTabPageDecorator(this._navigator),MainViewCtrl.const_612));
         this.var_484.push(new Tab(this._navigator,const_296,const_420,new SearchTabPageDecorator(this._navigator),MainViewCtrl.const_1338));
         this.setSelectedTab(const_363);
      }
      
      public function onFrontPage() : Boolean
      {
         return this.getSelected().id == const_368;
      }
      
      public function get tabs() : Array
      {
         return this.var_484;
      }
      
      public function setSelectedTab(param1:int) : void
      {
         this.clearSelected();
         this.getTab(param1).selected = true;
      }
      
      public function getSelected() : Tab
      {
         var _loc1_:* = null;
         for each(_loc1_ in this.var_484)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function clearSelected() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in this.var_484)
         {
            _loc1_.selected = false;
         }
      }
      
      public function getTab(param1:int) : Tab
      {
         var _loc2_:* = null;
         for each(_loc2_ in this.var_484)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
