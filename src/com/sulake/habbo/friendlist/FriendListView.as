package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IFrameWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.friendlist.events.HabboFriendListTrackingEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class FriendListView
   {
      
      private static const const_1510:Point = new Point(110,50);
       
      
      private var _friendList:HabboFriendList;
      
      private var var_2171:FriendListTabsView;
      
      private var var_16:IFrameWindow;
      
      private var var_1108:IWindowContainer;
      
      private var var_284:IWindowContainer;
      
      private var var_1692:ITextWindow;
      
      private var var_2173:int = -1;
      
      private var var_2174:int = -1;
      
      private var var_2172:Boolean;
      
      public function FriendListView(param1:HabboFriendList)
      {
         super();
         this._friendList = param1;
         this.var_2171 = new FriendListTabsView(this._friendList);
      }
      
      public function isFriendListOpen() : Boolean
      {
         return this.var_16 != null && this.var_16.visible;
      }
      
      public function openFriendList() : void
      {
         if(this.var_16 == null)
         {
            this.prepare();
            this.var_16.position = const_1510;
         }
         else
         {
            this.var_16.visible = true;
            this.var_16.activate();
         }
      }
      
      public function showInfo(param1:WindowEvent, param2:String) : void
      {
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.type == WindowMouseEvent.const_25)
         {
            this.var_1692.text = "";
         }
         else if(_loc3_.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            this.var_1692.text = param2;
         }
      }
      
      public function refresh(param1:String) : void
      {
         if(this.var_16 == null)
         {
            return;
         }
         this.var_2171.refresh(param1);
         this.refreshWindowSize();
      }
      
      public function close() : void
      {
         if(this.var_16 != null)
         {
            this.var_16.visible = false;
         }
      }
      
      public function isOpen() : Boolean
      {
         return this.var_16 && this.var_16.visible;
      }
      
      private function prepare() : void
      {
         this.var_16 = IFrameWindow(this._friendList.getXmlWindow("main_window"));
         this.var_16.findChildByTag("close").procedure = this.onWindowClose;
         this.var_1108 = IWindowContainer(this.var_16.content.findChildByName("main_content"));
         this.var_284 = IWindowContainer(this.var_16.content.findChildByName("footer"));
         this.var_2171.prepare(this.var_1108);
         this.var_16.procedure = this.onWindow;
         this.var_16.content.setParamFlag(HabboWindowParam.const_1188,false);
         this.var_16.content.setParamFlag(HabboWindowParam.const_1307,true);
         this.var_16.header.setParamFlag(HabboWindowParam.const_939,false);
         this.var_16.header.setParamFlag(HabboWindowParam.const_960,true);
         this.var_16.content.setParamFlag(HabboWindowParam.const_939,false);
         this.var_16.content.setParamFlag(HabboWindowParam.const_960,true);
         this.var_16.findChildByName("open_edit_ctgs_but").procedure = this.onEditCategoriesButtonClick;
         this.var_1692 = ITextWindow(this.var_16.findChildByName("info_text"));
         this.var_1692.text = "";
         this._friendList.refreshButton(this.var_16,"open_edit_ctgs",true,null,0);
         this.var_16.title.color = 4294623744;
         this.var_16.title.textColor = 4287851525;
         this.refresh("prepare");
         this.var_16.height = 350;
         this.var_16.width = 230;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Close window");
         this.var_16.visible = false;
         this._friendList.trackFriendListEvent(HabboFriendListTrackingEvent.HABBO_FRIENDLIST_TRACKIG_EVENT_CLOSED);
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_41 || param2 != this.var_16)
         {
            return;
         }
         if(this.var_2172)
         {
            return;
         }
         var _loc3_:int = this.var_2173 == -1 ? 0 : int(this.var_16.height - this.var_2173);
         var _loc4_:int = this.var_2174 == -1 ? 0 : int(this.var_16.width - this.var_2174);
         this._friendList.tabs.tabContentHeight = Math.max(100,this._friendList.tabs.tabContentHeight + _loc3_);
         this._friendList.tabs.windowWidth = Math.max(147,this._friendList.tabs.windowWidth + _loc4_);
         this.refresh("resize: " + _loc3_);
      }
      
      private function refreshWindowSize() : void
      {
         this.var_2172 = true;
         this.var_284.visible = false;
         this.var_284.y = Util.getLowestPoint(this.var_16.content);
         this.var_284.width = this._friendList.tabs.windowWidth;
         this.var_284.visible = true;
         this.var_16.content.height = Util.getLowestPoint(this.var_16.content);
         this.var_16.content.width = this._friendList.tabs.windowWidth - 10;
         this.var_16.header.width = this._friendList.tabs.windowWidth - 10;
         this.var_16.height = this.var_16.content.height + 30;
         this.var_16.width = this._friendList.tabs.windowWidth;
         this.var_2172 = false;
         this.var_16.scaler.setParamFlag(HabboWindowParam.const_951,false);
         this.var_16.scaler.setParamFlag(HabboWindowParam.const_1231,this._friendList.tabs.findSelectedTab() != null);
         this.var_16.scaler.setParamFlag(HabboWindowParam.const_939,false);
         this.var_16.scaler.setParamFlag(HabboWindowParam.const_1188,false);
         this.var_16.scaler.x = this.var_16.width - this.var_16.scaler.width;
         this.var_16.scaler.y = this.var_16.height - this.var_16.scaler.height;
         this.var_2173 = this.var_16.height;
         this.var_2174 = this.var_16.width;
         Logger.log("RESIZED: " + this._friendList.tabs.windowWidth);
      }
      
      private function onEditCategoriesButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         this._friendList.view.showInfo(param1,"${friendlist.tip.preferences}");
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         Logger.log("Edit categories clicked");
         var _loc3_:WindowMouseEvent = param1 as WindowMouseEvent;
         this._friendList.openHabboWebPage("link.format.friendlist.pref",new Dictionary(),_loc3_.stageX,_loc3_.stageY);
      }
      
      public function get mainWindow() : IWindowContainer
      {
         return this.var_16;
      }
   }
}
