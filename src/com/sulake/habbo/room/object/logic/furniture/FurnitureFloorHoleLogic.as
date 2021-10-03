package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFloorHoleEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class FurnitureFloorHoleLogic extends FurnitureMultiStateLogic
   {
      
      private static const const_489:int = 0;
       
      
      private var var_1375:int = -1;
      
      private var var_193:Vector3d = null;
      
      public function FurnitureFloorHoleLogic()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(this.var_1375 == const_489)
         {
            eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.const_145,object.getId(),object.getType()));
         }
         super.dispose();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = [RoomObjectFloorHoleEvent.const_180,RoomObjectFloorHoleEvent.const_145];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         super.processUpdateMessage(param1);
         if(object != null)
         {
            _loc2_ = param1 as RoomObjectDataUpdateMessage;
            if(_loc2_ != null)
            {
               _loc4_ = object.getState(0);
               if(_loc4_ != this.var_1375)
               {
                  if(eventDispatcher != null)
                  {
                     if(_loc4_ == const_489)
                     {
                        eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.const_180,object.getId(),object.getType()));
                     }
                     else if(this.var_1375 == const_489)
                     {
                        eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.const_145,object.getId(),object.getType()));
                     }
                  }
                  this.var_1375 = _loc4_;
               }
            }
            _loc3_ = object.getLocation();
            if(this.var_193 == null)
            {
               this.var_193 = new Vector3d();
            }
            else if(_loc3_.x != this.var_193.x || _loc3_.y != this.var_193.y)
            {
               if(this.var_1375 == const_489)
               {
                  if(eventDispatcher != null)
                  {
                     eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.const_180,object.getId(),object.getType()));
                  }
               }
            }
            this.var_193.assign(_loc3_);
         }
      }
   }
}
