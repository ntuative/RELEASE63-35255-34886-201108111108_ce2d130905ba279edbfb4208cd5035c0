package com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.Point;
   
   public class LayoutRasterizer
   {
       
      
      private var var_812:IGraphicAssetCollection;
      
      private var var_2141:XMLList;
      
      private var _offsetX:int;
      
      private var var_1327:int;
      
      private var var_3044:Vector3d;
      
      private var var_1142:String;
      
      private var var_47:Map = null;
      
      private var var_2206:String = "";
      
      private var _adBgIndex:int = -1;
      
      private var _adImgIndex:int = -1;
      
      private var var_3045:Boolean = false;
      
      private var var_3043:String = "";
      
      private var var_1410:int = 0;
      
      private var var_1143:Boolean = true;
      
      private var var_505:Array;
      
      private var var_747:Array;
      
      private var var_746:Array;
      
      private var var_1409:Point = null;
      
      private var var_1710:LayoutRasterizerData = null;
      
      public function LayoutRasterizer()
      {
         this.var_505 = [];
         this.var_747 = [];
         this.var_746 = [];
         super();
         this.var_47 = new Map();
         this.var_1142 = "";
         this.var_1409 = new Point();
      }
      
      public function get graphicsChanged() : Boolean
      {
         return this.var_1143;
      }
      
      public function set layout(param1:String) : void
      {
         if(param1 != this.var_1142)
         {
            this.var_1142 = param1;
            this._adBgIndex = -1;
            this._adImgIndex = -1;
            this.var_1710 = this.var_47.getValue(this.var_1142);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         this.var_812 = null;
         this.var_2141 = null;
         this.var_505 = null;
         this.var_747 = null;
         this.var_746 = null;
         if(this.var_47 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.var_47.length)
            {
               _loc2_ = this.var_47.getWithIndex(_loc1_) as LayoutRasterizerData;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            this.var_47.dispose();
            this.var_47 = null;
         }
         this.var_1710 = null;
      }
      
      public function initialize(param1:XML) : void
      {
         var _loc2_:String = String(param1.@name);
         var _loc3_:LayoutRasterizerData = new LayoutRasterizerData(param1);
         this.var_47.add(_loc2_,_loc3_);
         this.var_3044 = new Vector3d(-0.5,0.5,0);
         this.var_1143 = false;
      }
      
      public function initializeGeometry(param1:IRoomGeometry) : void
      {
         var _loc2_:Point = param1.getScreenPoint(new Vector3d(0,0,0));
         var _loc3_:Point = param1.getScreenPoint(this.var_3044);
         _loc3_.x -= _loc2_.x;
         _loc3_.y -= _loc2_.y;
         _loc3_.x = Math.round(_loc3_.x);
         _loc3_.y = Math.round(_loc3_.y);
         this.var_1409.x = _loc3_.x;
         this.var_1409.y = _loc3_.y;
      }
      
      public function initializeAds(param1:int, param2:IRoomObjectSpriteVisualization) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         this.var_1410 = param1;
         var _loc3_:LayoutRasterizerData = this.var_47.getValue(this.var_1142);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:XMLList = _loc3_.elementList;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:* = null;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.length())
         {
            _loc7_ = _loc4_[_loc6_];
            if(_loc7_ != null)
            {
               _loc8_ = _loc7_.visualization;
               if(_loc8_.length() > 0 && _loc8_.visualizationLayer.length() > 0)
               {
                  _loc9_ = _loc8_.visualizationLayer[0];
                  if(_loc9_ != null)
                  {
                     if(_loc7_.@id.toString().length > 0)
                     {
                        _loc10_ = String(_loc7_.@id);
                        if(_loc10_ == "billboard_bg")
                        {
                           this._adBgIndex = _loc6_;
                           _loc11_ = String(_loc9_.@asset);
                           if(_loc11_.indexOf("left") > -1)
                           {
                              this.var_2206 = RoomObjectVariableEnum.const_1382;
                           }
                           if(_loc11_.indexOf("right") > -1)
                           {
                              this.var_2206 = RoomObjectVariableEnum.const_1264;
                           }
                           if(param2 != null)
                           {
                              _loc5_ = param2.getSprite(this.var_1410 + this._adBgIndex);
                              if(_loc5_ != null)
                              {
                                 _loc5_.visible = false;
                                 _loc5_.alpha = 0;
                              }
                           }
                        }
                        if(_loc10_ == "billboard_img")
                        {
                           this._adImgIndex = _loc6_;
                           if(param2 != null)
                           {
                              _loc5_ = param2.getSprite(this.var_1410 + this._adImgIndex);
                              if(_loc5_ != null)
                              {
                                 _loc5_.visible = false;
                                 _loc5_.alpha = 0;
                              }
                           }
                        }
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      public function initializeAssetCollection(param1:IGraphicAssetCollection) : void
      {
         this.var_812 = param1;
      }
      
      public function elementCount() : int
      {
         var _loc1_:LayoutRasterizerData = this.var_47.getValue(this.var_1142);
         if(_loc1_ == null)
         {
            return 0;
         }
         var _loc2_:XMLList = _loc1_.elementList;
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_.length();
      }
      
      private function getBlendMode(param1:String) : String
      {
         var _loc2_:String = "null";
         switch(param1)
         {
            case "ADD":
               _loc2_ = "null";
               break;
            case "SUBTRACT":
               _loc2_ = "null";
               break;
            case "DARKEN":
               _loc2_ = "null";
         }
         return _loc2_;
      }
      
      public function showAd(param1:IRoomObjectSpriteVisualization, param2:String = "", param3:Boolean = false) : void
      {
         if(param2 == this.var_3043 && param3 == this.var_3045)
         {
            return;
         }
         if(this._adBgIndex == -1 || this._adImgIndex == -1)
         {
            Logger.log("ERROR! Billboard sprite indices not defined, cannot show room ad!");
            return;
         }
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1 != null)
         {
            _loc4_ = param1.getSprite(this.var_1410 + this._adBgIndex);
            _loc5_ = param1.getSprite(this.var_1410 + this._adImgIndex);
         }
         if(_loc4_ == null || _loc5_ == null)
         {
            Logger.log("ERROR! Billboard sprites not defined, cannot show room ad!");
            return;
         }
         if(param3)
         {
            this.exchangeElementGraphics("billboard_img",param2);
         }
         else
         {
            this.exchangeElementGraphics("billboard_img",this.var_2206);
         }
         this.setElementToSprite(this._adBgIndex,_loc4_,param2,param3);
         this.setElementToSprite(this._adImgIndex,_loc5_,param2,param3);
         if(param3)
         {
            _loc5_.capturesMouse = true;
            _loc5_.clickHandling = true;
            _loc5_.tag = RoomObjectVariableEnum.const_585;
         }
         if(param2 != "")
         {
            _loc4_.visible = true;
            _loc4_.alpha = 255;
            _loc5_.visible = true;
            _loc5_.alpha = 255;
         }
         else
         {
            _loc4_.visible = false;
            _loc4_.alpha = 0;
            _loc5_.visible = false;
            _loc5_.alpha = 0;
         }
         _loc5_.offsetX -= _loc5_.width / 2;
         _loc5_.offsetY -= _loc5_.height / 2;
         this.var_3043 = param2;
         this.var_3045 = param3;
      }
      
      public function setElementToSprite(param1:int, param2:IRoomObjectSprite, param3:String = "", param4:Boolean = false) : void
      {
         var _loc10_:* = null;
         if(this.var_1710 == null)
         {
            return;
         }
         var _loc5_:XMLList = this.var_1710.elementList;
         if(_loc5_ == null)
         {
            return;
         }
         if(param1 < 0 || param1 >= _loc5_.length())
         {
            return;
         }
         var _loc6_:XML = _loc5_[param1];
         if(_loc6_ == null)
         {
            return;
         }
         var _loc7_:XMLList = _loc6_.visualization;
         if(_loc7_.length() == 0 || _loc7_.visualizationLayer.length() == 0)
         {
            return;
         }
         var _loc8_:XML = _loc7_.visualizationLayer[0];
         if(_loc8_ == null)
         {
            return;
         }
         var _loc9_:IGraphicAsset = this.var_812.getAsset(_loc8_.@asset);
         if(_loc9_ == null || _loc9_.asset == null)
         {
            return;
         }
         param2.visible = true;
         param2.alpha = 255;
         param2.asset = _loc9_.asset.content as BitmapData;
         param2.offsetX = int(_loc8_.@x) + _loc9_.offsetX + this.var_1409.x;
         param2.offsetY = int(_loc8_.@y) + _loc9_.offsetY + this.var_1409.y;
         param2.blendMode = this.getBlendMode(String(_loc8_.@ink));
         param2.capturesMouse = false;
         if(parseInt(_loc8_.@capturesMouse) > 0)
         {
            param2.capturesMouse = true;
            param2.tag = String(_loc6_.@id);
         }
         if(String(_loc8_.@z) != "")
         {
            param2.relativeDepth = -Number(_loc8_.@z) / Math.sqrt(2) - 0.00001 * param1;
         }
         else
         {
            param2.relativeDepth = -(0.001 * param1);
         }
         if(_loc8_.@blend.toString().length > 0)
         {
            param2.alpha = int(Number(_loc8_.@blend) * 2.55);
         }
         if(_loc8_.@flipH.toString().length > 0)
         {
            param2.flipH = Boolean(_loc8_.@flipH);
         }
         if(_loc6_.@id.toString().length > 0)
         {
            _loc10_ = String(_loc6_.@id);
            if(this.var_505.indexOf(_loc10_) >= 0 && this.var_1143)
            {
               param1 = this.var_505.indexOf(_loc10_);
               if(this.var_747[param1] != "")
               {
                  _loc9_ = this.var_812.getAsset(this.var_747[param1]);
                  if(_loc9_ != null && _loc9_.asset != null)
                  {
                     param2.asset = _loc9_.asset.content as BitmapData;
                  }
                  else
                  {
                     param2.asset = null;
                  }
               }
               if(this.var_746[param1] != -1)
               {
                  param2.alpha = this.var_746[param1];
               }
               this.var_505.splice(param1,1);
               this.var_747.splice(param1,1);
               this.var_746.splice(param1,1);
               if(this.var_505.length == 0)
               {
                  this.var_1143 = false;
               }
            }
         }
      }
      
      public function exchangeElementGraphics(param1:String, param2:String) : void
      {
         this.var_1143 = true;
         var _loc3_:int = this.var_505.indexOf(param1);
         if(_loc3_ < 0)
         {
            this.var_505.push(param1);
            this.var_747.push(param2);
            this.var_746.push(-1);
         }
         else
         {
            this.var_747[_loc3_] = param2;
         }
      }
      
      public function changeElementAlpha(param1:String, param2:Number) : void
      {
         this.var_1143 = true;
         var _loc3_:int = this.var_505.indexOf(param1);
         if(_loc3_ < 0)
         {
            this.var_505.push(param1);
            this.var_747.push("");
            this.var_746.push(param2);
         }
         else
         {
            this.var_746[_loc3_] = param2;
         }
      }
   }
}
