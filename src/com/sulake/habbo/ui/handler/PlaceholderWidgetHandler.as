package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class PlaceholderWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function PlaceholderWidgetHandler()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._container = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         this._container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetFurniToWidgetMessage.const_1327];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = param1.type;
         switch(0)
         {
         }
         _loc2_ = new RoomWidgetShowPlaceholderEvent(RoomWidgetShowPlaceholderEvent.const_809);
         this._container.events.dispatchEvent(_loc2_);
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}
