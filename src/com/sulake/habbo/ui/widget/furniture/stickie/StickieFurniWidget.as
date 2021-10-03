package com.sulake.habbo.ui.widget.furniture.stickie
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class StickieFurniWidget extends RoomWidgetBase
   {
      
      private static const const_1684:int = 14;
      
      private static const const_1683:int = 500;
      
      private static const const_1472:Number = 100;
      
      private static const const_1471:Number = 100;
       
      
      private var _window:IWindowContainer;
      
      protected var var_236:int = -1;
      
      protected var var_1445:String;
      
      protected var _text:String;
      
      protected var var_362:String;
      
      protected var var_26:Boolean;
      
      protected var var_2295:String = "stickieui_container";
      
      public function StickieFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
      
      protected function get window() : IWindowContainer
      {
         return this._window;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         this.hideInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetStickieDataUpdateEvent.const_800,this.onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetStickieDataUpdateEvent.const_800,this.onObjectUpdate);
      }
      
      protected function onObjectUpdate(param1:RoomWidgetStickieDataUpdateEvent) : void
      {
         this.hideInterface(false);
         this.var_236 = param1.objectId;
         this.var_1445 = param1.objectType;
         this._text = param1.text;
         this.var_362 = param1.colorHex;
         this.var_26 = param1.controller;
         this.showInterface();
      }
      
      protected function showInterface() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(this.var_236 == -1)
         {
            return;
         }
         var _loc1_:IAsset = assets.getAssetByName("stickie");
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:XmlAsset = XmlAsset(_loc1_);
         if(_loc2_ == null)
         {
            return;
         }
         if(this._window == null)
         {
            this._window = windowManager.createWindow(this.var_2295,"",HabboWindowType.const_73,HabboWindowStyle.const_30,0 | 0,new Rectangle(const_1472,const_1471,2,2),null,0) as IWindowContainer;
            this._window.buildFromXML(XML(_loc2_.content));
         }
         _loc3_ = this._window.findChildByName("text") as ITextFieldWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = this._text;
            _loc3_.addEventListener(WindowEvent.const_114,this.onTextWindowEvent);
         }
         _loc6_ = this._window.findChildByTag("bg") as IBitmapWrapperWindow;
         if(_loc6_ != null)
         {
            if(this.var_1445 == "post_it_vd")
            {
               _loc4_ = assets.getAssetByName("stickie_vd") as BitmapDataAsset;
            }
            else
            {
               _loc4_ = assets.getAssetByName("stickie_blanco") as BitmapDataAsset;
               _loc6_.color = uint("0xFF" + this.var_362);
            }
            _loc5_ = _loc4_.content as BitmapData;
            _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            _loc6_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
         }
         _loc6_ = this._window.findChildByTag("close_button") as IBitmapWrapperWindow;
         if(_loc6_ != null)
         {
            _loc4_ = assets.getAssetByName("stickie_close") as BitmapDataAsset;
            _loc5_ = _loc4_.content as BitmapData;
            _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            _loc6_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
            _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseEvent);
         }
         _loc6_ = this._window.findChildByTag("delete_button") as IBitmapWrapperWindow;
         if(_loc6_ != null && this.var_26)
         {
            _loc4_ = assets.getAssetByName("stickie_remove") as BitmapDataAsset;
            _loc5_ = _loc4_.content as BitmapData;
            _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            _loc6_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
            _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseEvent);
         }
         this.setColorButtons(this.var_26 && this.var_1445 == "post_it");
      }
      
      protected function hideInterface(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.sendUpdate();
         }
         if(this._window != null)
         {
            this._window.dispose();
            this._window = null;
         }
         this.var_236 = -1;
         this._text = null;
         this.var_26 = false;
      }
      
      private function setColorButtons(param1:Boolean) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = new Array("blue","purple","green","yellow");
         var _loc4_:int = 0;
         while(_loc4_ <= _loc3_.length)
         {
            _loc2_ = this._window.findChildByName(_loc3_[_loc4_]);
            if(_loc2_ != null)
            {
               if(param1)
               {
                  _loc2_.visible = true;
                  _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseEvent);
               }
               else
               {
                  _loc2_.visible = false;
               }
            }
            _loc4_++;
         }
      }
      
      protected function storeTextFromField() : Boolean
      {
         var _loc1_:ITextFieldWindow = this._window.findChildByName("text") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return false;
         }
         if(this._text == _loc1_.text)
         {
            return false;
         }
         this._text = _loc1_.text;
         return true;
      }
      
      protected function sendUpdate() : void
      {
         var _loc1_:* = null;
         if(this.var_236 == -1)
         {
            return;
         }
         if(!this.storeTextFromField())
         {
            return;
         }
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetStickieSendUpdateMessage(RoomWidgetStickieSendUpdateMessage.const_520,this.var_236,this._text,this.var_362);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      protected function sendSetColor(param1:uint) : void
      {
         var _loc3_:* = null;
         if(this.var_236 == -1)
         {
            return;
         }
         this.storeTextFromField();
         var _loc2_:String = param1.toString(16).toUpperCase();
         if(_loc2_.length > 6)
         {
            _loc2_ = _loc2_.slice(_loc2_.length - 6,_loc2_.length);
         }
         if(_loc2_ == this.var_362)
         {
            return;
         }
         this.var_362 = _loc2_;
         if(messageListener != null)
         {
            _loc3_ = new RoomWidgetStickieSendUpdateMessage(RoomWidgetStickieSendUpdateMessage.const_520,this.var_236,this._text,this.var_362);
            messageListener.processWidgetMessage(_loc3_);
         }
         this.showInterface();
      }
      
      protected function sendDelete() : void
      {
         var _loc1_:* = null;
         if(this.var_236 == -1)
         {
            return;
         }
         if(messageListener != null && this.var_26)
         {
            _loc1_ = new RoomWidgetStickieSendUpdateMessage(RoomWidgetStickieSendUpdateMessage.const_1032,this.var_236);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      private function onTextWindowEvent(param1:WindowEvent) : void
      {
         var _loc2_:* = null;
         _loc2_ = this._window.findChildByName("text") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.maxChars = const_1683;
         if(_loc2_.numLines < const_1684)
         {
            return;
         }
         _loc2_.text = _loc2_.text.slice(0,_loc2_.text.length - 1);
         _loc2_.maxChars = _loc2_.length;
      }
      
      protected function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "blue":
            case "purple":
            case "green":
            case "yellow":
               this.sendSetColor(_loc2_.color);
               break;
            case "close":
               this.hideInterface();
               break;
            case "delete":
               this.sendDelete();
               this.hideInterface(false);
         }
      }
   }
}
