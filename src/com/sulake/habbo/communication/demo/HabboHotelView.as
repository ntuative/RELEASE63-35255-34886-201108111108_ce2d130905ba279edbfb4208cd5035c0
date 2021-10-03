package com.sulake.habbo.communication.demo
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IDesktopWindow;
   import com.sulake.core.window.components.IDisplayObjectWrapper;
   import com.sulake.habbo.communication.enum.HabboHotelViewEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   
   public class HabboHotelView implements IDisposable
   {
       
      
      private var _window:IDisplayObjectWrapper;
      
      private var var_1114:IDesktopWindow;
      
      private var _disposed:Boolean = false;
      
      private var var_1286:Function;
      
      private var var_1285:Function;
      
      private var var_826:IAssetLibrary;
      
      private var var_1287:uint = 0;
      
      private var _events:IEventDispatcher;
      
      private var var_2785:Boolean;
      
      public function HabboHotelView(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IEventDispatcher, param4:Boolean = true)
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         super();
         this.var_826 = param2;
         this._events = param3;
         this.var_1114 = param1.getDesktop(0);
         this.var_2785 = param4;
         var _loc7_:Array = new Array();
         _loc5_ = param2.getAssetByName("hotel_view_window");
         if(_loc5_ == null)
         {
            throw new Error("Missing asset; hotel view window layout!");
         }
         _loc6_ = XmlAsset(_loc5_).content as XML;
         if(_loc6_)
         {
            this._window = param1.buildFromXML(_loc6_,0) as IDisplayObjectWrapper;
            this._window.rectangle = this._window.desktop.rectangle;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            if(this._window)
            {
               this._window.dispose();
               this._window = null;
            }
            this._disposed = true;
            this.var_1286 = null;
            this.var_1285 = null;
            this.var_1114 = null;
            this._events = null;
         }
      }
      
      public function loadHotelViewImage(param1:String, param2:Function = null) : void
      {
         var _loc3_:AssetLoaderStruct = this.var_826.loadAssetFromFile("hotelview_png",new URLRequest(param1),"image/png");
         if(param2 == null)
         {
            _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.hotelViewLoadedHandler);
            _loc3_.addEventListener(AssetLoaderEvent.const_40,this.hotelViewLoadedHandler);
         }
         else
         {
            this.var_1285 = param2;
            _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.hotelViewLoadedCallbackHandler);
            _loc3_.addEventListener(AssetLoaderEvent.const_40,this.hotelViewLoadedCallbackHandler);
         }
         ++this.var_1287;
      }
      
      private function hotelViewLoadedHandler(param1:AssetLoaderEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:IAsset = this.var_826.getAssetByName(_loc2_.assetName);
         if(param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
         {
            _loc4_ = BitmapDataAsset(_loc3_).content as BitmapData;
            if(this._window && !this._window.disposed)
            {
               _loc5_ = this._window as IDisplayObjectWrapper;
               if(_loc5_ != null)
               {
                  _loc5_.width = _loc4_.width;
                  _loc5_.height = _loc4_.height;
                  _loc5_.setDisplayObject(new Bitmap(_loc4_));
               }
            }
         }
         if(!this.var_2785)
         {
            this.hide();
         }
         _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.hotelViewLoadedHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_40,this.hotelViewLoadedHandler);
      }
      
      private function hotelViewLoadedCallbackHandler(param1:AssetLoaderEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:IAsset = this.var_826.getAssetByName(_loc2_.assetName);
         if(param1.type == AssetLoaderEvent.const_40)
         {
            if(this._events != null)
            {
               this._events.dispatchEvent(new Event(HabboHotelViewEvent.const_69));
            }
         }
         else if(param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
         {
            if(this._events != null)
            {
               this._events.dispatchEvent(new Event(HabboHotelViewEvent.const_673));
            }
            _loc4_ = BitmapDataAsset(_loc3_).content as BitmapData;
            if(this.var_1285 != null)
            {
               this.var_1285(_loc4_);
               this.var_1285 = null;
            }
         }
         _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.hotelViewLoadedCallbackHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_40,this.hotelViewLoadedCallbackHandler);
      }
      
      public function loadBannerImage(param1:String, param2:Function) : void
      {
         var _loc3_:AssetLoaderStruct = this.var_826.loadAssetFromFile("hotel_view_banner_" + this.var_1287,new URLRequest(param1),"image/png");
         if(param2 == null)
         {
            _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.bannerLoadedHandler);
            _loc3_.addEventListener(AssetLoaderEvent.const_40,this.bannerLoadedHandler);
         }
         else
         {
            if(this._events != null)
            {
               this._events.dispatchEvent(new Event(HabboHotelViewEvent.const_839));
            }
            this.var_1286 = param2;
            _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.bannerLoadedCallbackHandler);
            _loc3_.addEventListener(AssetLoaderEvent.const_40,this.bannerLoadedCallbackHandler);
         }
         ++this.var_1287;
      }
      
      private function bannerLoadedHandler(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:IAsset = this.var_826.getAssetByName(_loc2_.assetName);
         _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.bannerLoadedHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_40,this.bannerLoadedHandler);
      }
      
      private function bannerLoadedCallbackHandler(param1:AssetLoaderEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         var _loc3_:IAsset = this.var_826.getAssetByName(_loc2_.assetName);
         if(param1.type == AssetLoaderEvent.const_40)
         {
            if(this._events != null)
            {
               this._events.dispatchEvent(new Event(HabboHotelViewEvent.const_69));
            }
         }
         else if(param1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE)
         {
            if(this._events != null)
            {
               this._events.dispatchEvent(new Event(HabboHotelViewEvent.const_673));
            }
            _loc4_ = BitmapDataAsset(_loc3_).content as BitmapData;
            if(this.var_1286 != null)
            {
               this.var_1286(_loc4_);
               this.var_1286 = null;
            }
         }
         _loc2_.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.bannerLoadedCallbackHandler);
         _loc2_.removeEventListener(AssetLoaderEvent.const_40,this.bannerLoadedCallbackHandler);
      }
      
      public function show() : void
      {
         if(this._window && !this._window.disposed)
         {
            this.var_1114.addChildAt(this._window,0);
         }
      }
      
      public function hide() : void
      {
         if(this._window && !this._window.disposed)
         {
            this.var_1114.removeChild(this._window);
         }
      }
   }
}
