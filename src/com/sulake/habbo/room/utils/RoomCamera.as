package com.sulake.habbo.room.utils
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomCamera
   {
      
      private static const const_1460:Number = 12;
       
      
      private var var_2309:int = -1;
      
      private var var_2315:int = -2;
      
      private var var_212:Vector3d = null;
      
      private var var_1175:Number = 0;
      
      private var var_1456:Number = 0;
      
      private var var_1745:Boolean = false;
      
      private var var_193:Vector3d = null;
      
      private var var_1747:Vector3d;
      
      private var var_2307:Boolean = false;
      
      private var var_2308:Boolean = false;
      
      private var var_2310:Boolean = false;
      
      private var var_2314:Boolean = false;
      
      private var var_2312:int = 0;
      
      private var var_2306:int = 0;
      
      private var _scale:int = 0;
      
      private var var_2311:int = 0;
      
      private var var_2313:int = 0;
      
      private var var_1749:int = -1;
      
      private var var_1748:int = 0;
      
      private var var_1746:Boolean = false;
      
      public function RoomCamera()
      {
         this.var_1747 = new Vector3d();
         super();
      }
      
      public function get location() : IVector3d
      {
         return this.var_193;
      }
      
      public function get targetId() : int
      {
         return this.var_2309;
      }
      
      public function get targetCategory() : int
      {
         return this.var_2315;
      }
      
      public function get targetObjectLoc() : IVector3d
      {
         return this.var_1747;
      }
      
      public function get limitedLocationX() : Boolean
      {
         return this.var_2307;
      }
      
      public function get limitedLocationY() : Boolean
      {
         return this.var_2308;
      }
      
      public function get centeredLocX() : Boolean
      {
         return this.var_2310;
      }
      
      public function get centeredLocY() : Boolean
      {
         return this.var_2314;
      }
      
      public function get screenWd() : int
      {
         return this.var_2312;
      }
      
      public function get screenHt() : int
      {
         return this.var_2306;
      }
      
      public function get scale() : int
      {
         return this._scale;
      }
      
      public function get roomWd() : int
      {
         return this.var_2311;
      }
      
      public function get roomHt() : int
      {
         return this.var_2313;
      }
      
      public function get geometryUpdateId() : int
      {
         return this.var_1749;
      }
      
      public function get isMoving() : Boolean
      {
         if(this.var_212 != null && this.var_193 != null)
         {
            return true;
         }
         return false;
      }
      
      public function set targetId(param1:int) : void
      {
         this.var_2309 = param1;
      }
      
      public function set targetObjectLoc(param1:IVector3d) : void
      {
         this.var_1747.assign(param1);
      }
      
      public function set targetCategory(param1:int) : void
      {
         this.var_2315 = param1;
      }
      
      public function set limitedLocationX(param1:Boolean) : void
      {
         this.var_2307 = param1;
      }
      
      public function set limitedLocationY(param1:Boolean) : void
      {
         this.var_2308 = param1;
      }
      
      public function set centeredLocX(param1:Boolean) : void
      {
         this.var_2310 = param1;
      }
      
      public function set centeredLocY(param1:Boolean) : void
      {
         this.var_2314 = param1;
      }
      
      public function set screenWd(param1:int) : void
      {
         this.var_2312 = param1;
      }
      
      public function set screenHt(param1:int) : void
      {
         this.var_2306 = param1;
      }
      
      public function set scale(param1:int) : void
      {
         if(this._scale != param1)
         {
            this._scale = param1;
            this.var_1746 = true;
         }
      }
      
      public function set roomWd(param1:int) : void
      {
         this.var_2311 = param1;
      }
      
      public function set roomHt(param1:int) : void
      {
         this.var_2313 = param1;
      }
      
      public function set geometryUpdateId(param1:int) : void
      {
         this.var_1749 = param1;
      }
      
      public function set target(param1:IVector3d) : void
      {
         var _loc2_:* = null;
         if(this.var_212 == null)
         {
            this.var_212 = new Vector3d();
         }
         if(this.var_212.x != param1.x || this.var_212.y != param1.y || this.var_212.z != param1.z)
         {
            this.var_212.assign(param1);
            this.var_1748 = 0;
            _loc2_ = Vector3d.dif(this.var_212,this.var_193);
            this.var_1175 = _loc2_.length;
            this.var_1745 = true;
         }
      }
      
      public function dispose() : void
      {
         this.var_212 = null;
         this.var_193 = null;
      }
      
      public function initializeLocation(param1:IVector3d) : void
      {
         if(this.var_193 != null)
         {
            return;
         }
         this.var_193 = new Vector3d();
         this.var_193.assign(param1);
      }
      
      public function resetLocation(param1:IVector3d) : void
      {
         if(this.var_193 == null)
         {
            this.var_193 = new Vector3d();
         }
         this.var_193.assign(param1);
      }
      
      public function update(param1:uint, param2:Number) : void
      {
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.var_212 != null && this.var_193 != null)
         {
            ++this.var_1748;
            if(this.var_1746)
            {
               this.var_1746 = false;
               this.var_193 = this.var_212;
               this.var_212 = null;
               return;
            }
            _loc3_ = Vector3d.dif(this.var_212,this.var_193);
            if(_loc3_.length > this.var_1175)
            {
               this.var_1175 = _loc3_.length;
            }
            if(_loc3_.length <= param2)
            {
               this.var_193 = this.var_212;
               this.var_212 = null;
               this.var_1456 = 0;
            }
            else
            {
               _loc4_ = Math.sin(0 * _loc3_.length / this.var_1175);
               _loc5_ = param2 * 0.5;
               _loc6_ = this.var_1175 / const_1460;
               _loc7_ = _loc5_ + (_loc6_ - _loc5_) * _loc4_;
               if(this.var_1745)
               {
                  if(_loc7_ < this.var_1456)
                  {
                     _loc7_ = this.var_1456;
                     if(_loc7_ > _loc3_.length)
                     {
                        _loc7_ = _loc3_.length;
                     }
                  }
                  else
                  {
                     this.var_1745 = false;
                  }
               }
               this.var_1456 = _loc7_;
               _loc3_.div(_loc3_.length);
               _loc3_.mul(_loc7_);
               this.var_193 = Vector3d.sum(this.var_193,_loc3_);
            }
         }
      }
      
      public function reset() : void
      {
         this.var_1749 = -1;
      }
   }
}
