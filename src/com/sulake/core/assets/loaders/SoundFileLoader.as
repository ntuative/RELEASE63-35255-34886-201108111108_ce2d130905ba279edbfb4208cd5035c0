package com.sulake.core.assets.loaders
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.net.URLRequest;
   
   public class SoundFileLoader extends AssetLoaderEventBroker implements IAssetLoader
   {
       
      
      protected var var_1162:String;
      
      protected var _type:String;
      
      protected var var_44:Sound;
      
      public function SoundFileLoader(param1:String, param2:URLRequest = null)
      {
         super();
         this.var_1162 = param2 == null ? "" : param2.url;
         this._type = param1;
         this.var_44 = new Sound(null,null);
         this.var_44.addEventListener(Event.ID3,loadEventHandler);
         this.var_44.addEventListener(Event.OPEN,loadEventHandler);
         this.var_44.addEventListener(Event.COMPLETE,loadEventHandler);
         this.var_44.addEventListener(IOErrorEvent.IO_ERROR,loadEventHandler);
         this.var_44.addEventListener(ProgressEvent.PROGRESS,loadEventHandler);
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
         return this.var_44;
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
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            this.var_44.removeEventListener(Event.ID3,loadEventHandler);
            this.var_44.removeEventListener(Event.OPEN,loadEventHandler);
            this.var_44.removeEventListener(Event.COMPLETE,loadEventHandler);
            this.var_44.removeEventListener(IOErrorEvent.IO_ERROR,loadEventHandler);
            this.var_44.removeEventListener(ProgressEvent.PROGRESS,loadEventHandler);
            this.var_44 = null;
            this._type = null;
            this.var_1162 = null;
            super.dispose();
         }
      }
      
      public function load(param1:URLRequest) : void
      {
         this.var_1162 = param1.url;
         this.var_44.load(param1,null);
      }
   }
}
