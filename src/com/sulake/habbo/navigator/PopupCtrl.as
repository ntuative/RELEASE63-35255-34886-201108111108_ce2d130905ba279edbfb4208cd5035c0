package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class PopupCtrl
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_1163:String;
      
      private var var_2483:int;
      
      private var _popupIndentLeft:int;
      
      private var var_482:Timer;
      
      private var var_405:Timer;
      
      private var var_60:IWindowContainer;
      
      public function PopupCtrl(param1:HabboNavigator, param2:int, param3:int, param4:String)
      {
         this.var_482 = new Timer(500,1);
         this.var_405 = new Timer(100,1);
         super();
         this._navigator = param1;
         this.var_1163 = param4;
         this.var_2483 = param2;
         this._popupIndentLeft = param3;
         this.var_482.addEventListener(TimerEvent.TIMER,this.onDisplayTimer);
         this.var_405.addEventListener(TimerEvent.TIMER,this.onHideTimer);
      }
      
      public function get navigator() : HabboNavigator
      {
         return this._navigator;
      }
      
      public function dispose() : void
      {
         this._navigator = null;
         if(this.var_482)
         {
            this.var_482.removeEventListener(TimerEvent.TIMER,this.onDisplayTimer);
            this.var_482.reset();
            this.var_482 = null;
         }
         if(this.var_405)
         {
            this.var_405.removeEventListener(TimerEvent.TIMER,this.onHideTimer);
            this.var_405.reset();
            this.var_405 = null;
         }
      }
      
      public function showPopup(param1:IWindow) : void
      {
         if(this.var_60 == null)
         {
            this.var_60 = IWindowContainer(this._navigator.getXmlWindow(this.var_1163));
            this.var_60.visible = false;
            this.var_60.setParamFlag(HabboWindowParam.const_46,true);
            this.var_60.procedure = this.onPopup;
         }
         Util.hideChildren(this.var_60);
         this.refreshContent(this.var_60);
         this.var_60.height = Util.getLowestPoint(this.var_60) + 5;
         var _loc2_:Point = new Point();
         param1.getGlobalPosition(_loc2_);
         this.var_60.x = _loc2_.x + this.var_2483 + param1.width;
         this.var_60.y = _loc2_.y - this.var_60.height * 0.5 + param1.height * 0.5;
         var _loc3_:Point = new Point();
         this.var_60.getGlobalPosition(_loc3_);
         if(_loc3_.x + this.var_60.width > this.var_60.desktop.width)
         {
            this.var_60.x = -this.var_60.width + _loc2_.x + this._popupIndentLeft;
            this.refreshPopupArrows(this.var_60,false);
         }
         else
         {
            this.refreshPopupArrows(this.var_60,true);
         }
         if(!this.var_60.visible)
         {
            this.var_482.reset();
            this.var_482.start();
         }
         this.var_405.reset();
         this.var_60.activate();
      }
      
      public function closePopup() : void
      {
         this.var_405.reset();
         this.var_482.reset();
         this.var_405.start();
      }
      
      private function refreshPopupArrows(param1:IWindowContainer, param2:Boolean) : void
      {
         this.refreshPopupArrow(param1,true,param2);
         this.refreshPopupArrow(param1,false,!param2);
      }
      
      private function refreshPopupArrow(param1:IWindowContainer, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:String = "popup_arrow_" + (!!param2 ? "left" : "right");
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName(_loc4_));
         if(!param3)
         {
            if(_loc5_ != null)
            {
               _loc5_.visible = false;
            }
         }
         else
         {
            if(_loc5_ == null)
            {
               _loc5_ = this._navigator.getButton(_loc4_,_loc4_,null);
               _loc5_.setParamFlag(HabboWindowParam.const_64,false);
               param1.addChild(_loc5_);
            }
            _loc5_.visible = true;
            _loc5_.y = param1.height * 0.5 - _loc5_.height * 0.5;
            _loc5_.x = !!param2 ? int(1 - _loc5_.width) : int(param1.width - 1);
         }
      }
      
      private function onDisplayTimer(param1:TimerEvent) : void
      {
         this.var_60.visible = true;
         this.var_60.activate();
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         if(this.var_60 != null)
         {
            this.var_60.visible = false;
         }
      }
      
      public function hideInstantly() : void
      {
         if(this.var_60 != null)
         {
            this.var_60.visible = false;
         }
         this.var_482.reset();
         this.var_405.reset();
      }
      
      public function get visible() : Boolean
      {
         return this.var_60 != null && this.var_60.visible;
      }
      
      public function refreshContent(param1:IWindowContainer) : void
      {
      }
      
      private function onPopup(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1 as WindowMouseEvent == null)
         {
            return;
         }
         if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
         {
            this.var_405.reset();
         }
         else if(param1.type == WindowMouseEvent.const_25)
         {
            if(!Util.containsMouse(this.var_60))
            {
               this.closePopup();
            }
         }
      }
   }
}
