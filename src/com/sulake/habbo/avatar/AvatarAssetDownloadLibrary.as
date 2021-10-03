package com.sulake.habbo.avatar
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class AvatarAssetDownloadLibrary extends EventDispatcher
   {
      
      private static var name_4:int = 0;
      
      private static var var_1825:int = 1;
      
      private static var name_5:int = 2;
       
      
      private var _state:int;
      
      private var var_786:String;
      
      private var _revision:String;
      
      private var var_1210:String;
      
      private var _assets:IAssetLibrary;
      
      public function AvatarAssetDownloadLibrary(param1:String, param2:String, param3:String, param4:IAssetLibrary)
      {
         super();
         this._state = name_4;
         this._assets = param4;
         this.var_786 = String(param1);
         this._revision = String(param2);
         this.var_1210 = param3 + this.var_786 + ".swf";
         this.var_1210 = this.var_1210.replace("%revision%",this._revision);
         var _loc5_:AssetLibraryCollection = this._assets as AssetLibraryCollection;
         var _loc6_:IAssetLibrary = _loc5_.getAssetLibraryByUrl(this.var_786 + ".swf");
         if(_loc6_ != null)
         {
            Logger.log("[AvatarAssetDownloadLibrary] Already Downloaded by Core: " + this.var_786);
            this._state = name_5;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function startDownloading() : void
      {
         this._state = var_1825;
         var _loc1_:URLRequest = new URLRequest(this.var_1210);
         var _loc2_:LibraryLoader = new LibraryLoader();
         this._assets.loadFromFile(_loc2_,true);
         _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,this.onLoaderComplete);
         _loc2_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,this.onLoaderError);
         _loc2_.load(_loc1_);
      }
      
      private function onLoaderError(param1:Event) : void
      {
         Core.error("Could not load avatar asset library " + this.var_786 + " from URL " + this.var_1210,false,Core.const_1416);
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,this.onLoaderComplete);
         _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,this.onLoaderError);
         this._state = name_5;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function get libraryName() : String
      {
         return this.var_786;
      }
      
      public function get isReady() : Boolean
      {
         return this._state == name_5;
      }
      
      public function toString() : String
      {
         var _loc1_:String = this.var_786;
         return _loc1_ + (!!this.isReady ? "[x]" : "[ ]");
      }
   }
}
