package com.sulake.habbo.inventory.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ThumbListManager
   {
       
      
      private var _assets:IAssetLibrary;
      
      private var var_1502:IThumbListDataProvider;
      
      private var var_243:int;
      
      private var var_654:int = 1;
      
      private var var_29:BitmapData;
      
      private var var_3143:int;
      
      private var var_3142:int;
      
      private var var_1222:int;
      
      private var var_1003:int;
      
      private var _thumbWidth:int;
      
      private var var_105:int;
      
      private var var_653:BitmapData;
      
      private var _itemBgImageSelected:BitmapData;
      
      public function ThumbListManager(param1:IAssetLibrary, param2:IThumbListDataProvider, param3:String, param4:String, param5:int, param6:int)
      {
         super();
         this._assets = param1;
         this.var_1502 = param2;
         var _loc7_:BitmapDataAsset = BitmapDataAsset(this._assets.getAssetByName(param3));
         if(_loc7_ != null)
         {
            this.var_653 = BitmapData(_loc7_.content);
         }
         var _loc8_:BitmapDataAsset = BitmapDataAsset(this._assets.getAssetByName(param4));
         if(_loc8_ != null)
         {
            this._itemBgImageSelected = BitmapData(_loc8_.content);
         }
         this._thumbWidth = this.var_653.width;
         this.var_105 = this.var_653.height;
         this.var_1222 = param5;
         this.var_1003 = param6;
         this.var_243 = Math.floor(this.var_1222 / this._thumbWidth);
         this.var_29 = new BitmapData(this.var_1222,this.var_1003);
      }
      
      public function dispose() : void
      {
         this.var_1502 = null;
         this.var_29 = null;
      }
      
      public function updateImageFromList() : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         this.var_654 = this.resolveRowCountFromList();
         if(this.var_654 == 0)
         {
            this.var_29 = new BitmapData(this.var_1222,this.var_1003);
            return;
         }
         this.var_29 = new BitmapData(Math.max(this.var_243 * this._thumbWidth,this.var_1222),Math.max(this.var_654 * this.var_105,this.var_1003),true,16777215);
         this.var_29.fillRect(this.var_29.rect,4294967295);
         var _loc1_:int = 0;
         var _loc2_:Array = this.getList();
         var _loc3_:int = 0;
         while(_loc3_ < this.var_654)
         {
            _loc4_ = 0;
            while(_loc4_ < this.var_243)
            {
               if(_loc1_ < _loc2_.length)
               {
                  _loc5_ = _loc2_[_loc1_];
                  if(_loc5_ != null)
                  {
                     _loc6_ = this.createThumbImage(_loc5_.iconImage,_loc5_.isSelected);
                     this.var_29.copyPixels(_loc6_,_loc6_.rect,new Point(_loc4_ * this._thumbWidth,_loc3_ * this.var_105),null,null,true);
                  }
                  _loc1_++;
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function addItemAsFirst(param1:IThumbListDrawableItem) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Point = this.resolveLastItemGridLoc();
         if(_loc3_.x == this.var_243 && this.var_29.height < _loc3_.y * this.var_105)
         {
            _loc2_ = new BitmapData(this.var_29.width,this.var_29.height + this.var_105);
         }
         else
         {
            _loc2_ = new BitmapData(this.var_29.width,this.var_29.height);
         }
         var _loc5_:BitmapData = this.createThumbImage(param1.iconImage,param1.isSelected);
         _loc2_.copyPixels(_loc5_,_loc5_.rect,new Point(0,0),null,null,true);
         _loc4_ = new Rectangle(0,0,this._thumbWidth * (this.var_243 - 1),this.var_105);
         _loc2_.copyPixels(this.var_29,_loc4_,new Point(this._thumbWidth,0),null,null,true);
         _loc4_ = new Rectangle(this._thumbWidth * (this.var_243 - 1),0,this._thumbWidth,this.var_29.height);
         _loc2_.copyPixels(this.var_29,_loc4_,new Point(0,this.var_105),null,null,true);
         _loc4_ = new Rectangle(0,this.var_105,this._thumbWidth * (this.var_243 - 1),this.var_29.height - this.var_105);
         _loc2_.copyPixels(this.var_29,_loc4_,new Point(this._thumbWidth,this.var_105),null,null,true);
         this.var_29 = _loc2_;
      }
      
      public function replaceItemImage(param1:int, param2:IThumbListDrawableItem) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc3_:Point = this.resolveGridLocationFromIndex(param1);
         var _loc4_:Point = new Point(_loc3_.x * this._thumbWidth,_loc3_.y * this.var_105);
         var _loc5_:BitmapData = this.createThumbImage(param2.iconImage,param2.isSelected);
         this.var_29.copyPixels(_loc5_,_loc5_.rect,_loc4_,null,null,true);
      }
      
      public function getListImage() : BitmapData
      {
         return this.var_29;
      }
      
      public function removeItemInIndex(param1:int) : void
      {
         var _loc2_:Point = this.resolveGridLocationFromIndex(param1);
         this.removeItemInImage(_loc2_);
      }
      
      public function removeItemInLocation(param1:Point) : void
      {
         var _loc2_:Point = this.resolveGridLocationFromImage(param1);
         this.removeItemInImage(_loc2_);
      }
      
      public function updateListItem(param1:int) : void
      {
         var _loc2_:IThumbListDrawableItem = this.getDrawableItem(param1);
         this.replaceItemImage(param1,_loc2_);
      }
      
      private function getList() : Array
      {
         var _loc1_:* = null;
         if(this.var_1502 != null)
         {
            _loc1_ = this.var_1502.getDrawableList();
         }
         return !!_loc1_ ? _loc1_ : new Array();
      }
      
      private function getDrawableItem(param1:int) : IThumbListDrawableItem
      {
         var _loc2_:Array = this.getList();
         if(param1 >= 0 && param1 < _loc2_.length)
         {
            return _loc2_[param1] as IThumbListDrawableItem;
         }
         return null;
      }
      
      private function resolveRowCountFromList() : int
      {
         var _loc1_:Array = this.getList();
         return int(Math.ceil(_loc1_.length / this.var_243));
      }
      
      private function resolveLastItemGridLoc() : Point
      {
         var _loc1_:Array = this.getList();
         return this.resolveGridLocationFromIndex(_loc1_.length - 1);
      }
      
      public function resolveIndexFromImageLocation(param1:Point) : int
      {
         var _loc2_:Point = this.resolveGridLocationFromImage(param1);
         return int(_loc2_.y * this.var_243 + _loc2_.x);
      }
      
      private function resolveGridLocationFromImage(param1:Point) : Point
      {
         var _loc2_:int = Math.floor(param1.y / this.var_105);
         var _loc3_:int = Math.floor(param1.x / this._thumbWidth);
         return new Point(_loc3_,_loc2_);
      }
      
      private function resolveGridLocationFromIndex(param1:int) : Point
      {
         var _loc2_:int = Math.floor(param1 / this.var_243);
         var _loc3_:int = param1 % this.var_243;
         return new Point(_loc3_,_loc2_);
      }
      
      private function removeItemInImage(param1:Point) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         if(param1.x >= this.var_243)
         {
            return;
         }
         if(param1.y >= this.var_654)
         {
            return;
         }
         var _loc4_:int = this.var_243 - param1.x - 1;
         _loc2_ = new Rectangle((param1.x + 1) * this._thumbWidth,param1.y * this.var_105,_loc4_ * this._thumbWidth,this.var_105);
         _loc3_ = new Point(param1.x * this._thumbWidth,param1.y * this.var_105);
         var _loc5_:BitmapData = new BitmapData(_loc2_.width + this._thumbWidth,_loc2_.height);
         _loc5_.fillRect(_loc5_.rect,4294967295);
         _loc5_.copyPixels(this.var_29,_loc2_,new Point(0,0),null,null,true);
         this.var_29.copyPixels(_loc5_,_loc5_.rect,_loc3_,null,null,true);
         if(param1.y < this.var_654 - 1)
         {
            _loc7_ = this.var_29.width - this._thumbWidth;
            _loc8_ = this.var_29.height - (param1.y + 1) * this.var_105;
            _loc9_ = new BitmapData(_loc7_,_loc8_);
            _loc2_ = new Rectangle(this._thumbWidth,(param1.y + 1) * this.var_105,_loc9_.width,_loc9_.height);
            _loc9_.copyPixels(this.var_29,_loc2_,new Point(0,0),null,null,true);
            _loc10_ = new BitmapData(this._thumbWidth,_loc2_.height);
            _loc2_.x = 0;
            _loc2_.width = this._thumbWidth;
            _loc10_.copyPixels(this.var_29,_loc2_,new Point(0,0),null,null,true);
            this.var_29.fillRect(new Rectangle(0,this.var_29.height - this.var_105,this.var_29.width,this.var_105),4294967295);
            _loc3_ = new Point(this.var_29.width - this._thumbWidth,_loc2_.y - this.var_105);
            this.var_29.copyPixels(_loc10_,_loc10_.rect,_loc3_,null,null,true);
            _loc3_ = new Point(0,_loc2_.y);
            this.var_29.copyPixels(_loc9_,_loc9_.rect,_loc3_,null,null,true);
         }
         var _loc6_:int = this.getList().length - 1;
         if(_loc6_ > 0)
         {
            param1 = this.resolveGridLocationFromIndex(_loc6_);
            if(param1.x == this.var_243 - 1)
            {
               _loc11_ = new BitmapData(this.var_29.width,this.var_29.height - this.var_105);
               _loc2_ = new Rectangle(0,0,this.var_29.width,this.var_29.height - this.var_105);
               _loc11_.copyPixels(this.var_29,_loc2_,new Point(0,0),null,null,true);
               this.var_29 = _loc11_;
               --this.var_654;
            }
         }
         if(this.var_29.height < this.var_1003)
         {
            _loc12_ = new BitmapData(this.var_29.width,this.var_1003);
            _loc12_.fillRect(_loc12_.rect,4294967295);
            _loc12_.copyPixels(this.var_29,this.var_29.rect,new Point(0,0),null,null,true);
            this.var_29 = _loc12_;
         }
      }
      
      private function createThumbImage(param1:BitmapData = null, param2:Boolean = false) : BitmapData
      {
         var _loc4_:* = null;
         var _loc3_:BitmapData = new BitmapData(this.var_653.width,this.var_653.height);
         if(param2)
         {
            _loc3_.copyPixels(this._itemBgImageSelected,this.var_653.rect,new Point(0,0),null,null,false);
         }
         else
         {
            _loc3_.copyPixels(this.var_653,this.var_653.rect,new Point(0,0),null,null,false);
         }
         if(param1 != null)
         {
            _loc4_ = new Point((_loc3_.width - param1.width) / 2,(_loc3_.height - param1.height) / 2);
            _loc3_.copyPixels(param1,param1.rect,_loc4_,null,null,true);
         }
         return _loc3_;
      }
   }
}
