package com.sulake.room.renderer.cache
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.renderer.utils.ExtendedBitmapData;
   import flash.display.BitmapData;
   
   public class BitmapDataCache
   {
       
      
      private var _dataMap:Map;
      
      private var var_842:int = 0;
      
      private var var_1062:int = 0;
      
      private var var_1990:int = 0;
      
      private var var_1592:int = 0;
      
      public function BitmapDataCache(param1:int, param2:int, param3:int = 1)
      {
         super();
         this._dataMap = new Map();
         this.var_1062 = param1 * 1024 * 1024;
         this.var_1990 = param2 * 1024 * 1024;
         this.var_1592 = param3 * 1024 * 1024;
         if(this.var_1592 < 0)
         {
            this.var_1592 = 0;
         }
      }
      
      public function get memUsage() : int
      {
         return this.var_842;
      }
      
      public function get memLimit() : int
      {
         return this.var_1062;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this._dataMap != null)
         {
            _loc1_ = this._dataMap.getKeys();
            for each(_loc2_ in _loc1_)
            {
               if(!this.removeItem(_loc2_))
               {
                  Logger.log("Failed to remove item " + _loc2_ + " from room canvas bitmap cache!");
               }
            }
            this._dataMap.dispose();
            this._dataMap = null;
         }
      }
      
      public function compress() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(this.memUsage > this.memLimit)
         {
            _loc3_ = this._dataMap.getValues();
            _loc3_.sortOn("useCount",0 | 0);
            _loc2_ = _loc3_.length - 1;
            while(_loc2_ >= 0)
            {
               _loc1_ = _loc3_[_loc2_] as BitmapDataCacheItem;
               if(_loc1_.useCount > 1)
               {
                  break;
               }
               this.removeItem(_loc1_.name);
               _loc2_--;
            }
            this.increaseMemoryLimit();
         }
      }
      
      private function increaseMemoryLimit() : void
      {
         this.var_1062 += this.var_1592;
         if(this.var_1062 > this.var_1990)
         {
            this.var_1062 = this.var_1990;
         }
      }
      
      private function removeItem(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:BitmapDataCacheItem = this._dataMap.getValue(param1) as BitmapDataCacheItem;
         if(_loc2_ != null)
         {
            if(_loc2_.useCount <= 1)
            {
               this._dataMap.remove(_loc2_.name);
               this.var_842 -= _loc2_.memUsage;
               _loc2_.dispose();
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function getBitmapData(param1:String) : ExtendedBitmapData
      {
         var _loc2_:BitmapDataCacheItem = this._dataMap.getValue(param1) as BitmapDataCacheItem;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.bitmapData;
      }
      
      public function addBitmapData(param1:String, param2:ExtendedBitmapData) : void
      {
         var _loc4_:* = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:BitmapDataCacheItem = this._dataMap.getValue(param1) as BitmapDataCacheItem;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.bitmapData;
            if(_loc4_ != null)
            {
               this.var_842 -= _loc4_.width * _loc4_.height * 4;
            }
            _loc3_.bitmapData = param2;
         }
         else
         {
            _loc3_ = new BitmapDataCacheItem(param2,param1);
            this._dataMap.add(param1,_loc3_);
         }
         this.var_842 += param2.width * param2.height * 4;
      }
   }
}
