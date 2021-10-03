package com.sulake.room.renderer.cache
{
   import com.sulake.room.renderer.utils.ExtendedBitmapData;
   
   public class BitmapDataCacheItem
   {
       
      
      private var _bitmapData:ExtendedBitmapData = null;
      
      private var _name:String = "";
      
      private var var_842:int = 0;
      
      public function BitmapDataCacheItem(param1:ExtendedBitmapData, param2:String)
      {
         super();
         this._bitmapData = param1;
         this._name = param2;
         if(param1 != null)
         {
            param1.addReference();
            this.var_842 = this._bitmapData.width * this._bitmapData.height * 4;
         }
      }
      
      public function get bitmapData() : ExtendedBitmapData
      {
         return this._bitmapData;
      }
      
      public function get memUsage() : int
      {
         return this.var_842;
      }
      
      public function get useCount() : int
      {
         if(this._bitmapData == null)
         {
            return 0;
         }
         return this._bitmapData.referenceCount;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set bitmapData(param1:ExtendedBitmapData) : void
      {
         if(this._bitmapData != null)
         {
            this._bitmapData.dispose();
         }
         this._bitmapData = param1;
         if(this._bitmapData != null)
         {
            this._bitmapData.addReference();
            this.var_842 = this._bitmapData.width * this._bitmapData.height * 4;
         }
         else
         {
            this.var_842 = 0;
         }
      }
      
      public function dispose() : void
      {
         if(this._bitmapData != null)
         {
            this._bitmapData.dispose();
            this._bitmapData = null;
         }
         this.var_842 = 0;
      }
   }
}
