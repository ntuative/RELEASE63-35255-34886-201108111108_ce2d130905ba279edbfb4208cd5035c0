package com.sulake.habbo.ui.widget.furniture.present
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class PresentFurniWidget extends RoomWidgetBase
   {
       
      
      private var _window:IWindowContainer;
      
      private var var_236:int = -1;
      
      private var _text:String;
      
      private var var_26:Boolean;
      
      private var var_391:Boolean = false;
      
      public function PresentFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         this.hideInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener(RoomWidgetPresentDataUpdateEvent.const_72,this.onObjectUpdate);
         param1.addEventListener(RoomWidgetPresentDataUpdateEvent.const_99,this.onObjectUpdate);
         param1.addEventListener(RoomWidgetPresentDataUpdateEvent.const_496,this.onObjectUpdate);
         param1.addEventListener(RoomWidgetPresentDataUpdateEvent.const_659,this.onObjectUpdate);
         param1.addEventListener(RoomWidgetPresentDataUpdateEvent.const_572,this.onObjectUpdate);
         param1.addEventListener(RoomWidgetPresentDataUpdateEvent.const_672,this.onObjectUpdate);
         param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.const_158,this.onRoomObjectRemoved);
         param1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.const_72,this.onEcotronUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.const_72,this.onObjectUpdate);
         param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.const_99,this.onObjectUpdate);
         param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.const_496,this.onObjectUpdate);
         param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.const_659,this.onObjectUpdate);
         param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.const_572,this.onObjectUpdate);
         param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.const_672,this.onObjectUpdate);
         param1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.const_72,this.onEcotronUpdate);
         param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.const_158,this.onRoomObjectRemoved);
      }
      
      private function onObjectUpdate(param1:RoomWidgetPresentDataUpdateEvent) : void
      {
         switch(param1.type)
         {
            case RoomWidgetPresentDataUpdateEvent.const_72:
               this.hideInterface();
               this.var_391 = false;
               this.var_236 = param1.objectId;
               this._text = param1.text;
               this.var_26 = param1.controller;
               this.showInterface();
               this.showIcon(param1.iconBitmapData);
               break;
            case RoomWidgetPresentDataUpdateEvent.const_659:
               if(!this.var_391)
               {
                  return;
               }
               this.var_236 = param1.objectId;
               this._text = param1.text;
               this.showInterface();
               this.showCustomIcon("packagecard_icon_floor");
               break;
            case RoomWidgetPresentDataUpdateEvent.const_572:
               if(!this.var_391)
               {
                  return;
               }
               this.var_236 = param1.objectId;
               this._text = param1.text;
               this.showInterface();
               this.showCustomIcon("packagecard_icon_landscape");
               break;
            case RoomWidgetPresentDataUpdateEvent.const_672:
               if(!this.var_391)
               {
                  return;
               }
               this.var_236 = param1.objectId;
               this._text = param1.text;
               this.showInterface();
               this.showCustomIcon("packagecard_icon_wallpaper");
               break;
            case RoomWidgetPresentDataUpdateEvent.const_496:
               if(!this.var_391)
               {
                  return;
               }
               this.var_236 = param1.objectId;
               this._text = param1.text;
               this.showInterface();
               this.showCustomIcon("packagecard_icon_hc");
               break;
            case RoomWidgetPresentDataUpdateEvent.const_99:
               if(!this.var_391)
               {
                  return;
               }
               this.var_236 = param1.objectId;
               this._text = param1.text;
               this.showGiftOpenedInterface();
               this.showIcon(param1.iconBitmapData);
               break;
         }
      }
      
      private function showGiftOpenedInterface() : void
      {
         this.showInterface();
         if(this._window)
         {
            this._window.findChildByName("title").caption = this._text;
            this._window.findChildByName("text").caption = "${widget.furni.present.instructions}";
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(param1.id == this.var_236)
         {
            this.hideInterface();
         }
      }
      
      private function onEcotronUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent) : void
      {
         switch(param1.type)
         {
            case RoomWidgetEcotronBoxDataUpdateEvent.const_72:
               this.hideInterface();
         }
      }
      
      private function showCustomIcon(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:BitmapDataAsset = assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.content as BitmapData;
         }
         this.showIcon(_loc3_);
      }
      
      private function showIcon(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         if(this._window == null)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = this._window.findChildByName("gift_image") as IBitmapWrapperWindow;
         if(_loc2_.bitmap != null)
         {
            _loc2_.bitmap.dispose();
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_);
      }
      
      private function showInterface() : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(this.var_236 < 0)
         {
            return;
         }
         if(this._window != null)
         {
            this._window.dispose();
         }
         var _loc1_:XmlAsset = assets.getAssetByName("packagecard") as XmlAsset;
         this._window = windowManager.buildFromXML(_loc1_.content as XML) as IWindowContainer;
         this._window.center();
         var _loc2_:IBitmapWrapperWindow = this._window.findChildByName("image_bg") as IBitmapWrapperWindow;
         var _loc3_:BitmapDataAsset = assets.getAssetByName("yellow_highlight") as BitmapDataAsset;
         if(_loc2_ && _loc3_)
         {
            _loc5_ = _loc3_.content as BitmapData;
            if(_loc2_.bitmap)
            {
               _loc2_.bitmap.dispose();
            }
            _loc2_.bitmap = _loc5_.clone();
         }
         _loc4_ = this._window.findChildByName("text") as ITextWindow;
         if(_loc4_ != null && this._text != null)
         {
            _loc4_.caption = this._text;
         }
         if(!this.var_26)
         {
            this.hideOpenButton();
         }
         this._window.procedure = this.handleWindowEvent;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.var_391 = false;
         this.hideInterface();
      }
      
      private function hideInterface() : void
      {
         if(this._window != null)
         {
            this._window.dispose();
            this._window = null;
         }
         if(!this.var_391)
         {
            this.var_236 = -1;
         }
         this._text = "";
         this.var_26 = false;
      }
      
      private function sendOpen() : void
      {
         var _loc1_:* = null;
         if(this.var_391 || this.var_236 == -1 || !this.var_26)
         {
            return;
         }
         this.var_391 = true;
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetPresentOpenMessage(RoomWidgetPresentOpenMessage.const_196,this.var_236);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      private function hideOpenButton() : void
      {
         if(this._window == null)
         {
            return;
         }
         var _loc1_:IWindow = this._window.findChildByName("open");
         if(_loc1_ != null)
         {
            _loc1_.visible = false;
         }
      }
      
      private function handleWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         switch(param2.name)
         {
            case "open":
               this.sendOpen();
               break;
            case "close":
               this.var_391 = false;
               this.hideInterface();
               break;
            default:
               if(param2.tags.indexOf("close") != -1)
               {
                  this.hideInterface();
               }
         }
      }
   }
}
