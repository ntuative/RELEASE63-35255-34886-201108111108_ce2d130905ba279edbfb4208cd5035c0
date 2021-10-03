package com.sulake.core.assets.loaders
{
   import flash.events.Event;
   
   public class AssetLoaderEvent extends Event
   {
      
      public static const ASSET_LOADER_EVENT_COMPLETE:String = "AssetLoaderEventComplete";
      
      public static const const_1323:String = "AssetLoaderEventProgress";
      
      public static const const_1318:String = "AssetLoaderEventUnload";
      
      public static const const_1346:String = "AssetLoaderEventStatus";
      
      public static const const_40:String = "AssetLoaderEventError";
      
      public static const const_1376:String = "AssetLoaderEventOpen";
       
      
      private var var_438:int;
      
      public function AssetLoaderEvent(param1:String, param2:int)
      {
         this.var_438 = param2;
         super(param1,false,false);
      }
      
      public function get status() : int
      {
         return this.var_438;
      }
      
      override public function clone() : Event
      {
         return new AssetLoaderEvent(type,this.var_438);
      }
      
      override public function toString() : String
      {
         return formatToString("AssetLoaderEvent","type","status");
      }
   }
}
