package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import flash.display.BitmapData;
   
   public class GraphicAsset implements IGraphicAsset
   {
       
      
      private var var_2497:String;
      
      private var var_3030:String;
      
      private var var_476:BitmapDataAsset;
      
      private var var_1486:Boolean;
      
      private var var_1485:Boolean;
      
      private var var_3029:Boolean;
      
      private var _offsetX:int;
      
      private var var_1327:int;
      
      private var var_232:int;
      
      private var _height:int;
      
      private var var_783:Boolean;
      
      public function GraphicAsset(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:Boolean = false)
      {
         super();
         this.var_2497 = param1;
         this.var_3030 = param2;
         var _loc9_:BitmapDataAsset = param3 as BitmapDataAsset;
         if(_loc9_ != null)
         {
            this.var_476 = _loc9_;
            this.var_783 = false;
         }
         else
         {
            this.var_476 = null;
            this.var_783 = true;
         }
         this.var_1486 = param4;
         this.var_1485 = param5;
         this._offsetX = param6;
         this.var_1327 = param7;
         this.var_3029 = param8;
      }
      
      public function dispose() : void
      {
         this.var_476 = null;
      }
      
      private function initialize() : void
      {
         var _loc1_:* = null;
         if(!this.var_783 && this.var_476 != null)
         {
            _loc1_ = this.var_476.content as BitmapData;
            if(_loc1_ != null)
            {
               this.var_232 = _loc1_.width;
               this._height = _loc1_.height;
            }
            this.var_783 = true;
         }
      }
      
      public function get flipV() : Boolean
      {
         return this.var_1485;
      }
      
      public function get flipH() : Boolean
      {
         return this.var_1486;
      }
      
      public function get width() : int
      {
         this.initialize();
         return this.var_232;
      }
      
      public function get height() : int
      {
         this.initialize();
         return this._height;
      }
      
      public function get assetName() : String
      {
         return this.var_2497;
      }
      
      public function get libraryAssetName() : String
      {
         return this.var_3030;
      }
      
      public function get asset() : IAsset
      {
         return this.var_476;
      }
      
      public function get usesPalette() : Boolean
      {
         return this.var_3029;
      }
      
      public function get offsetX() : int
      {
         if(!this.var_1486)
         {
            return this._offsetX;
         }
         return -(this.width + this._offsetX);
      }
      
      public function get offsetY() : int
      {
         if(!this.var_1485)
         {
            return this.var_1327;
         }
         return -(this.height + this.var_1327);
      }
      
      public function get originalOffsetX() : int
      {
         return this._offsetX;
      }
      
      public function get originalOffsetY() : int
      {
         return this.var_1327;
      }
   }
}
