package com.sulake.habbo.session.product
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class ProductDataParser extends EventDispatcher
   {
      
      public static const const_129:String = "ready";
       
      
      private var var_1261:Dictionary;
      
      private var var_826:AssetLibrary;
      
      public function ProductDataParser(param1:String, param2:Dictionary)
      {
         super();
         this.var_1261 = param2;
         this.var_826 = new AssetLibrary("ProductDataParserAssetLib");
         var _loc3_:AssetLoaderStruct = this.var_826.loadAssetFromFile(param1,new URLRequest(param1),"text/plain");
         _loc3_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE,this.parseProductsData);
         _loc3_.addEventListener(AssetLoaderEvent.const_40,this.productsDataError);
      }
      
      public function dispose() : void
      {
         if(this.var_826)
         {
            this.var_826.dispose();
            this.var_826 = null;
         }
         this.var_1261 = null;
      }
      
      private function parseProductsData(param1:Event) : void
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.assetLoader == null || _loc2_.assetLoader.content == null)
         {
            return;
         }
         var _loc3_:String = _loc2_.assetLoader.content as String;
         var _loc4_:Array = new Array();
         var _loc5_:RegExp = /\n\r{1,}|\n{1,}|\r{1,}/mg;
         var _loc6_:RegExp = /^\s+|\s+$/g;
         var _loc7_:RegExp = /\[+?((.)*?)\]/g;
         _loc3_ = _loc3_.replace(/"{1,}/mg,"");
         var _loc8_:Array = _loc3_.split(_loc5_);
         var _loc9_:int = 0;
         for each(_loc10_ in _loc8_)
         {
            _loc11_ = _loc10_.match(_loc7_);
            for each(_loc12_ in _loc11_)
            {
               _loc12_ = _loc12_.replace(/\[{1,}/mg,"");
               _loc12_ = _loc12_.replace(/\]{1,}/mg,"");
               _loc13_ = _loc12_.split(",");
               _loc14_ = _loc13_.shift();
               _loc15_ = _loc13_.shift();
               _loc16_ = _loc13_.join(",");
               _loc17_ = new ProductData(_loc14_,_loc15_,_loc16_);
               this.var_1261[_loc14_] = _loc17_;
            }
            _loc9_++;
         }
         dispatchEvent(new Event(const_129));
      }
      
      private function productsDataError(param1:AssetLoaderEvent) : void
      {
         HabboWebTools.logEventLog("productdata download error " + param1.status);
      }
   }
}
