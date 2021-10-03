package com.sulake.core.utils.profiler.tracking
{
   import flash.display.BitmapData;
   
   public class TrackedBitmapData extends BitmapData
   {
      
      public static const const_2247:int = 16777215;
      
      public static const const_1434:int = 8191;
      
      public static const const_1437:int = 8191;
      
      public static const const_2201:int = 1;
      
      public static const const_1393:int = 1;
      
      public static const const_1293:int = 1;
      
      private static var var_599:uint = 0;
      
      private static var var_600:uint = 0;
       
      
      private var _owner:Object;
      
      private var _disposed:Boolean = false;
      
      public function TrackedBitmapData(param1:*, param2:int, param3:int, param4:Boolean = true, param5:uint = 4.294967295E9)
      {
         if(param2 > const_1434)
         {
            param2 = const_1434;
         }
         else if(param2 < const_1393)
         {
            param2 = const_1393;
         }
         if(param3 > const_1437)
         {
            param3 = const_1437;
         }
         else if(param3 < const_1293)
         {
            param3 = const_1293;
         }
         super(param2,param3,param4,param5);
         ++var_599;
         var_600 += param2 * param3 * 4;
         this._owner = param1;
      }
      
      public static function get numInstances() : uint
      {
         return var_599;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return var_600;
      }
      
      override public function dispose() : void
      {
         if(!this._disposed)
         {
            var_600 -= width * height * 4;
            --var_599;
            this._disposed = true;
            this._owner = null;
            super.dispose();
         }
      }
   }
}
