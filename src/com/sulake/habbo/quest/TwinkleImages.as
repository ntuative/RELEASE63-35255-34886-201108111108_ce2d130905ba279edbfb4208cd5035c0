package com.sulake.habbo.quest
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IDisposable;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class TwinkleImages implements IDisposable
   {
      
      private static const const_1477:int = 6;
       
      
      private var var_50:HabboQuestEngine;
      
      private var _images:Dictionary;
      
      public function TwinkleImages(param1:HabboQuestEngine)
      {
         this._images = new Dictionary();
         super();
         this.var_50 = param1;
         var _loc2_:int = 1;
         while(_loc2_ <= const_1477)
         {
            this.loadImage(_loc2_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         this.var_50 = null;
         if(this._images)
         {
            for each(_loc1_ in this._images)
            {
               _loc1_.dispose();
            }
            this._images = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this.var_50 == null;
      }
      
      private function loadImage(param1:int) : void
      {
         PendingImage.retrievePreviewAsset(this.var_50,"ach_twinkle" + param1,this.onImageReady);
      }
      
      public function getImage(param1:int) : BitmapData
      {
         return this._images["ach_twinkle" + param1];
      }
      
      private function onImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:String = _loc2_.assetName;
         if(!_loc3_ || !this.var_50.assets)
         {
            return;
         }
         var _loc4_:BitmapDataAsset = this.var_50.assets.getAssetByName(_loc3_) as BitmapDataAsset;
         if(_loc4_ == null)
         {
            return;
         }
         Logger.log("GOT TWINKLE ASSET: " + _loc3_);
         this._images[_loc3_] = BitmapData(_loc4_.content);
      }
   }
}
