package com.sulake.habbo.ui.widget
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   
   public interface IRoomWidgetMessageListener
   {
       
      
      function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent;
   }
}
