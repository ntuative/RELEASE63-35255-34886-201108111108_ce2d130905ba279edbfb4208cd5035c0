package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.events.EventDispatcher;
   import com.sulake.habbo.avatar.structure.IFigureData;
   import com.sulake.habbo.avatar.structure.figure.FigurePart;
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class AvatarAssetDownloadManager extends EventDispatcher
   {
       
      
      private var var_1323:Dictionary;
      
      private var _assets:IAssetLibrary;
      
      private var var_1087:Dictionary;
      
      private var var_601:Dictionary;
      
      private var _structure:AvatarStructure;
      
      private var var_2875:String;
      
      private var var_1322:String;
      
      private var var_2053:Boolean;
      
      private var var_1088:int = 3;
      
      private var var_483:AssetLoaderStruct;
      
      private var var_1086:Timer;
      
      private var var_1321:Array;
      
      private var var_863:Array;
      
      private var var_864:Array;
      
      private const const_2410:int = 100;
      
      private const const_2060:int = 2;
      
      public function AvatarAssetDownloadManager(param1:IAssetLibrary, param2:String, param3:String, param4:AvatarStructure)
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         super();
         this.var_1323 = new Dictionary();
         this._assets = param1;
         this._structure = param4;
         this.var_1087 = new Dictionary();
         this.var_2875 = param3;
         this.var_1322 = param2;
         this.var_601 = new Dictionary();
         this.var_1321 = [];
         this.var_863 = [];
         this.var_864 = [];
         var _loc5_:URLRequest = new URLRequest(param2);
         var _loc6_:IAsset = this._assets.getAssetByName("figuremap");
         if(_loc6_ == null)
         {
            this.var_483 = this._assets.loadAssetFromFile("figuremap",_loc5_,"text/xml");
            this.addMapLoaderEventListeners();
         }
         else
         {
            _loc7_ = this._assets.getAssetByName("figuremap") as XmlAsset;
            _loc8_ = (_loc7_.content as XML).copy();
            this.loadFigureMapData(_loc8_);
         }
         this.var_1086 = new Timer(this.const_2410,1);
         this.var_1086.addEventListener(TimerEvent.TIMER_COMPLETE,this.onNextDownloadTimeout);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.var_1323 = null;
         this._assets = null;
         this.var_1087 = null;
         this.var_601 = null;
         this._structure = null;
         this.var_863 = null;
         this.var_1321 = null;
         if(this.var_1086)
         {
            this.var_1086.stop();
            this.var_1086 = null;
         }
         if(this.var_483)
         {
            this.removeMapLoaderEventListeners();
            this.var_483 = null;
         }
      }
      
      private function addMapLoaderEventListeners() : void
      {
         if(this.var_483)
         {
            this.var_483.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.onConfigurationComplete);
            this.var_483.addEventListener(AssetLoaderEvent.const_40,this.onConfigurationError);
         }
      }
      
      private function removeMapLoaderEventListeners() : void
      {
         if(this.var_483)
         {
            this.var_483.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.onConfigurationComplete);
            this.var_483.removeEventListener(AssetLoaderEvent.const_40,this.onConfigurationError);
         }
      }
      
      private function onConfigurationError(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         --this.var_1088;
         if(this.var_1088 <= 0)
         {
            HabboWebTools.logEventLog("Figuremap download error " + this.var_1322);
            Logger.log("AVATAR ASSET ERROR: Could not download figuremap.xml.");
         }
         else
         {
            Logger.log("Could not download figuremap.xml. Retries left: " + this.var_1088);
            if(this.var_1322.indexOf("?") > 0)
            {
               _loc2_ = this.var_1322 + "&retry=" + this.var_1088;
            }
            else
            {
               _loc2_ = this.var_1322 + "?retry=" + this.var_1088;
            }
            this.removeMapLoaderEventListeners();
            _loc3_ = new URLRequest(_loc2_);
            this.var_483 = this._assets.loadAssetFromFile("figuremap",_loc3_,"text/xml");
            this.addMapLoaderEventListeners();
         }
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         var data:XML = null;
         var event:Event = param1;
         var loaderStruct:AssetLoaderStruct = event.target as AssetLoaderStruct;
         if(loaderStruct == null)
         {
            return;
         }
         try
         {
            data = new XML(loaderStruct.assetLoader.content as String);
         }
         catch(e:Error)
         {
            Logger.log("[AvatarAssetDownloadManager] Error: " + e.message);
            return;
         }
         this.loadFigureMapData(data);
      }
      
      private function loadFigureMapData(param1:XML) : void
      {
         var _loc2_:* = null;
         if(param1 == null)
         {
            Logger.log("[AvatarAssetDownloadManager] XML error: " + param1 + " not valid XML");
            return;
         }
         if(param1.toString() == "")
         {
            Logger.log("[AvatarAssetDownloadManager] XML error: " + param1 + " is EMPTY!");
            return;
         }
         this.generateMap(param1);
         this.var_2053 = true;
         for each(_loc2_ in this.var_1321)
         {
            this.loadFigureSetData(_loc2_[0],_loc2_[1]);
         }
         this.var_1321 = [];
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function generateMap(param1:XML) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         for each(_loc2_ in param1.lib)
         {
            _loc3_ = new AvatarAssetDownloadLibrary(_loc2_.@id,_loc2_.@revision,this.var_2875,this._assets);
            _loc3_.addEventListener(Event.COMPLETE,this.libraryComplete);
            for each(_loc4_ in _loc2_.part)
            {
               _loc5_ = _loc4_.@type + ":" + _loc4_.@id;
               _loc6_ = this.var_1323[_loc5_];
               if(_loc6_ == null)
               {
                  _loc6_ = [];
               }
               _loc6_.push(_loc3_);
               this.var_1323[_loc5_] = _loc6_;
            }
         }
      }
      
      public function isReady(param1:IAvatarFigureContainer) : Boolean
      {
         if(!this.var_2053)
         {
            return false;
         }
         var _loc2_:Array = this.getLibsToDownload(param1);
         return _loc2_.length == 0;
      }
      
      public function loadFigureSetData(param1:IAvatarFigureContainer, param2:IAvatarImageListener) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(!this.var_2053)
         {
            this.var_1321.push([param1,param2]);
            return;
         }
         var _loc3_:String = param1.getFigureString();
         var _loc4_:Array = this.getLibsToDownload(param1);
         if(_loc4_.length > 0)
         {
            if(param2 && !param2.disposed)
            {
               _loc6_ = this.var_601[_loc3_];
               if(_loc6_ == null)
               {
                  _loc6_ = [];
               }
               _loc6_.push(param2);
               this.var_601[_loc3_] = _loc6_;
            }
            this.var_1087[_loc3_] = _loc4_;
            for each(_loc5_ in _loc4_)
            {
               this.addToQueue(_loc5_);
            }
         }
         else if(param2 != null && !param2.disposed)
         {
            param2.avatarImageReady(_loc3_);
         }
      }
      
      private function libraryComplete(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc2_:* = [];
         for(_loc3_ in this.var_1087)
         {
            _loc7_ = true;
            _loc4_ = this.var_1087[_loc3_];
            for each(_loc8_ in _loc4_)
            {
               if(!_loc8_.isReady)
               {
                  _loc7_ = false;
                  break;
               }
            }
            if(_loc7_)
            {
               _loc2_.push(_loc3_);
               _loc9_ = this.var_601[_loc3_];
               for each(_loc10_ in _loc9_)
               {
                  if(_loc10_ != null && !_loc10_.disposed)
                  {
                     _loc10_.avatarImageReady(_loc3_);
                  }
               }
               delete this.var_601[_loc3_];
            }
         }
         for each(_loc3_ in _loc2_)
         {
            delete this.var_1087[_loc3_];
         }
         while(_loc6_ < this.var_864.length)
         {
            _loc5_ = this.var_864[_loc6_];
            if(_loc5_.libraryName == (param1.target as AvatarAssetDownloadLibrary).libraryName)
            {
               this.var_864.splice(_loc6_,1);
            }
            _loc6_++;
         }
         this.var_1086.start();
      }
      
      private function getLibsToDownload(param1:IAvatarFigureContainer) : Array
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc2_:* = [];
         if(!this._structure)
         {
            return _loc2_;
         }
         if(!param1)
         {
            return _loc2_;
         }
         var _loc3_:IFigureData = this._structure.figureData;
         if(!_loc3_)
         {
            return _loc2_;
         }
         var _loc4_:Array = param1.getPartTypeIds();
         for each(_loc5_ in _loc4_)
         {
            _loc6_ = _loc3_.getSetType(_loc5_);
            if(_loc6_)
            {
               _loc7_ = param1.getPartSetId(_loc5_);
               _loc8_ = _loc6_.getPartSet(_loc7_);
               if(_loc8_)
               {
                  for each(_loc9_ in _loc8_.parts)
                  {
                     _loc10_ = _loc9_.type + ":" + _loc9_.id;
                     _loc11_ = this.var_1323[_loc10_];
                     if(_loc11_ != null)
                     {
                        for each(_loc12_ in _loc11_)
                        {
                           if(_loc12_ != null)
                           {
                              if(!_loc12_.isReady)
                              {
                                 if(_loc2_.indexOf(_loc12_) == -1)
                                 {
                                    _loc2_.push(_loc12_);
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      private function processPending() : void
      {
         var _loc1_:* = null;
         while(this.var_863.length > 0 && this.var_864.length < this.const_2060)
         {
            _loc1_ = this.var_863[0];
            _loc1_.startDownloading();
            this.var_864.push(this.var_863.shift());
         }
      }
      
      private function addToQueue(param1:AvatarAssetDownloadLibrary) : void
      {
         if(!param1.isReady && this.var_863.indexOf(param1) == -1 && this.var_864.indexOf(param1) == -1)
         {
            this.var_863.push(param1);
            this.processPending();
         }
      }
      
      private function onNextDownloadTimeout(param1:Event = null) : void
      {
         this.processPending();
      }
   }
}
