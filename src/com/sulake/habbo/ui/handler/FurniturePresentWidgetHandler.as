package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.catalog.enum.ProductTypeEnum;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.session.events.RoomSessionPresentEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class FurniturePresentWidgetHandler implements IRoomWidgetHandler, IGetImageListener
   {
      
      private static const const_108:String = "floor";
      
      private static const const_246:String = "wallpaper";
      
      private static const TYPE_LANDSCAPE:String = "landscape";
      
      private static const const_1663:String = "poster";
       
      
      private var var_1173:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_236:int = -1;
      
      private var _name:String = "";
      
      public function FurniturePresentWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1173;
      }
      
      public function get type() : String
      {
         return RoomWidgetEnum.const_608;
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
         return [RoomWidgetFurniToWidgetMessage.const_908,RoomWidgetPresentOpenMessage.const_196];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:Boolean = false;
         var _loc11_:* = null;
         switch(param1.type)
         {
            case RoomWidgetFurniToWidgetMessage.const_908:
               _loc2_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc3_ = this._container.roomEngine.getRoomObject(_loc2_.roomId,_loc2_.roomCategory,_loc2_.id,_loc2_.category);
               if(_loc3_ != null)
               {
                  _loc5_ = _loc3_.getModel();
                  if(_loc5_ != null)
                  {
                     this.var_236 = _loc2_.id;
                     _loc6_ = _loc5_.getString(RoomObjectVariableEnum.const_103);
                     if(_loc6_ == null)
                     {
                        _loc6_ = "";
                     }
                     _loc6_ = _loc6_.substr(1);
                     _loc7_ = _loc5_.getNumber(RoomObjectVariableEnum.const_306);
                     _loc8_ = _loc5_.getString(RoomObjectVariableEnum.const_371);
                     _loc9_ = this._container.roomEngine.getFurnitureImage(_loc7_,new Vector3d(180),64,null,0,_loc8_);
                     _loc10_ = this._container.roomSession.isRoomOwner || this._container.sessionDataManager.isAnyRoomController;
                     _loc11_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.const_72,_loc2_.id,_loc6_,_loc10_,_loc9_.data);
                     this._container.events.dispatchEvent(_loc11_);
                  }
               }
               break;
            case RoomWidgetPresentOpenMessage.const_196:
               _loc4_ = param1 as RoomWidgetPresentOpenMessage;
               if(_loc4_.objectId != this.var_236)
               {
                  return null;
               }
               if(this._container != null && this._container.roomSession != null)
               {
                  this._container.roomSession.sendPresentOpenMessage(_loc4_.objectId);
               }
               break;
         }
         return null;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(this.disposed || this._container == null)
         {
            return;
         }
         var _loc3_:RoomWidgetPresentDataUpdateEvent = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.const_99,0,this._name,false,param2);
         this._container.events.dispatchEvent(_loc3_);
      }
      
      public function getProcessedEvents() : Array
      {
         return [RoomSessionPresentEvent.const_356];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(param1 == null)
         {
            return;
         }
         if(this._container != null && this._container.events != null && param1 != null)
         {
            switch(param1.type)
            {
               case RoomSessionPresentEvent.const_356:
                  _loc2_ = param1 as RoomSessionPresentEvent;
                  if(_loc2_ != null)
                  {
                     this._name = "";
                     _loc4_ = null;
                     if(_loc2_.itemType == ProductTypeEnum.const_71)
                     {
                        _loc3_ = this._container.sessionDataManager.getFloorItemData(_loc2_.classId);
                     }
                     else if(_loc2_.itemType == ProductTypeEnum.const_65)
                     {
                        _loc3_ = this._container.sessionDataManager.getWallItemData(_loc2_.classId);
                     }
                     switch(_loc2_.itemType)
                     {
                        case ProductTypeEnum.const_65:
                           if(_loc3_ != null && _loc3_.name == const_108)
                           {
                              _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.const_659,0,this._container.localization.getKey("inventory.furni.item.floor.name"),false,null);
                           }
                           else if(_loc3_ != null && _loc3_.name == TYPE_LANDSCAPE)
                           {
                              _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.const_572,0,this._container.localization.getKey("inventory.furni.item.landscape.name"),false,null);
                           }
                           else if(_loc3_ != null && _loc3_.name == const_246)
                           {
                              _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.const_672,0,this._container.localization.getKey("inventory.furni.item.wallpaper.name"),false,null);
                           }
                           else
                           {
                              if(_loc3_ != null && _loc3_.name == const_1663)
                              {
                                 break;
                              }
                              _loc4_ = this._container.roomEngine.getWallItemIcon(_loc2_.classId,this);
                              if(_loc3_ != null)
                              {
                                 this._name = _loc3_.title;
                              }
                              if(_loc4_ != null)
                              {
                                 _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.const_99,0,this._name,false,_loc4_.data);
                              }
                           }
                           break;
                        case ProductTypeEnum.const_385:
                           _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.const_496,0,this._container.localization.getKey("widget.furni.present.hc"),false,null);
                           break;
                        default:
                           _loc4_ = this._container.roomEngine.getFurnitureImage(_loc2_.classId,new Vector3d(180),32,this);
                           _loc6_ = this._container.sessionDataManager.getProductData(_loc2_.productCode);
                           if(_loc6_ != null)
                           {
                              this._name = _loc6_.name;
                           }
                           else if(_loc3_ != null)
                           {
                              this._name = _loc3_.title;
                           }
                           if(_loc4_ != null)
                           {
                              _loc5_ = new RoomWidgetPresentDataUpdateEvent(RoomWidgetPresentDataUpdateEvent.const_99,0,this._name,false,_loc4_.data);
                           }
                     }
                     if(_loc5_ != null)
                     {
                        this._container.events.dispatchEvent(_loc5_);
                        break;
                     }
                     break;
                  }
            }
         }
      }
      
      public function update() : void
      {
      }
   }
}
