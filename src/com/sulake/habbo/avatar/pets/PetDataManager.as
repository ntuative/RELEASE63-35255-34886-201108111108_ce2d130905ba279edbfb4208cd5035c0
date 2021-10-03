package com.sulake.habbo.avatar.pets
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.LibraryLoaderEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.AvatarRenderManager;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class PetDataManager implements IPetDataManager, IDisposable
   {
       
      
      private var var_499:Map;
      
      private var _assets:AssetLibraryCollection;
      
      private var var_601:Array;
      
      private var var_314:Array;
      
      private var var_175:AvatarRenderManager;
      
      private var var_734:Map;
      
      private var var_1684:Array;
      
      private var _disposed:Boolean = false;
      
      public function PetDataManager(param1:AvatarRenderManager, param2:AssetLibraryCollection)
      {
         super();
         this.var_499 = new Map();
         this.var_601 = [];
         this.var_175 = param1;
         this.var_314 = [];
         this._assets = param2;
         this.var_734 = new Map();
         this.var_1684 = [];
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(this._disposed)
         {
            return;
         }
         this._assets = null;
         this.var_175 = null;
         this.var_601 = null;
         this.var_499.dispose();
         this.var_499 = null;
         if(this.var_314 != null)
         {
            for each(_loc1_ in this.var_314)
            {
               _loc1_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,this.onLoaderComplete);
               _loc1_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,this.onContentLoadError);
            }
         }
         this.var_314 = null;
         this.var_734.dispose();
         this.var_734 = null;
         this.var_1684 = null;
         this._disposed = true;
      }
      
      public function reset() : void
      {
         this.init();
      }
      
      public function init() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc1_:Array = this._assets.getAssetsByName("petData");
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.content as XML;
               _loc4_ = int(_loc3_.@species);
               if(this.var_499.getValue(_loc4_) == null)
               {
                  this.var_499.add(_loc4_,new PetData(_loc3_));
               }
            }
         }
      }
      
      public function removeListener(param1:IPetDataListener = null) : void
      {
         if(param1 == null || this.var_601 == null)
         {
            return;
         }
         var _loc2_:int = this.var_601.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.var_601.splice(_loc2_,1);
         }
      }
      
      private function notifyListeners() : void
      {
         var _loc1_:* = null;
         while(this.var_601.length > 0)
         {
            _loc1_ = this.var_601.pop() as IPetDataListener;
            if(_loc1_ != null && !_loc1_.disposed)
            {
               _loc1_.petDataReady();
            }
         }
      }
      
      public function getPetData(param1:int, param2:IPetDataListener = null) : IPetData
      {
         var _loc3_:IPetData = this.var_499.getValue(param1) as IPetData;
         if(_loc3_ == null)
         {
            this.assetsReady(param1,AvatarScaleType.const_61,param2);
         }
         return _loc3_;
      }
      
      public function createPetFigureString(param1:int, param2:int, param3:uint) : String
      {
         if(this.disposed)
         {
            return "";
         }
         var _loc4_:PetData = this.var_499.getValue(param1);
         if(_loc4_ == null)
         {
            Logger.log("Could not find Pet Data: " + param1);
            return "";
         }
         var _loc5_:Breed = _loc4_.findBreed(param2);
         if(_loc5_ == null)
         {
            return "";
         }
         var _loc6_:String = _loc5_.avatarFigureString;
         if(_loc6_ == null)
         {
            return "";
         }
         var _loc7_:PetColor = _loc4_.findColor(param3);
         if(_loc7_ == null)
         {
            return _loc6_;
         }
         var _loc8_:Array = _loc6_.split(".");
         return _loc8_.join(_loc7_.figurePartPaletteColorId + ".");
      }
      
      public function populateFigureData(param1:XML) : void
      {
         var targetSets:Array = null;
         var targetPalette:XML = null;
         var speciesKeys:Array = null;
         var key:int = 0;
         var petData:PetData = null;
         var petColorData:PetColor = null;
         var breed:Breed = null;
         var colorValue:String = null;
         var color:XML = null;
         var colorId:int = 0;
         var avatarFigureString:String = null;
         var targetSetName:String = null;
         var figureTargetSet:XML = null;
         var figurePart:XML = null;
         var setId:int = 0;
         var figureSet:XML = null;
         var figureData:XML = param1;
         targetSets = ["pbd","phd","ptl"];
         targetPalette = figureData.colors.palette.(@id == "1")[0];
         speciesKeys = this.var_499.getKeys();
         for each(key in speciesKeys)
         {
            petData = this.var_499.getValue(key);
            if(petData != null)
            {
               for each(petColorData in petData.colors)
               {
                  colorValue = petColorData.rgb.toString(16);
                  color = targetPalette.color.(text() == colorValue)[0];
                  if(color == null)
                  {
                     colorId = targetPalette.children().length() + 1;
                     color = <color club="0" selectable="1">{colorValue}</color>;
                     color.@id = colorId;
                     color.@index = colorId;
                     targetPalette.appendChild(color);
                  }
                  petColorData.figurePartPaletteColorId = parseInt(color.@id);
               }
               for each(breed in petData.breeds)
               {
                  avatarFigureString = "";
                  for each(targetSetName in targetSets)
                  {
                     figureTargetSet = figureData.sets.settype.(@type == targetSetName)[0];
                     if(figureTargetSet == null)
                     {
                        Logger.log("Could not find Figure Target Set for populating Pet Data: " + targetSetName);
                     }
                     else
                     {
                        figurePart = figureTargetSet.var_519.part.(@id == petData.species).(hasOwnProperty("palettemapid") && @palettemapid == breed.patternId)[0];
                        if(figurePart == null)
                        {
                        }
                        setId = figureTargetSet.children().length() + 1;
                        figureSet = <set gender="U" club="0" colorable="1" selectable="1"/>;
                        figureSet.@id = setId;
                        figurePart = <part colorable="1" colorindex="1" index="1"/>;
                        figurePart.@id = petData.species;
                        figurePart.@breed = breed.id;
                        figurePart.@type = targetSetName;
                        if(breed.patternId >= 0)
                        {
                           figurePart.@palettemapid = breed.patternId;
                        }
                        figureSet.appendChild(figurePart);
                        figureTargetSet.appendChild(figureSet);
                        avatarFigureString += targetSetName + "-" + setId + "-" + ".";
                     }
                  }
                  breed.avatarFigureString = avatarFigureString;
               }
            }
         }
      }
      
      public function get species() : Map
      {
         return this.var_499;
      }
      
      public function assetsReady(param1:int, param2:String, param3:IPetDataListener = null) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = [];
         switch(param1)
         {
            case 0:
               _loc4_.push("h_dog.swf");
               break;
            case 1:
               _loc4_.push("h_dog.swf");
               _loc4_.push("h_cat.swf");
               break;
            case 2:
               _loc4_.push("h_dog.swf");
               _loc4_.push("h_croco.swf");
               break;
            case 3:
               _loc4_.push("h_terrier.swf");
               break;
            case 4:
               _loc4_.push("h_bear.swf");
               break;
            case 5:
               _loc4_.push("h_pig.swf");
               break;
            case 6:
               _loc4_.push("h_lion.swf");
               break;
            case 7:
               _loc4_.push("h_rhino.swf");
         }
         if(param2 == AvatarScaleType.const_112)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc4_[_loc5_] = "s" + _loc4_[_loc5_];
               _loc5_++;
            }
         }
         _loc4_.push("pets_palettes.swf");
         var _loc7_:Boolean = true;
         for each(_loc6_ in _loc4_)
         {
            if(this.var_1684.indexOf(_loc6_) == -1)
            {
               _loc7_ = false;
               if(this.var_734.getValue(_loc6_) == null)
               {
                  _loc8_ = new LibraryLoader();
                  this._assets.loadFromFile(_loc8_);
                  _loc8_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,this.onLoaderComplete);
                  _loc8_.addEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,this.onContentLoadError);
                  _loc8_.load(new URLRequest(_loc6_));
                  this.var_314.push(_loc8_);
                  this.var_734.add(_loc6_,_loc8_);
                  if(param3 != null && this.var_601.indexOf(param3) == -1)
                  {
                     this.var_601.push(param3);
                  }
               }
            }
         }
         return _loc7_;
      }
      
      private function unregisterLoadingAssets(param1:LibraryLoader) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.var_734.getKeys())
         {
            _loc5_ = this.var_734.getValue(_loc3_);
            if(param1 == _loc5_)
            {
               _loc2_.push(_loc3_);
            }
         }
         for each(_loc4_ in _loc2_)
         {
            this.var_734.remove(_loc4_);
         }
      }
      
      private function onContentLoadError(param1:Event) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,this.onLoaderComplete);
         _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,this.onContentLoadError);
         var _loc3_:int = this.var_314.indexOf(_loc2_);
         if(_loc3_ != -1)
         {
            this.var_314.splice(_loc3_,1);
            this.unregisterLoadingAssets(_loc2_);
         }
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_COMPLETE,this.onLoaderComplete);
         _loc2_.removeEventListener(LibraryLoaderEvent.LIBRARY_LOADER_EVENT_ERROR,this.onContentLoadError);
         this.var_1684.push(_loc2_.url);
         var _loc3_:int = this.var_314.indexOf(_loc2_);
         if(_loc3_ >= 0)
         {
            this.var_314.splice(_loc3_,1);
            this.unregisterLoadingAssets(_loc2_);
         }
         if(this.var_314.length == 0)
         {
            this.var_175.resetPetData();
            this.notifyListeners();
         }
      }
   }
}
