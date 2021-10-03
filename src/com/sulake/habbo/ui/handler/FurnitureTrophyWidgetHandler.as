package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.ui.widget.events.RoomWidgetTrophyDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureTrophyWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var var_1173:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FurnitureTrophyWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1173;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_627;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         this._container = param1;
      }
      
      public function dispose() : void
      {
         this.var_1173 = true;
         this._container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return [RoomWidgetFurniToWidgetMessage.const_914];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         if(this.disposed || param1 == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case RoomWidgetFurniToWidgetMessage.const_914:
               _loc2_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc3_ = this._container.roomEngine.getRoomObject(_loc2_.roomId,_loc2_.roomCategory,_loc2_.id,_loc2_.category);
               if(_loc3_ != null)
               {
                  _loc4_ = _loc3_.getModel();
                  if(_loc4_ != null)
                  {
                     _loc5_ = _loc4_.getNumber(RoomObjectVariableEnum.const_271);
                     _loc6_ = _loc4_.getString(RoomObjectVariableEnum.const_103);
                     _loc7_ = _loc6_.substring(0,_loc6_.indexOf("\t"));
                     _loc6_ = _loc6_.substring(_loc7_.length + 1,_loc6_.length);
                     _loc8_ = _loc6_.substring(0,_loc6_.indexOf("\t"));
                     _loc9_ = _loc6_.substring(_loc8_.length + 1,_loc6_.length);
                     _loc10_ = new RoomWidgetTrophyDataUpdateEvent(RoomWidgetTrophyDataUpdateEvent.const_781,_loc5_,_loc7_,_loc8_,_loc9_);
                     this._container.events.dispatchEvent(_loc10_);
                  }
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}
