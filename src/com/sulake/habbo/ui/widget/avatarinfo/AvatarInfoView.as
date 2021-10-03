package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.room.object.RoomObjectTypeEnum;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.utils.FixedSizeStack;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class AvatarInfoView implements IDisposable
   {
      
      protected static const const_1449:uint = 4281149991;
      
      protected static const const_1044:uint = 4282950861;
      
      protected static const const_2096:uint = 4288230144;
      
      protected static const const_1448:uint = 16777215;
      
      protected static const const_1450:uint = 9552639;
      
      protected static const const_2095:uint = 16777215;
      
      protected static const const_2099:uint = 5789011;
      
      protected static const const_2097:uint = 13947341;
      
      protected static const const_2098:uint = 5789011;
      
      private static const const_1682:int = 25;
      
      private static const const_1140:int = 3;
      
      protected static var var_1174:Boolean = false;
       
      
      protected var _window:IWindowContainer;
      
      protected var var_434:IWindowContainer;
      
      protected var var_191:IWindowContainer;
      
      private var var_2078:Boolean;
      
      protected var _widget:AvatarInfoWidget;
      
      protected var _userId:int;
      
      protected var _userName:String;
      
      protected var var_1736:int;
      
      protected var var_2293:Boolean;
      
      protected var var_2596:int;
      
      protected var var_2123:Boolean;
      
      protected var var_2292:FixedSizeStack;
      
      protected var var_2294:int = -1000000;
      
      protected var _disposed:Boolean;
      
      protected var var_521:Timer;
      
      protected var var_3092:int = 3000;
      
      protected var var_1735:Boolean;
      
      protected var var_1734:Boolean;
      
      protected var var_799:Number;
      
      protected var var_1737:int;
      
      protected var var_3091:int = 500;
      
      protected var var_1169:Boolean;
      
      public function AvatarInfoView(param1:AvatarInfoWidget)
      {
         this.var_2292 = new FixedSizeStack(const_1682);
         super();
         this._widget = param1;
         this.var_1169 = true;
         this.var_1735 = false;
         this.var_1734 = false;
      }
      
      public static function setup(param1:AvatarInfoView, param2:int, param3:String, param4:int, param5:int, param6:Boolean = false) : void
      {
         param1._userId = param2;
         param1._userName = param3;
         param1.var_1736 = param5;
         param1.var_2596 = param4;
         param1.var_2293 = param6;
         param1.var_1735 = false;
         param1.var_3091 = 500;
         param1.var_1734 = false;
         param1.var_799 = 1;
         if(param1.var_1169)
         {
            if(!param1.var_521)
            {
               param1.var_521 = new Timer(param1.var_3092,1);
               param1.var_521.addEventListener(TimerEvent.TIMER_COMPLETE,param1.onTimerComplete);
            }
            param1.var_521.reset();
            param1.var_521.start();
         }
         param1.updateWindow();
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function get userType() : int
      {
         return this.var_1736;
      }
      
      public function get roomIndex() : int
      {
         return this.var_2596;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function get allowNameChange() : Boolean
      {
         return this.var_2293;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         this._widget = null;
         this.var_191 = null;
         if(this._window)
         {
            this._window.dispose();
            this._window = null;
         }
         if(this.var_434)
         {
            this.var_434.dispose();
            this.var_434 = null;
         }
         if(this.var_521)
         {
            this.var_521.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
            this.var_521.reset();
            this.var_521 = null;
         }
         this._disposed = true;
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         this.var_1734 = true;
         this.var_1737 = 0;
         this.hide(true);
      }
      
      protected function addMouseClickListener(param1:IWindow, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,param2);
         }
      }
      
      protected function updateWindow() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!this._widget || !this._widget.assets || !this._widget.windowManager)
         {
            return;
         }
         if(!this._window)
         {
            _loc2_ = this._widget.assets.getAssetByName("avatar_info_widget").content as XML;
            this._window = this._widget.windowManager.buildFromXML(_loc2_,0) as IWindowContainer;
            if(!this._window)
            {
               return;
            }
         }
         var _loc1_:IWindow = this._window.findChildByName("name");
         _loc1_.caption = this._userName;
         if(!this.var_2293)
         {
            this._window.findChildByName("change_name_container").visible = false;
            this._window.height = 39;
            this._window.width = 32 + _loc1_.width;
         }
         else
         {
            _loc3_ = this._window.findChildByName("change_name_container");
            _loc3_.visible = true;
            this._window.height = 39 + _loc3_.height;
            this.addMouseClickListener(this._window.findChildByName("change_name_container"),this.clickHandler);
         }
         this.activeView = this._window;
      }
      
      protected function clickHandler(param1:WindowMouseEvent) : void
      {
         this._widget.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.const_589));
         this._widget.removeView(this,false);
      }
      
      public function setImageAsset(param1:IBitmapWrapperWindow, param2:String) : void
      {
         if(!param1 || !this._widget || !this._widget.assets)
         {
            return;
         }
         var _loc3_:BitmapDataAsset = this._widget.assets.getAssetByName(param2) as BitmapDataAsset;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:BitmapData = _loc3_.content as BitmapData;
         if(!_loc4_)
         {
            return;
         }
         if(param1.bitmap)
         {
            param1.bitmap.fillRect(param1.bitmap.rect,0);
         }
         else
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
         param1.bitmap.draw(_loc4_);
      }
      
      public function show() : void
      {
         if(this.var_191 != null)
         {
            this._widget.windowManager.getDesktop(0).addChild(this.var_191);
            this.var_191.visible = true;
            this.var_191.activate();
         }
      }
      
      public function hide(param1:Boolean) : void
      {
         if(this.var_191 != null)
         {
            if(!this.var_1735 && param1)
            {
               this.var_1735 = true;
               this.var_521.start();
            }
            else
            {
               this.var_191.visible = false;
               this.var_191.parent = null;
            }
         }
      }
      
      public function update(param1:Rectangle, param2:Point, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!param1)
         {
            return;
         }
         if(!this.var_191)
         {
            this.updateWindow();
         }
         if(this.var_1734)
         {
            this.var_1737 += param3;
            this.var_799 = 1 - this.var_1737 / Number(this.var_3091);
         }
         else
         {
            this.var_799 = 1;
         }
         if(this.var_799 <= 0)
         {
            this._widget.removeView(this,false);
            return;
         }
         if(!this.var_2123 || this.var_2078)
         {
            _loc4_ = -this.var_191.height;
            if(this.var_1736 == RoomObjectTypeEnum.const_137 || this.var_1736 == RoomObjectTypeEnum.const_571)
            {
               _loc4_ += param1.height > 50 ? 25 : 0;
            }
            else
            {
               _loc4_ -= 4;
            }
            _loc5_ = param2.y - param1.top;
            this.var_2292.addValue(_loc5_);
            _loc6_ = this.var_2292.getMax();
            if(_loc6_ < this.var_2294 - const_1140)
            {
               _loc6_ = this.var_2294 - const_1140;
            }
            _loc7_ = param2.y - _loc6_;
            this.var_2294 = _loc6_;
            this.var_191.x = param2.x - this.var_191.width / 2;
            this.var_191.y = _loc7_ + _loc4_;
            this.var_2078 = false;
         }
         this.var_191.blend = this.var_799;
         this.show();
      }
      
      protected function onMouseHoverEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            this.var_2123 = true;
         }
         else if(param1.type == WindowMouseEvent.const_25)
         {
            if(!param1.window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
            {
               this.var_2123 = false;
            }
         }
      }
      
      protected function setMinimized(param1:Boolean) : void
      {
         var_1174 = param1;
         this.var_2078 = true;
         this.updateWindow();
      }
      
      protected function getMinimizedView() : IWindowContainer
      {
         var _loc1_:* = null;
         if(!this.var_434)
         {
            _loc1_ = XmlAsset(this._widget.assets.getAssetByName("minimized_menu")).content as XML;
            this.var_434 = this._widget.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
            this.var_434.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMaximize);
            this.var_434.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onMinimizeHover);
            this.var_434.findChildByName("minimize").addEventListener(WindowMouseEvent.const_25,this.onMinimizeHover);
            this.var_434.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER,this.onMouseHoverEvent);
            this.var_434.addEventListener(WindowMouseEvent.const_25,this.onMouseHoverEvent);
         }
         return this.var_434;
      }
      
      private function onMaximize(param1:WindowMouseEvent) : void
      {
         this.setMinimized(false);
      }
      
      protected function set activeView(param1:IWindowContainer) : void
      {
         if(!param1)
         {
            return;
         }
         if(this.var_191)
         {
            this.var_191.parent = null;
         }
         this.var_191 = param1;
      }
      
      protected function onMinimize(param1:WindowMouseEvent) : void
      {
         this.setMinimized(true);
      }
      
      protected function onMinimizeHover(param1:WindowMouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:IWindowContainer = param1.window as IWindowContainer;
         if(_loc2_)
         {
            _loc3_ = _loc2_.findChildByName("icon");
            if(_loc3_)
            {
               if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
               {
                  _loc3_.color = const_1044;
               }
               else
               {
                  _loc3_.color = 16777215;
               }
            }
         }
      }
   }
}
