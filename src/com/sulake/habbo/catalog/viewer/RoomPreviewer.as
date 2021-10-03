package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class RoomPreviewer
   {
      
      private static const const_50:int = -100;
      
      private static const const_51:int = 1;
      
      private static const const_247:int = 1;
      
      private static const const_66:int = 1;
      
      private static const const_724:int = 2;
      
      private static const const_723:int = 2;
      
      private static const const_487:Number = 0.25;
      
      private static const const_1719:int = 64;
      
      private static const const_1721:int = 32;
      
      private static const const_1720:int = 2500;
       
      
      private var _roomEngine:IRoomEngine;
      
      private var var_1358:int = 0;
      
      private var var_346:int = 0;
      
      private var var_1668:String = "";
      
      private var var_51:Rectangle = null;
      
      private var var_1356:int = 0;
      
      private var var_1115:int = 0;
      
      private var var_1359:int = 64;
      
      private var var_2115:Boolean;
      
      private var var_1357:Boolean;
      
      private var var_1360:int;
      
      public function RoomPreviewer(param1:IRoomEngine)
      {
         super();
         this._roomEngine = param1;
         if(this._roomEngine != null)
         {
            this._roomEngine.events.addEventListener(RoomEngineObjectEvent.const_200,this.onRoomObjectAdded);
            this._roomEngine.events.addEventListener(RoomEngineObjectEvent.const_946,this.onRoomObjectAdded);
            this._roomEngine.events.addEventListener(RoomEngineEvent.const_183,this.onRoomInitialized);
         }
         this.createRoomForPreviews();
      }
      
      public function dispose() : void
      {
         this.reset();
         if(this._roomEngine != null && this._roomEngine.events != null)
         {
            this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.const_200,this.onRoomObjectAdded);
            this._roomEngine.events.removeEventListener(RoomEngineObjectEvent.const_946,this.onRoomObjectAdded);
            this._roomEngine.events.removeEventListener(RoomEngineEvent.const_183,this.onRoomInitialized);
         }
      }
      
      private function createRoomForPreviews() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._roomEngine != null)
         {
            _loc1_ = 7;
            _loc2_ = new RoomPlaneParser();
            _loc2_.initializeTileMap(_loc1_ + 2,_loc1_ + 2);
            _loc3_ = 1;
            while(_loc3_ < 1 + _loc1_)
            {
               _loc4_ = 1;
               while(_loc4_ < 1 + _loc1_)
               {
                  _loc2_.setTileHeight(_loc4_,_loc3_,0);
                  _loc4_++;
               }
               _loc3_++;
            }
            _loc2_.initializeFromTileData();
            this._roomEngine.initializeRoom(const_51,const_50,_loc2_.getXML());
            _loc2_.dispose();
         }
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._roomEngine != null)
         {
            _loc1_ = this._roomEngine.activeRoomId;
            _loc2_ = this._roomEngine.activeRoomCategory;
            this._roomEngine.setActiveRoom(const_51,const_50);
            this._roomEngine.disposeObjectFurniture(const_51,const_50,const_66);
            this._roomEngine.disposeObjectWallItem(const_51,const_50,const_66);
            this._roomEngine.disposeObjectUser(const_51,const_50,const_66);
            this.updatePreviewRoomView();
            this._roomEngine.setActiveRoom(_loc1_,_loc2_);
         }
         this.var_346 = RoomObjectCategoryEnum.const_153;
      }
      
      public function addFurnitureIntoRoom(param1:int, param2:IVector3d) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = -1;
         if(this._roomEngine != null)
         {
            if(this.var_346 == RoomObjectCategoryEnum.const_27 && this.var_1358 == param1)
            {
               return const_66;
            }
            this.reset();
            this.var_1358 = param1;
            this.var_346 = RoomObjectCategoryEnum.const_27;
            this.var_1668 = "";
            _loc4_ = this._roomEngine.activeRoomId;
            _loc5_ = this._roomEngine.activeRoomCategory;
            this._roomEngine.setActiveRoom(const_51,const_50);
            if(this._roomEngine.addObjectFurniture(const_51,const_50,const_66,param1,new Vector3d(const_724,const_723,0),param2,0,""))
            {
               this.var_1360 = getTimer();
               this.var_1357 = true;
               _loc3_ = const_66;
               this.updatePreviewRoomView();
            }
            this._roomEngine.setActiveRoom(_loc4_,_loc5_);
         }
         return _loc3_;
      }
      
      public function addWallItemIntoRoom(param1:int, param2:IVector3d, param3:String) : int
      {
         if(this._roomEngine != null)
         {
            if(this.var_346 == RoomObjectCategoryEnum.const_26 && this.var_1358 == param1 && this.var_1668 == param3)
            {
               return const_66;
            }
            this.reset();
            this.var_1358 = param1;
            this.var_346 = RoomObjectCategoryEnum.const_26;
            this.var_1668 = param3;
            if(this._roomEngine.addObjectWallItem(const_51,const_50,const_66,param1,new Vector3d(0.5,2.3,1.8),param2,0,param3))
            {
               this.var_1360 = getTimer();
               this.var_1357 = true;
               return const_66;
            }
         }
         return -1;
      }
      
      public function addAvatarIntoRoom(param1:String, param2:int) : int
      {
         if(this._roomEngine != null)
         {
            this.reset();
            this.var_1358 = 1;
            this.var_346 = RoomObjectCategoryEnum.OBJECT_CATEGORY_USER;
            this.var_1668 = param1;
            if(this._roomEngine.addObjectUser(const_51,const_50,const_66,new Vector3d(const_724,const_723,0),new Vector3d(90,0,0),135,1,param1))
            {
               this.var_1360 = getTimer();
               this.var_1357 = true;
               this._roomEngine.updateObjectUserGesture(const_51,const_50,const_66,1);
               this._roomEngine.updateObjectUserEffect(const_51,const_50,const_66,param2);
               this._roomEngine.updateObjectUserPosture(const_51,const_50,const_66,"std");
            }
            return const_66;
         }
         return -1;
      }
      
      public function changeRoomObjectState() : void
      {
         if(this._roomEngine != null)
         {
            this.var_1357 = false;
            if(this.var_346 != RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)
            {
               this._roomEngine.changeObjectState(const_51,const_50,const_66,this.var_346);
            }
         }
      }
      
      private function checkAutomaticRoomObjectStateChange() : void
      {
         var _loc1_:int = 0;
         if(this.var_1357)
         {
            _loc1_ = getTimer();
            if(_loc1_ > this.var_1360 + const_1720)
            {
               this.var_1360 = _loc1_;
               if(this._roomEngine != null)
               {
                  this._roomEngine.changeObjectState(const_51,const_50,const_66,this.var_346);
               }
            }
         }
      }
      
      public function getRoomCanvas(param1:int, param2:int) : DisplayObject
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(this._roomEngine != null)
         {
            _loc3_ = this._roomEngine.createRoomCanvas(const_51,const_50,const_247,param1,param2,this.var_1359);
            this._roomEngine.setRoomCanvasMask(const_51,const_50,const_247,true);
            _loc4_ = this._roomEngine.getRoomCanvasGeometry(const_51,const_50,const_247);
            if(_loc4_ != null)
            {
               _loc4_.adjustLocation(new Vector3d(const_724,const_723,0),30);
            }
            this.var_1356 = param1;
            this.var_1115 = param2;
            return _loc3_;
         }
         return null;
      }
      
      private function updatePreviewObjectBoundingRectangle(param1:Point) : void
      {
         var _loc3_:* = null;
         var _loc2_:Rectangle = this._roomEngine.getRoomObjectBoundingRectangle(const_51,const_50,const_66,this.var_346,const_247);
         if(_loc2_ != null && param1 != null)
         {
            _loc2_.offset(-(this.var_1356 >> 1),-(this.var_1115 >> 1));
            _loc2_.offset(-param1.x,-param1.y);
            if(this.var_51 == null)
            {
               this.var_51 = _loc2_;
            }
            else
            {
               _loc3_ = this.var_51.union(_loc2_);
               if(_loc3_.width - this.var_51.width > this.var_1356 - this.var_51.width >> 1 || _loc3_.height - this.var_51.height > this.var_1115 - this.var_51.height >> 1 || this.var_51.width < 1 || this.var_51.height < 1)
               {
                  this.var_51 = _loc3_;
               }
            }
         }
      }
      
      private function validatePreviewSize(param1:Point) : Point
      {
         if(this.var_51.width < 1 || this.var_51.height < 1)
         {
            return param1;
         }
         var _loc2_:IRoomGeometry = this._roomEngine.getRoomCanvasGeometry(const_51,const_50,const_247);
         if(this.var_51.width > this.var_1356 * (1 + const_487) || this.var_51.height > this.var_1115 * (1 + const_487))
         {
            if(_loc2_.isZoomedIn())
            {
               _loc2_.performZoomOut();
               this.var_1359 = const_1721;
               this.var_2115 = true;
               param1.x >>= 1;
               param1.y >>= 1;
               this.var_51.left >>= 2;
               this.var_51.right >>= 2;
               this.var_51.top >>= 2;
               this.var_51.bottom >>= 2;
            }
         }
         else if(this.var_51.width << 1 < this.var_1356 * (1 + const_487) - 5 && this.var_51.height << 1 < this.var_1115 * (1 + const_487) - 5)
         {
            if(!_loc2_.isZoomedIn() && !this.var_2115)
            {
               _loc2_.performZoomIn();
               this.var_1359 = const_1719;
               param1.x <<= 1;
               param1.y <<= 1;
            }
         }
         return param1;
      }
      
      private function getCanvasOffset(param1:Point) : Point
      {
         var _loc7_:Number = NaN;
         if(this.var_51.width < 1 || this.var_51.height < 1)
         {
            return param1;
         }
         var _loc2_:* = -(this.var_51.left + this.var_51.right) >> 1;
         var _loc3_:* = -(this.var_51.top + this.var_51.bottom) >> 1;
         var _loc4_:* = this.var_1115 - this.var_51.height >> 1;
         if(_loc4_ > 10)
         {
            _loc3_ += Math.min(15,_loc4_ - 10);
         }
         else if(this.var_346 != RoomObjectCategoryEnum.OBJECT_CATEGORY_USER)
         {
            _loc3_ += 5 - Math.max(0,_loc4_ / 2);
         }
         else
         {
            _loc3_ -= 5 - Math.min(0,_loc4_ / 2);
         }
         var _loc5_:int = _loc2_ - param1.x;
         var _loc6_:int = _loc3_ - param1.y;
         if(_loc5_ != 0 || _loc6_ != 0)
         {
            _loc7_ = Math.sqrt(_loc5_ * _loc5_ + _loc6_ * _loc6_);
            if(_loc7_ > 10)
            {
               _loc2_ = int(param1.x + _loc5_ * 10 / _loc7_);
               _loc3_ = int(param1.y + _loc6_ * 10 / _loc7_);
            }
            return new Point(_loc2_,_loc3_);
         }
         return null;
      }
      
      public function updatePreviewRoomView() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         this.checkAutomaticRoomObjectStateChange();
         if(this._roomEngine != null)
         {
            _loc1_ = this._roomEngine.getRoomCanvasScreenOffset(const_51,const_50,const_247);
            if(_loc1_ != null)
            {
               this.updatePreviewObjectBoundingRectangle(_loc1_);
               if(this.var_51 != null)
               {
                  _loc2_ = this.var_1359;
                  _loc1_ = this.validatePreviewSize(_loc1_);
                  _loc3_ = this.getCanvasOffset(_loc1_);
                  if(_loc3_ != null)
                  {
                     this._roomEngine.setRoomCanvasScreenOffset(const_51,const_50,const_247,_loc3_);
                  }
                  if(this.var_1359 != _loc2_)
                  {
                     this.var_51 = null;
                  }
               }
            }
         }
      }
      
      private function onRoomInitialized(param1:RoomEngineEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case RoomEngineEvent.const_183:
               if(param1.roomCategory == const_50 && param1.roomId == const_51)
               {
                  this._roomEngine.updateObjectRoomColor(const_51,const_50,16777215,176,true);
                  this._roomEngine.updateObjectRoom(const_51,const_50,"306","1401");
               }
         }
      }
      
      private function onRoomObjectAdded(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param1.roomId == const_51 && param1.roomCategory == const_50 && param1.objectId == const_66 && param1.category == this.var_346)
         {
            this.var_51 = null;
            this.var_2115 = false;
            _loc2_ = this._roomEngine.getRoomObject(param1.roomId,param1.roomCategory,param1.objectId,param1.category);
            if(_loc2_ != null && _loc2_.getModel() != null && param1.category == RoomObjectCategoryEnum.const_26)
            {
               _loc3_ = _loc2_.getModel().getNumber(RoomObjectVariableEnum.const_501);
               _loc4_ = _loc2_.getModel().getNumber(RoomObjectVariableEnum.const_926);
               if(!isNaN(_loc3_) && !isNaN(_loc4_))
               {
                  this._roomEngine.updateObjectWallItemLocation(param1.roomId,param1.roomCategory,param1.objectId,new Vector3d(0.5,2.3,(3.6 - _loc3_) / 2 + _loc4_));
               }
            }
         }
      }
   }
}
