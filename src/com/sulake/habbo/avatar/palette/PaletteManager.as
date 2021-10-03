package com.sulake.habbo.avatar.palette
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.UnknownAsset;
   import com.sulake.core.assets.XmlAsset;
   import flash.utils.ByteArray;
   
   public class PaletteManager
   {
       
      
      private var var_300:Array;
      
      private var _assets:AssetLibraryCollection;
      
      public function PaletteManager(param1:AssetLibraryCollection)
      {
         super();
         this.var_300 = new Array();
         this._assets = param1;
      }
      
      public function dispose() : void
      {
         this._assets = null;
         this.var_300 = null;
      }
      
      public function reset() : void
      {
         this.init();
      }
      
      public function init() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc1_:Array = this._assets.getAssetsByName("petPalettesConfiguration");
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.content as XML;
               for each(_loc4_ in _loc3_.palette)
               {
                  _loc5_ = parseInt(_loc4_.@id);
                  _loc6_ = String(_loc4_.@asset);
                  _loc7_ = this._assets.getAssetByName(_loc6_) as UnknownAsset;
                  if(_loc7_ != null)
                  {
                     if(_loc7_.content is Class)
                     {
                        _loc8_ = new _loc7_.content() as ByteArray;
                     }
                     else
                     {
                        _loc8_ = _loc7_.content as ByteArray;
                     }
                     _loc9_ = new PaletteMap(_loc8_);
                     this.var_300[_loc5_] = _loc9_;
                  }
               }
            }
         }
      }
      
      public function getPalette(param1:int) : PaletteMap
      {
         if(this.var_300.length <= param1)
         {
            return null;
         }
         return this.var_300[param1];
      }
   }
}
