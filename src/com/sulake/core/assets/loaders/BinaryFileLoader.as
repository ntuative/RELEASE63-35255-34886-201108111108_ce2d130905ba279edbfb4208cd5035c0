package com.sulake.core.assets.loaders
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class BinaryFileLoader extends AssetLoaderEventBroker implements IAssetLoader
   {
       
      
      protected var var_1162:String;
      
      protected var _type:String;
      
      protected var _data:String;
      
      protected var var_44:URLLoader;
      
      public function BinaryFileLoader(param1:String, param2:URLRequest = null)
      {
         super();
         this.var_1162 = param2 == null ? "" : param2.url;
         this._type = param1;
         this.var_44 = new URLLoader();
         this.var_44.addEventListener(Event.COMPLETE,loadEventHandler);
         this.var_44.addEventListener(Event.UNLOAD,loadEventHandler);
         this.var_44.addEventListener(HTTPStatusEvent.HTTP_STATUS,loadEventHandler);
         this.var_44.addEventListener(ProgressEvent.PROGRESS,loadEventHandler);
         this.var_44.addEventListener(IOErrorEvent.IO_ERROR,loadEventHandler);
         this.var_44.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadEventHandler);
         if(param2 != null)
         {
            this.load(param2);
         }
      }
      
      public function get url() : String
      {
         return this.var_1162;
      }
      
      public function get ready() : Boolean
      {
         return this.bytesTotal > 0 ? this.bytesTotal == this.bytesLoaded : false;
      }
      
      public function get content() : Object
      {
         return !!this._data ? this._data : (!!this.var_44 ? this.var_44.data : null);
      }
      
      public function get mimeType() : String
      {
         return this._type;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!this.var_44 ? uint(this.var_44.bytesLoaded) : uint(0);
      }
      
      public function get bytesTotal() : uint
      {
         return !!this.var_44 ? uint(this.var_44.bytesTotal) : uint(0);
      }
      
      public function load(param1:URLRequest) : void
      {
         this.var_1162 = param1.url;
         this._data = null;
         var_361 = 0;
         this.var_44.dataFormat = this._type == "application/octet-stream" ? "null" : URLLoaderDataFormat.TEXT;
         this.var_44.load(param1);
      }
      
      override protected function retry() : Boolean
      {
         if(!_disposed)
         {
            if(++var_361 < var_3089)
            {
               try
               {
                  this.var_44.close();
               }
               catch(e:Error)
               {
               }
               this.var_44.load(new URLRequest(this.var_1162 + (this.var_1162.indexOf("?") == -1 ? "?" : "&") + "retry=" + var_361));
               return true;
            }
         }
         return false;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            this.var_44.removeEventListener(Event.COMPLETE,loadEventHandler);
            this.var_44.removeEventListener(Event.UNLOAD,loadEventHandler);
            this.var_44.removeEventListener(HTTPStatusEvent.HTTP_STATUS,loadEventHandler);
            this.var_44.removeEventListener(ProgressEvent.PROGRESS,loadEventHandler);
            this.var_44.removeEventListener(IOErrorEvent.IO_ERROR,loadEventHandler);
            this.var_44.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadEventHandler);
            try
            {
               this.var_44.close();
            }
            catch(e:Error)
            {
            }
            this.var_44 = null;
            this._type = null;
            this._data = null;
            this.var_1162 = null;
         }
      }
      
      private function timerEventHandler(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.target as Timer;
         if(_loc2_)
         {
            _loc2_.stop();
            _loc2_.removeEventListener(TimerEvent.TIMER,this.timerEventHandler);
         }
         if(!_disposed)
         {
            loadEventHandler(new Event(Event.COMPLETE));
         }
      }
   }
}
