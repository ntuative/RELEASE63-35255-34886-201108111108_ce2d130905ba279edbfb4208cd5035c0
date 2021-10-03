package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.session.events.RoomSessionPollEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPollUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   import flash.events.Event;
   
   public class PollWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function PollWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_455;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         this._container = param1;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetPollMessage.ANSWER,RoomWidgetPollMessage.const_583,RoomWidgetPollMessage.const_841];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetPollMessage = param1 as RoomWidgetPollMessage;
         if(_loc2_ == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case RoomWidgetPollMessage.const_841:
               this._container.roomSession.sendPollStartMessage(_loc2_.id);
               break;
            case RoomWidgetPollMessage.const_583:
               this._container.roomSession.sendPollRejectMessage(_loc2_.id);
               break;
            case RoomWidgetPollMessage.ANSWER:
               this._container.roomSession.sendPollAnswerMessage(_loc2_.id,_loc2_.questionId,_loc2_.answers);
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:* = [];
         _loc1_.push(RoomSessionPollEvent.const_166);
         _loc1_.push(RoomSessionPollEvent.const_69);
         _loc1_.push(RoomSessionPollEvent.const_179);
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:* = null;
         if(this._container == null || this._container.events == null)
         {
            return;
         }
         var _loc2_:RoomSessionPollEvent = param1 as RoomSessionPollEvent;
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomSessionPollEvent.const_166:
               _loc3_ = new RoomWidgetPollUpdateEvent(_loc2_.id,RoomWidgetPollUpdateEvent.const_166);
               _loc3_.summary = _loc2_.summary;
               break;
            case RoomSessionPollEvent.const_69:
               _loc3_ = new RoomWidgetPollUpdateEvent(_loc2_.id,RoomWidgetPollUpdateEvent.const_69);
               _loc3_.summary = _loc2_.summary;
               break;
            case RoomSessionPollEvent.const_179:
               _loc3_ = new RoomWidgetPollUpdateEvent(_loc2_.id,RoomWidgetPollUpdateEvent.const_179);
               _loc3_.startMessage = _loc2_.startMessage;
               _loc3_.endMessage = _loc2_.endMessage;
               _loc3_.numQuestions = _loc2_.numQuestions;
               _loc3_.questionArray = _loc2_.questionArray;
         }
         if(_loc3_ == null)
         {
            return;
         }
         this._container.events.dispatchEvent(_loc3_);
      }
      
      public function update() : void
      {
      }
   }
}
