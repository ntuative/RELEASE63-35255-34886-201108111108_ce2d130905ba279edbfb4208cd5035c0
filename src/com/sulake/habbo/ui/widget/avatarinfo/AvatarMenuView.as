package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   
   public class AvatarMenuView extends AvatarInfoView
   {
      
      protected static const const_1043:uint = 1;
      
      protected static const const_1042:uint = 2;
      
      protected static var var_1452:uint = const_1043;
      
      private static const const_1571:uint = 16744755;
      
      private static const const_1572:uint = 16756591;
      
      private static const const_1053:int = 8;
       
      
      protected var _data:AvatarInfoData;
      
      protected var var_701:uint = 1;
      
      protected var var_1729:Boolean;
      
      private var _buttons:IItemListWindow;
      
      public function AvatarMenuView(param1:AvatarInfoWidget)
      {
         super(param1);
         var_1169 = false;
      }
      
      public static function setup(param1:AvatarMenuView, param2:int, param3:String, param4:int, param5:int, param6:AvatarInfoData) : void
      {
         param1._data = param6;
         AvatarInfoView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,onMouseHoverEvent);
            _window.removeEventListener(WindowMouseEvent.const_25,onMouseHoverEvent);
         }
         this._buttons = null;
         this._data = null;
         super.dispose();
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:* = null;
         if(!_widget || true || true)
         {
            return;
         }
         if(var_1174)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(_widget.assets.getAssetByName("avatar_menu_widget")).content as XML;
               _window = _widget.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,onMouseHoverEvent);
               _window.addEventListener(WindowMouseEvent.const_25,onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,onMinimize);
               _window.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,onMinimizeHover);
               _window.findChildByName("minimize").addEventListener(WindowMouseEvent.const_25,onMinimizeHover);
            }
            this._buttons = _window.findChildByName("buttons") as IItemListWindow;
            this._buttons.procedure = this.buttonEventProc;
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            this.updateButtons();
         }
      }
      
      protected function updateButtons() : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(!_window || !this._data)
         {
            return;
         }
         var _loc1_:IItemListWindow = _window.findChildByName("buttons") as IItemListWindow;
         if(!_loc1_)
         {
            return;
         }
         _loc1_.procedure = this.buttonEventProc;
         _loc1_.autoArrangeItems = false;
         var _loc2_:int = _loc1_.numListItems;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.getListItemAt(_loc3_).visible = false;
            _loc3_++;
         }
         if(!this.var_1729)
         {
            if(this._data.isIgnored)
            {
               this.var_701 = const_1042;
            }
            else
            {
               this.var_701 = var_1452;
            }
         }
         if(this.var_701 == const_1043)
         {
            this.showButton("moderate");
            this.showButton("friend",this._data.canBeAskedAsFriend);
            _loc4_ = this._data.respectLeft;
            _widget.localizations.registerParameter("infostand.button.respect","count",_loc4_.toString());
            this.showButton("respect",_loc4_ > 0);
            this.showButton("trade",this._data.canTrade);
            switch(this._data.canTradeReason)
            {
               case RoomWidgetUserInfoUpdateEvent.const_818:
                  _loc5_ = "${infostand.button.trade.tooltip.shutdown}";
                  break;
               case RoomWidgetUserInfoUpdateEvent.const_932:
                  _loc5_ = "${infostand.button.trade.tooltip.tradingroom}";
                  break;
               default:
                  _loc5_ = "";
            }
            IInteractiveWindow(IWindowContainer(_loc1_.getListItemByName("trade")).getChildByName("button")).toolTipCaption = _loc5_;
            this.showButton("whisper");
         }
         if(this.var_701 == const_1042)
         {
            this.showButton("ignore",!this._data.isIgnored);
            this.showButton("unignore",this._data.isIgnored);
            this.showButton("kick",(this._data.amIOwner || this._data.amIController || this._data.amIAnyRoomController) && this._data.canBeKicked);
            this.showButton("ban",(this._data.amIOwner || this._data.amIAnyRoomController) && this._data.canBeKicked);
            this.showButton("report",false && _widget.configuration.getBoolean("infostand.report.show",false));
            this.showButton("give_rights",this._data.amIOwner && !this._data.hasFlatControl);
            this.showButton("remove_rights",this._data.amIOwner && this._data.hasFlatControl);
            this.showButton("actions");
         }
         _loc1_.autoArrangeItems = true;
         _loc1_.visible = true;
         var_1452 = this.var_701;
         this.var_1729 = false;
      }
      
      private function showButton(param1:String, param2:Boolean = true) : void
      {
         if(!this._buttons)
         {
            return;
         }
         var _loc3_:IWindowContainer = this._buttons.getListItemByName(param1) as IWindowContainer;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.visible = param2;
         var _loc4_:IWindowContainer = _loc3_.getChildByName("button") as IWindowContainer;
         var _loc5_:ITextWindow = _loc4_.getChildByName("label") as ITextWindow;
         var _loc6_:IIconWindow = _loc4_.getChildByName("icon") as IIconWindow;
         if(_loc6_)
         {
            if(_loc6_.tags.indexOf("arrow_left") != -1)
            {
               _loc6_.x = _loc5_.x + (_loc5_.width - _loc5_.textWidth) / 2 - _loc6_.width - const_1053;
            }
            if(_loc6_.tags.indexOf("arrow_right") != -1)
            {
               _loc6_.x = _loc5_.x + (_loc5_.width + _loc5_.textWidth) / 2 + const_1053;
            }
         }
      }
      
      private function buttonEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(disposed)
         {
            return;
         }
         if(!_window || false)
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "whisper":
                     _loc4_ = "null";
                     break;
                  case "friend":
                     param2.disable();
                     this._data.canBeAskedAsFriend = false;
                     _loc4_ = "null";
                     break;
                  case "respect":
                     --this._data.respectLeft;
                     _loc5_ = this._data.respectLeft;
                     _widget.localizations.registerParameter("infostand.button.respect","count",_loc5_.toString());
                     this.showButton("respect",this._data.respectLeft > 0);
                     _loc4_ = "null";
                     if(_loc5_ > 0)
                     {
                        _loc3_ = false;
                     }
                     break;
                  case "ignore":
                     param2.parent.visible = false;
                     _window.findChildByName("unignore").visible = true;
                     this._data.isIgnored = true;
                     _loc4_ = "null";
                     break;
                  case "unignore":
                     param2.parent.visible = false;
                     _window.findChildByName("ignore").visible = true;
                     this._data.isIgnored = false;
                     _loc4_ = "null";
                     break;
                  case "kick":
                     _loc4_ = "null";
                     break;
                  case "ban":
                     _loc4_ = "null";
                     break;
                  case "give_rights":
                     param2.parent.visible = false;
                     _window.findChildByName("remove_rights").visible = true;
                     this._data.hasFlatControl = true;
                     _loc4_ = "null";
                     break;
                  case "remove_rights":
                     param2.parent.visible = false;
                     _window.findChildByName("give_rights").visible = true;
                     this._data.hasFlatControl = false;
                     _loc4_ = "null";
                     break;
                  case "trade":
                     _loc4_ = "null";
                     break;
                  case "report":
                     _loc4_ = "null";
                     break;
                  case "moderate":
                     this.var_701 = const_1042;
                     this.var_1729 = true;
                     _loc3_ = false;
                     break;
                  case "actions":
                     this.var_701 = const_1043;
                     this.var_1729 = true;
                     _loc3_ = false;
               }
            }
            if(_loc4_ != null)
            {
               _loc6_ = new RoomWidgetUserActionMessage(_loc4_,_userId);
               _widget.messageListener.processWidgetMessage(_loc6_);
               HabboTracking.getInstance().trackEventLog("InfoStand","click",_loc4_);
            }
            this.updateButtons();
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            if(param2.name == "button")
            {
               param2.color = param2.tags.indexOf("moderate") > -1 ? uint(const_2096) : uint(const_1044);
            }
            else if(param2.tags.indexOf("link") > -1)
            {
               if(param2.tags.indexOf("actions") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = const_1450;
               }
               else if(param2.tags.indexOf("moderate") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = const_1572;
               }
            }
         }
         else if(param1.type == WindowMouseEvent.const_25)
         {
            if(param2.name == "button")
            {
               param2.color = const_1449;
            }
            else if(param2.tags.indexOf("link") > -1)
            {
               if(param2.tags.indexOf("actions") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = const_1448;
               }
               else if(param2.tags.indexOf("moderate") > -1)
               {
                  ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = const_1571;
               }
            }
         }
         if(_loc3_)
         {
            _widget.removeView(this,false);
         }
      }
   }
}
