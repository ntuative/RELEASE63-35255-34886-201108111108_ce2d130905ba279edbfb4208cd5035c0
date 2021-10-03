package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.PlaneVisualizationAnimationLayer;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PlaneVisualization
   {
       
      
      private var var_129:Array;
      
      private var _geometry:IRoomGeometry = null;
      
      private var var_32:BitmapData;
      
      private var _cachedBitmapNormal:Vector3d = null;
      
      private var var_1757:Boolean = false;
      
      private var var_2451:Boolean = false;
      
      public function PlaneVisualization(param1:Number, param2:int, param3:IRoomGeometry)
      {
         this.var_129 = [];
         super();
         if(param2 < 0)
         {
            param2 = 0;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            this.var_129.push(null);
            _loc4_++;
         }
         this._geometry = param3;
         this._cachedBitmapNormal = new Vector3d();
      }
      
      public function get geometry() : IRoomGeometry
      {
         return this._geometry;
      }
      
      public function get hasAnimationLayers() : Boolean
      {
         return this.var_2451;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(this.var_129 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.var_129.length)
            {
               _loc2_ = this.var_129[_loc1_] as IDisposable;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            this.var_129 = null;
         }
         this._geometry = null;
         if(this.var_32 != null)
         {
            this.var_32.dispose();
         }
         if(this._cachedBitmapNormal != null)
         {
            this._cachedBitmapNormal = null;
         }
      }
      
      public function clearCache() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(!this.var_1757)
         {
            return;
         }
         if(this.var_32 != null)
         {
            this.var_32.dispose();
            this.var_32 = null;
         }
         if(this._cachedBitmapNormal != null)
         {
            this._cachedBitmapNormal.assign(new Vector3d());
         }
         if(this.var_129 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.var_129.length)
            {
               _loc2_ = this.var_129[_loc1_] as PlaneVisualizationLayer;
               _loc3_ = this.var_129[_loc1_] as PlaneVisualizationAnimationLayer;
               if(_loc2_ != null)
               {
                  _loc2_.clearCache();
               }
               else if(_loc3_ != null)
               {
                  _loc3_.clearCache();
               }
               _loc1_++;
            }
         }
         this.var_1757 = false;
      }
      
      public function method_5(param1:int, param2:PlaneMaterial, param3:uint, param4:int, param5:int = 0) : Boolean
      {
         if(param1 < 0 || param1 > this.var_129.length)
         {
            return false;
         }
         var _loc6_:* = this.var_129[param1] as IDisposable;
         if(_loc6_ != null)
         {
            _loc6_.dispose();
            _loc6_ = null;
         }
         _loc6_ = new PlaneVisualizationLayer(param2,param3,param4,param5);
         this.var_129[param1] = _loc6_;
         return true;
      }
      
      public function setAnimationLayer(param1:int, param2:XML, param3:IGraphicAssetCollection) : Boolean
      {
         if(param1 < 0 || param1 > this.var_129.length)
         {
            return false;
         }
         var _loc4_:* = this.var_129[param1] as IDisposable;
         if(_loc4_ != null)
         {
            _loc4_.dispose();
            _loc4_ = null;
         }
         _loc4_ = new PlaneVisualizationAnimationLayer(param2,param3);
         this.var_129[param1] = _loc4_;
         this.var_2451 = true;
         return true;
      }
      
      public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean, param6:int = 0, param7:int = 0, param8:int = 0, param9:int = 0, param10:Number = 0.0, param11:Number = 0.0, param12:int = 0) : BitmapData
      {
         var _loc14_:* = null;
         var _loc15_:* = null;
         if(param2 < 1)
         {
            param2 = 1;
         }
         if(param3 < 1)
         {
            param3 = 1;
         }
         if(param1 == null || param1.width != param2 || param1.height != param3)
         {
            param1 = null;
         }
         if(this.var_32 != null)
         {
            if(this.var_32.width == param2 && this.var_32.height == param3 && Vector3d.isEqual(this._cachedBitmapNormal,param4))
            {
               if(!this.hasAnimationLayers)
               {
                  if(param1 != null)
                  {
                     param1.copyPixels(this.var_32,this.var_32.rect,new Point(0,0),null,null,false);
                     return param1;
                  }
                  return this.var_32;
               }
            }
            else
            {
               this.var_32.dispose();
               this.var_32 = null;
            }
         }
         this.var_1757 = true;
         if(this.var_32 == null)
         {
            this.var_32 = new BitmapData(param2,param3,true,16777215);
         }
         else
         {
            this.var_32.fillRect(this.var_32.rect,16777215);
         }
         if(param1 == null)
         {
            param1 = this.var_32;
         }
         this._cachedBitmapNormal.assign(param4);
         var _loc13_:int = 0;
         while(_loc13_ < this.var_129.length)
         {
            _loc14_ = this.var_129[_loc13_] as PlaneVisualizationLayer;
            _loc15_ = this.var_129[_loc13_] as PlaneVisualizationAnimationLayer;
            if(_loc14_ != null)
            {
               _loc14_.render(param1,param2,param3,param4,param5);
            }
            else if(_loc15_ != null)
            {
               _loc15_.render(param1,param2,param3,param4,param6,param7,param8,param9,param10,param11,param12);
            }
            _loc13_++;
         }
         if(param1 != null && param1 != this.var_32)
         {
            this.var_32.copyPixels(param1,param1.rect,new Point(0,0),null,null,false);
            return param1;
         }
         return this.var_32;
      }
   }
}
