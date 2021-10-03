package com.sulake.habbo.room.object.logic.room.publicroom
{
   import com.sulake.habbo.room.events.RoomObjectRoomActionEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.MouseEvent;
   
   public class PublicRoomParkLogic extends PublicRoomLogic
   {
      
      private static const const_1715:String = "goawaybus";
      
      private static const const_1713:String = "bus";
      
      private static const const_1714:String = "bus_oviopen_hidden";
       
      
      public function PublicRoomParkLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = [RoomObjectRoomActionEvent.const_584,RoomObjectRoomActionEvent.const_642];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         super.mouseEvent(param1,param2);
         var _loc3_:RoomSpriteMouseEvent = param1;
         if(_loc3_ == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc4_:int = object.getId();
         var _loc5_:String = object.getType();
         var _loc6_:* = null;
         switch(_loc3_.type)
         {
            case MouseEvent.CLICK:
               switch(_loc3_.spriteTag)
               {
                  case const_1715:
                     _loc6_ = new RoomObjectRoomActionEvent(RoomObjectRoomActionEvent.const_584,0,_loc4_,_loc5_);
                     break;
                  case const_1713:
                  case const_1714:
                     _loc6_ = new RoomObjectRoomActionEvent(RoomObjectRoomActionEvent.const_642,0,_loc4_,_loc5_);
               }
         }
         if(eventDispatcher != null)
         {
            if(_loc6_ != null)
            {
               eventDispatcher.dispatchEvent(_loc6_);
            }
         }
      }
   }
}
