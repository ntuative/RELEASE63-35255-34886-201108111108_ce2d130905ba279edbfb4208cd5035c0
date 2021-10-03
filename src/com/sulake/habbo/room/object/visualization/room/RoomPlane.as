package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomPlane
   {
      
      private static const const_692:Point = new Point(0,0);
      
      public static const const_2059:int = 0;
      
      public static const const_75:int = 1;
      
      public static const const_108:int = 2;
      
      public static const TYPE_LANDSCAPE:int = 3;
       
      
      private var _disposed:Boolean = false;
      
      private var var_2590:int = 0;
      
      private var var_1242:Vector3d = null;
      
      private var var_104:Vector3d = null;
      
      private var var_353:Vector3d = null;
      
      private var var_352:Vector3d = null;
      
      private var _normal:Vector3d = null;
      
      private var var_1524:Array;
      
      private var var_1749:int = -1;
      
      private var _type:int = 0;
      
      private var _isVisible:Boolean = false;
      
      private var _bitmapData:BitmapData = null;
      
      private var var_1893:Boolean = true;
      
      private var _offset:Point = null;
      
      private var var_2592:Number = 0;
      
      private var _color:uint = 0;
      
      private var var_1017:IPlaneRasterizer = null;
      
      private var var_848:PlaneMaskManager = null;
      
      private var _id:String = null;
      
      private var var_2591:Number = 0;
      
      private var var_2594:Number = 0;
      
      private var var_2593:Number = 0;
      
      private var var_2589:Number = 0;
      
      private var var_219:Map = null;
      
      private var var_463:PlaneBitmapData = null;
      
      private var var_1018:Boolean = false;
      
      private var var_275:Array;
      
      private var var_383:Array;
      
      private var var_384:Boolean = false;
      
      private var var_79:BitmapData = null;
      
      private var var_244:BitmapData = null;
      
      private var var_1019:Array;
      
      private var var_1523:Array;
      
      private var var_178:Vector3d = null;
      
      private var var_133:Vector3d = null;
      
      private var var_99:Vector3d = null;
      
      private var var_132:Vector3d = null;
      
      private var var_232:Number = 0.0;
      
      private var _height:Number = 0.0;
      
      private var var_807:Boolean = true;
      
      public function RoomPlane(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d, param5:int, param6:Boolean, param7:Array, param8:int, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:Number = 0)
      {
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         this.var_1524 = [];
         this.var_275 = [];
         this.var_383 = [];
         this.var_1019 = [];
         this.var_1523 = [];
         super();
         this.var_2590 = param8;
         this.var_1242 = new Vector3d();
         this.var_1242.assign(param1);
         this.var_104 = new Vector3d();
         this.var_104.assign(param2);
         this.var_353 = new Vector3d();
         this.var_353.assign(param3);
         this.var_352 = new Vector3d();
         this.var_352.assign(param4);
         this._normal = Vector3d.crossProduct(this.var_353,this.var_352);
         if(this._normal.length > 0)
         {
            this._normal.mul(1 / this._normal.length);
         }
         if(param7 != null)
         {
            _loc13_ = 0;
            while(_loc13_ < param7.length)
            {
               _loc14_ = param7[_loc13_] as IVector3d;
               if(_loc14_ != null)
               {
                  _loc15_ = new Vector3d();
                  _loc15_.assign(_loc14_);
                  this.var_1524.push(_loc15_);
               }
               _loc13_++;
            }
         }
         this._offset = new Point();
         this._type = param5;
         this.var_219 = new Map();
         this.var_178 = new Vector3d();
         this.var_133 = new Vector3d();
         this.var_99 = new Vector3d();
         this.var_132 = new Vector3d();
         this.var_2591 = param9;
         this.var_2594 = param10;
         this.var_2593 = param11;
         this.var_2589 = param12;
         this.var_1018 = param6;
      }
      
      public function set canBeVisible(param1:Boolean) : void
      {
         if(param1 != this.var_807)
         {
            if(!this.var_807)
            {
               this.resetTextureCache();
            }
            this.var_807 = param1;
         }
      }
      
      public function get canBeVisible() : Boolean
      {
         return this.var_807;
      }
      
      public function get bitmapData() : BitmapData
      {
         var bitmap:BitmapData = null;
         if(this.visible)
         {
            if(this._bitmapData != null)
            {
               try
               {
                  bitmap = this._bitmapData.clone();
               }
               catch(e:Error)
               {
               }
            }
         }
         return bitmap;
      }
      
      public function get visible() : Boolean
      {
         return this._isVisible && this.var_807;
      }
      
      public function get offset() : Point
      {
         return this._offset;
      }
      
      public function get relativeDepth() : Number
      {
         return this.var_2592;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         this._color = param1;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get leftSide() : IVector3d
      {
         return this.var_353;
      }
      
      public function get rightSide() : IVector3d
      {
         return this.var_352;
      }
      
      public function get location() : IVector3d
      {
         return this.var_104;
      }
      
      public function get normal() : IVector3d
      {
         return this._normal;
      }
      
      public function get hasTexture() : Boolean
      {
         return this.var_1893;
      }
      
      public function set hasTexture(param1:Boolean) : void
      {
         this.var_1893 = param1;
      }
      
      public function set rasterizer(param1:IPlaneRasterizer) : void
      {
         this.var_1017 = param1;
      }
      
      public function set maskManager(param1:PlaneMaskManager) : void
      {
         this.var_848 = param1;
      }
      
      public function set id(param1:String) : void
      {
         if(param1 != this._id)
         {
            this.resetTextureCache();
            this._id = param1;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(this._bitmapData != null)
         {
            this._bitmapData.dispose();
            this._bitmapData = null;
         }
         if(this.var_219 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.var_219.length)
            {
               _loc2_ = this.var_219.getWithIndex(_loc1_) as PlaneBitmapData;
               if(_loc2_ != null)
               {
                  if(_loc2_.bitmap != null)
                  {
                     _loc2_.bitmap.dispose();
                  }
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            this.var_219.dispose();
            this.var_219 = null;
         }
         this.var_463 = null;
         this.var_104 = null;
         this.var_1242 = null;
         this.var_353 = null;
         this.var_352 = null;
         this._normal = null;
         this.var_1017 = null;
         this.var_178 = null;
         this.var_133 = null;
         this.var_99 = null;
         this.var_132 = null;
         this.var_275 = null;
         this.var_383 = null;
         if(this.var_79 != null)
         {
            this.var_79.dispose();
            this.var_79 = null;
         }
         if(this.var_244 != null)
         {
            this.var_244.dispose();
            this.var_244 = null;
         }
         this._disposed = true;
      }
      
      public function copyBitmapData(param1:BitmapData) : BitmapData
      {
         if(this.visible)
         {
            if(this._bitmapData != null && param1 != null)
            {
               if(this._bitmapData.width == param1.width && this._bitmapData.height == param1.height)
               {
                  param1.copyPixels(this._bitmapData,this._bitmapData.rect,const_692);
                  return param1;
               }
            }
         }
         return null;
      }
      
      private function cacheTexture(param1:String, param2:PlaneBitmapData) : Boolean
      {
         var _loc3_:PlaneBitmapData = this.var_219.remove(param1) as PlaneBitmapData;
         if(_loc3_ != null)
         {
            if(param2 != null && param2.bitmap != _loc3_.bitmap)
            {
               _loc3_.bitmap.dispose();
            }
            _loc3_.dispose();
         }
         this.var_463 = param2;
         this.var_219.add(param1,param2);
         return true;
      }
      
      private function resetTextureCache(param1:BitmapData = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(this.var_219 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this.var_219.length)
            {
               _loc3_ = this.var_219.getWithIndex(_loc2_) as PlaneBitmapData;
               if(_loc3_ != null)
               {
                  if(_loc3_.bitmap != null && _loc3_.bitmap != param1)
                  {
                     _loc3_.bitmap.dispose();
                  }
                  _loc3_.dispose();
               }
               _loc2_++;
            }
            this.var_219.reset();
         }
         this.var_463 = null;
      }
      
      private function getTextureIdentifier(param1:Number) : String
      {
         if(this.var_1017 != null)
         {
            return this.var_1017.getTextureIdentifier(param1,this.normal);
         }
         return String(param1);
      }
      
      private function needsNewTexture(param1:IRoomGeometry, param2:int) : Boolean
      {
         var _loc4_:* = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:PlaneBitmapData = this.var_463;
         if(_loc3_ == null)
         {
            _loc4_ = this.getTextureIdentifier(param1.scale);
            _loc3_ = this.var_219.getValue(_loc4_) as PlaneBitmapData;
         }
         this.updateMaskChangeStatus();
         if(this.var_807 && (_loc3_ == null || _loc3_.timeStamp >= 0 && param2 > _loc3_.timeStamp || this.var_384))
         {
            return true;
         }
         return false;
      }
      
      private function getTexture(param1:IRoomGeometry, param2:int) : BitmapData
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(this.needsNewTexture(param1,param2))
         {
            _loc5_ = this.var_353.length * param1.scale;
            _loc6_ = this.var_352.length * param1.scale;
            _loc7_ = param1.getCoordinatePosition(this._normal);
            _loc4_ = this.getTextureIdentifier(param1.scale);
            if(this.var_463 != null)
            {
               _loc3_ = this.var_463;
            }
            else
            {
               _loc3_ = this.var_219.getValue(_loc4_) as PlaneBitmapData;
            }
            _loc8_ = null;
            if(_loc3_ != null)
            {
               _loc8_ = _loc3_.bitmap;
            }
            if(this.var_1017 != null)
            {
               _loc3_ = this.var_1017.render(_loc8_,this._id,_loc5_,_loc6_,param1.scale,_loc7_,this.var_1893,this.var_2591,this.var_2594,this.var_2593,this.var_2589,param2);
               if(_loc3_ != null)
               {
                  if(_loc8_ != null && _loc3_.bitmap != _loc8_)
                  {
                     _loc8_.dispose();
                  }
               }
            }
            else
            {
               _loc9_ = new BitmapData(_loc5_,_loc6_,true,4278190080 | this._color);
               _loc3_ = new PlaneBitmapData(_loc9_,-1);
            }
            if(_loc3_ != null)
            {
               this.updateMask(_loc3_.bitmap,param1);
               this.cacheTexture(_loc4_,_loc3_);
            }
         }
         else if(this.var_463 != null)
         {
            _loc3_ = this.var_463;
         }
         else
         {
            _loc4_ = this.getTextureIdentifier(param1.scale);
            _loc3_ = this.var_219.getValue(_loc4_) as PlaneBitmapData;
         }
         if(_loc3_ != null)
         {
            this.var_463 = _loc3_;
            return _loc3_.bitmap;
         }
         return null;
      }
      
      private function addOutlines(param1:PlaneBitmapData) : void
      {
      }
      
      public function update(param1:IRoomGeometry, param2:int) : Boolean
      {
         var cosAngle:Number = NaN;
         var i:int = 0;
         var originPos:IVector3d = null;
         var originZ:Number = NaN;
         var relativeDepth:Number = NaN;
         var texture:BitmapData = null;
         var geometry:IRoomGeometry = param1;
         var timeSinceStartMs:int = param2;
         if(geometry == null || this._disposed)
         {
            return false;
         }
         var geometryChanged:Boolean = false;
         if(this.var_1749 != geometry.updateId)
         {
            geometryChanged = true;
         }
         if(!geometryChanged || !this.var_807)
         {
            if(!this.visible)
            {
               return false;
            }
         }
         if(geometryChanged)
         {
            this.var_463 = null;
            cosAngle = 0;
            cosAngle = Vector3d.cosAngle(geometry.directionAxis,this.normal);
            if(cosAngle > -0.001)
            {
               if(this._isVisible)
               {
                  this._isVisible = false;
                  return true;
               }
               return false;
            }
            i = 0;
            while(i < this.var_1524.length)
            {
               cosAngle = Vector3d.cosAngle(geometry.directionAxis,this.var_1524[i]);
               if(cosAngle > -0.001)
               {
                  if(this._isVisible)
                  {
                     this._isVisible = false;
                     return true;
                  }
                  return false;
               }
               i++;
            }
            this.updateCorners(geometry);
            originPos = geometry.getScreenPosition(this.var_1242);
            originZ = originPos.z;
            relativeDepth = Math.max(this.var_178.z - originZ,this.var_133.z - originZ,this.var_99.z - originZ,this.var_132.z - originZ);
            if(this._type == TYPE_LANDSCAPE)
            {
               relativeDepth += 0.02;
            }
            this.var_2592 = relativeDepth;
            this._isVisible = true;
            this.var_1749 = geometry.updateId;
         }
         if(geometryChanged || this.needsNewTexture(geometry,timeSinceStartMs))
         {
            if(this._bitmapData == null || this.var_232 != this._bitmapData.width || this._height != this._bitmapData.height)
            {
               if(this._bitmapData != null)
               {
                  this._bitmapData.dispose();
                  this._bitmapData = null;
                  if(this.var_232 < 1 || this._height < 1)
                  {
                     return true;
                  }
               }
               else if(this.var_232 < 1 || this._height < 1)
               {
                  return false;
               }
               try
               {
                  this._bitmapData = new BitmapData(this.var_232,this._height,true,16777215);
               }
               catch(e:Error)
               {
                  _bitmapData = null;
               }
               if(this._bitmapData == null)
               {
                  return false;
               }
               this._bitmapData.lock();
            }
            else
            {
               this._bitmapData.lock();
               this._bitmapData.fillRect(this._bitmapData.rect,16777215);
            }
            Randomizer.setSeed(this.var_2590);
            texture = this.getTexture(geometry,timeSinceStartMs);
            if(texture != null)
            {
               this.renderTexture(geometry,texture);
            }
            this._bitmapData.unlock();
            return true;
         }
         return false;
      }
      
      private function updateCorners(param1:IRoomGeometry) : void
      {
         this.var_178.assign(param1.getScreenPosition(this.var_104));
         this.var_133.assign(param1.getScreenPosition(Vector3d.sum(this.var_104,this.var_352)));
         this.var_99.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(this.var_104,this.var_353),this.var_352)));
         this.var_132.assign(param1.getScreenPosition(Vector3d.sum(this.var_104,this.var_353)));
         this._offset = param1.getScreenPoint(this.var_1242);
         this.var_178.x = Math.round(this.var_178.x);
         this.var_178.y = Math.round(this.var_178.y);
         this.var_133.x = Math.round(this.var_133.x);
         this.var_133.y = Math.round(this.var_133.y);
         this.var_99.x = Math.round(this.var_99.x);
         this.var_99.y = Math.round(this.var_99.y);
         this.var_132.x = Math.round(this.var_132.x);
         this.var_132.y = Math.round(this.var_132.y);
         this._offset.x = Math.round(this._offset.x);
         this._offset.y = Math.round(this._offset.y);
         var _loc2_:Number = Math.min(this.var_178.x,this.var_133.x,this.var_99.x,this.var_132.x);
         var _loc3_:Number = Math.max(this.var_178.x,this.var_133.x,this.var_99.x,this.var_132.x);
         var _loc4_:Number = Math.min(this.var_178.y,this.var_133.y,this.var_99.y,this.var_132.y);
         var _loc5_:Number = Math.max(this.var_178.y,this.var_133.y,this.var_99.y,this.var_132.y);
         _loc3_ -= _loc2_;
         this._offset.x -= _loc2_;
         this.var_178.x -= _loc2_;
         this.var_133.x -= _loc2_;
         this.var_99.x -= _loc2_;
         this.var_132.x -= _loc2_;
         _loc5_ -= _loc4_;
         this._offset.y -= _loc4_;
         this.var_178.y -= _loc4_;
         this.var_133.y -= _loc4_;
         this.var_99.y -= _loc4_;
         this.var_132.y -= _loc4_;
         this.var_232 = _loc3_;
         this._height = _loc5_;
      }
      
      private function renderTexture(param1:IRoomGeometry, param2:BitmapData) : void
      {
         if(this.var_178 == null || this.var_133 == null || this.var_99 == null || this.var_132 == null || param2 == null || this._bitmapData == null)
         {
            return;
         }
         var _loc3_:Number = this.var_132.x - this.var_99.x;
         var _loc4_:Number = this.var_132.y - this.var_99.y;
         var _loc5_:Number = this.var_133.x - this.var_99.x;
         var _loc6_:Number = this.var_133.y - this.var_99.y;
         if(this._type == const_75 || this._type == TYPE_LANDSCAPE)
         {
            if(Math.abs(_loc5_ - param2.width) <= 1)
            {
               _loc5_ = param2.width;
            }
            if(Math.abs(_loc6_ - param2.width) <= 1)
            {
               _loc6_ = param2.width;
            }
            if(Math.abs(_loc3_ - param2.height) <= 1)
            {
               _loc3_ = param2.height;
            }
            if(Math.abs(_loc4_ - param2.height) <= 1)
            {
               _loc4_ = param2.height;
            }
         }
         var _loc7_:Number = _loc5_ / param2.width;
         var _loc8_:Number = _loc6_ / param2.width;
         var _loc9_:Number = _loc3_ / param2.height;
         var _loc10_:Number = _loc4_ / param2.height;
         var _loc11_:Matrix = new Matrix();
         _loc11_.a = _loc7_;
         _loc11_.b = _loc8_;
         _loc11_.c = _loc9_;
         _loc11_.d = _loc10_;
         _loc11_.translate(this.var_99.x,this.var_99.y);
         this.draw(param2,_loc11_);
      }
      
      private function draw(param1:BitmapData, param2:Matrix) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = NaN;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this._bitmapData != null)
         {
            if(param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1 && (this._type == const_75 || this._type == TYPE_LANDSCAPE))
            {
               _loc3_ = 0;
               _loc4_ = 0;
               _loc5_ = 0;
               _loc6_ = 0;
               if(param2.b > 0)
               {
                  ++param2.ty;
               }
               _loc7_ = 0;
               while(_loc3_ < param1.width)
               {
                  _loc3_++;
                  _loc5_ += Math.abs(param2.b);
                  if(_loc5_ >= 1)
                  {
                     this._bitmapData.copyPixels(param1,new Rectangle(_loc4_ + _loc6_,0,_loc3_ - _loc4_,param1.height),new Point(param2.tx + _loc4_,param2.ty + _loc7_),null,null,true);
                     _loc4_ = _loc3_;
                     if(param2.b > 0)
                     {
                        _loc7_++;
                     }
                     else
                     {
                        _loc7_--;
                     }
                     _loc5_ = 0;
                  }
               }
               if(_loc5_ > 0)
               {
                  this._bitmapData.copyPixels(param1,new Rectangle(_loc4_,0,_loc3_ - _loc4_,param1.height),new Point(param2.tx + _loc4_,param2.ty + _loc7_),null,null,true);
               }
               return;
            }
            this._bitmapData.draw(param1,param2,null,null,null,false);
         }
      }
      
      public function resetBitmapMasks() : void
      {
         if(this.var_1018)
         {
            if(this.var_275.length == 0)
            {
               return;
            }
            this.var_384 = true;
            this.var_275 = [];
         }
      }
      
      public function addBitmapMask(param1:String, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         if(this.var_1018)
         {
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < this.var_275.length)
            {
               _loc4_ = this.var_275[_loc5_] as RoomPlaneBitmapMask;
               if(_loc4_ != null)
               {
                  if(_loc4_.type == param1 && _loc4_.leftSideLoc == param2 && _loc4_.rightSideLoc == param3)
                  {
                     return false;
                  }
               }
               _loc5_++;
            }
            _loc4_ = new RoomPlaneBitmapMask(param1,param2,param3);
            this.var_275.push(_loc4_);
            this.var_384 = true;
            return true;
         }
         return false;
      }
      
      public function resetRectangleMasks() : void
      {
         if(this.var_1018)
         {
            if(this.var_383.length == 0)
            {
               return;
            }
            this.var_384 = true;
            this.var_383 = [];
         }
      }
      
      public function addRectangleMask(param1:Number, param2:Number, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(this.var_1018)
         {
            _loc5_ = null;
            _loc6_ = 0;
            while(_loc6_ < this.var_383.length)
            {
               _loc5_ = this.var_383[_loc6_] as RoomPlaneRectangleMask;
               if(_loc5_ != null)
               {
                  if(_loc5_.leftSideLoc == param1 && _loc5_.rightSideLoc == param2 && _loc5_.leftSideLength == param3 && _loc5_.rightSideLength == param4)
                  {
                     return false;
                  }
               }
               _loc6_++;
            }
            _loc5_ = new RoomPlaneRectangleMask(param1,param2,param3,param4);
            this.var_383.push(_loc5_);
            this.var_384 = true;
            return true;
         }
         return false;
      }
      
      private function updateMaskChangeStatus() : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:* = null;
         if(!this.var_384)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = true;
         var _loc4_:* = null;
         if(this.var_275.length == this.var_1019.length)
         {
            while(_loc1_ < this.var_275.length)
            {
               _loc4_ = this.var_275[_loc1_] as RoomPlaneBitmapMask;
               if(_loc4_ != null)
               {
                  _loc6_ = false;
                  while(_loc2_ < this.var_1019.length)
                  {
                     _loc7_ = this.var_1019[_loc2_] as RoomPlaneBitmapMask;
                     if(_loc7_ != null)
                     {
                        if(_loc7_.type == _loc4_.type && _loc7_.leftSideLoc == _loc4_.leftSideLoc && _loc7_.rightSideLoc == _loc4_.rightSideLoc)
                        {
                           _loc6_ = true;
                           break;
                        }
                     }
                     _loc2_++;
                  }
                  if(!_loc6_)
                  {
                     _loc3_ = false;
                     break;
                  }
               }
               _loc1_++;
            }
         }
         else
         {
            _loc3_ = false;
         }
         if(this.var_383.length > this.var_1523.length)
         {
            _loc3_ = false;
         }
         if(_loc3_)
         {
            this.var_384 = false;
         }
      }
      
      private function updateMask(param1:BitmapData, param2:IRoomGeometry) : void
      {
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         if(!this.var_1018 || this.var_275.length == 0 && this.var_383.length == 0 && !this.var_384 || this.var_848 == null)
         {
            return;
         }
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.updateMaskChangeStatus();
         var _loc7_:Number = param1.width;
         var _loc8_:Number = param1.height;
         if(this.var_79 == null || this.var_79.width != _loc7_ || this.var_79.height != _loc8_)
         {
            if(this.var_79 != null)
            {
               this.var_79.dispose();
               this.var_79 = null;
            }
            this.var_79 = new BitmapData(_loc7_,_loc8_,true,16777215);
            this.var_384 = true;
         }
         if(this.var_384)
         {
            this.var_1019 = [];
            this.var_1523 = [];
            if(this.var_79 != null)
            {
               this.var_79.fillRect(this.var_79.rect,16777215);
            }
            this.resetTextureCache(param1);
            _loc9_ = param2.getCoordinatePosition(this._normal);
            _loc10_ = 0;
            _loc11_ = 0;
            _loc5_ = 0;
            while(_loc5_ < this.var_275.length)
            {
               _loc3_ = this.var_275[_loc5_] as RoomPlaneBitmapMask;
               if(_loc3_ != null)
               {
                  _loc10_ = this.var_79.width - this.var_79.width * _loc3_.leftSideLoc / this.var_353.length;
                  _loc11_ = this.var_79.height - this.var_79.height * _loc3_.rightSideLoc / this.var_352.length;
                  _loc12_ = _loc3_.type;
                  this.var_848.updateMask(this.var_79,_loc12_,param2.scale,_loc9_,_loc10_,_loc11_);
                  this.var_1019.push(new RoomPlaneBitmapMask(_loc12_,_loc3_.leftSideLoc,_loc3_.rightSideLoc));
               }
               _loc5_++;
            }
            _loc6_ = 0;
            while(_loc6_ < this.var_383.length)
            {
               _loc4_ = this.var_383[_loc6_] as RoomPlaneRectangleMask;
               if(_loc4_ != null)
               {
                  _loc10_ = this.var_79.width - this.var_79.width * _loc4_.leftSideLoc / this.var_353.length;
                  _loc11_ = this.var_79.height - this.var_79.height * _loc4_.rightSideLoc / this.var_352.length;
                  _loc13_ = this.var_79.width * _loc4_.leftSideLength / this.var_353.length;
                  _loc14_ = this.var_79.height * _loc4_.rightSideLength / this.var_352.length;
                  this.var_79.fillRect(new Rectangle(_loc10_ - _loc13_,_loc11_ - _loc14_,_loc13_,_loc14_),4278190080);
                  this.var_1523.push(new RoomPlaneRectangleMask(_loc4_.leftSideLength,_loc4_.rightSideLoc,_loc4_.leftSideLength,_loc4_.rightSideLength));
               }
               _loc6_++;
            }
            this.var_384 = false;
         }
         this.combineTextureMask(param1,this.var_79);
      }
      
      private function combineTextureMask(param1:BitmapData, param2:BitmapData) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(this.var_244 != null && (this.var_244.width != param1.width || this.var_244.height != param1.height))
         {
            this.var_244.dispose();
            this.var_244 = null;
         }
         if(this.var_244 == null)
         {
            this.var_244 = new BitmapData(param1.width,param1.height,true,4294967295);
         }
         this.var_244.copyChannel(param1,param1.rect,const_692,BitmapDataChannel.ALPHA,BitmapDataChannel.RED);
         this.var_244.draw(param2,null,null,BlendMode.DARKEN);
         param1.copyChannel(this.var_244,this.var_244.rect,const_692,BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
      }
   }
}
