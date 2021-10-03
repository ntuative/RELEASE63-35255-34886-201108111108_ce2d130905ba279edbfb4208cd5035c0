package com.sulake.habbo.room.object.visualization.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   
   public class AvatarVisualization extends RoomObjectSpriteVisualization implements IAvatarImageListener
   {
      
      private static const const_1165:String = "avatar";
      
      private static const const_731:Number = -0.01;
      
      private static const const_730:Number = -0.409;
      
      private static const const_1166:int = 2;
      
      private static const const_1747:Array = [0,0,0];
      
      private static const const_1758:int = 3;
       
      
      private var var_743:AvatarVisualizationData = null;
      
      private var var_605:Map;
      
      private var var_606:Map;
      
      private var var_1397:int = 0;
      
      private var var_1084:Boolean;
      
      private var var_727:String;
      
      private var var_1123:String;
      
      private var var_1398:int = 0;
      
      private var var_741:BitmapDataAsset;
      
      private var var_1136:BitmapDataAsset;
      
      private var var_2177:int = -1;
      
      private var var_2196:int = -1;
      
      private var var_2195:int = -1;
      
      private const const_1167:int = 0;
      
      private const const_2142:int = 1;
      
      private const const_2152:int = 2;
      
      private const const_2151:int = 3;
      
      private const const_1748:int = 4;
      
      private var var_1749:int = -1;
      
      private var var_308:String = "";
      
      private var var_1703:String = "";
      
      private var var_2197:Boolean = false;
      
      private var var_2193:Boolean = false;
      
      private var var_2198:Boolean = false;
      
      private var var_1701:Boolean = false;
      
      private var var_715:Boolean = false;
      
      private var var_1694:int = 0;
      
      private var _danceStyle:int = 0;
      
      private var var_2199:int = 0;
      
      private var var_922:int = 0;
      
      private var var_923:int = 0;
      
      private var var_742:int = 0;
      
      private var var_1702:int = 0;
      
      private var var_1404:Boolean = false;
      
      private var var_2192:Boolean = false;
      
      private var var_1403:int = 0;
      
      private var var_921:int = 0;
      
      private var var_2194:Boolean = false;
      
      private var var_1402:int = 0;
      
      private var var_65:IAvatarImage = null;
      
      private var var_1173:Boolean;
      
      public function AvatarVisualization()
      {
         super();
         this.var_605 = new Map();
         this.var_606 = new Map();
         this.var_1084 = false;
      }
      
      override public function dispose() : void
      {
         if(this.var_605 != null)
         {
            this.resetImages();
            this.var_605.dispose();
            this.var_606.dispose();
            this.var_605 = null;
         }
         this.var_743 = null;
         this.var_741 = null;
         this.var_1136 = null;
         super.dispose();
         this.var_1173 = true;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1173;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         this.var_743 = param1 as AvatarVisualizationData;
         createSprites(this.const_1748);
         return true;
      }
      
      private function updateModel(param1:IRoomObjectModel, param2:Number, param3:Boolean) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc5_:* = false;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(param1.getUpdateID() != var_147)
         {
            _loc4_ = false;
            _loc5_ = false;
            _loc6_ = 0;
            _loc7_ = "";
            _loc5_ = Boolean(param1.getNumber(RoomObjectVariableEnum.const_192) > 0 && param3);
            if(_loc5_ != this.var_2197)
            {
               this.var_2197 = _loc5_;
               _loc4_ = true;
            }
            _loc5_ = param1.getNumber(RoomObjectVariableEnum.const_316) > 0;
            if(_loc5_ != this.var_2193)
            {
               this.var_2193 = _loc5_;
               _loc4_ = true;
            }
            _loc5_ = param1.getNumber(RoomObjectVariableEnum.const_301) > 0;
            if(_loc5_ != this.var_2198)
            {
               this.var_2198 = _loc5_;
               _loc4_ = true;
            }
            _loc5_ = Boolean(param1.getNumber(RoomObjectVariableEnum.const_1007) > 0 && param3);
            if(_loc5_ != this.var_1701)
            {
               this.var_1701 = _loc5_;
               _loc4_ = true;
            }
            _loc5_ = param1.getNumber(RoomObjectVariableEnum.const_498) > 0;
            if(_loc5_ != this.var_715)
            {
               this.var_715 = _loc5_;
               _loc4_ = true;
               this.updateTypingBubble(param2);
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_168);
            if(_loc6_ != this.var_1694)
            {
               this.var_1694 = _loc6_;
               _loc4_ = true;
            }
            _loc7_ = param1.getString(RoomObjectVariableEnum.const_285);
            if(_loc7_ != this.var_308)
            {
               this.var_308 = _loc7_;
               _loc4_ = true;
            }
            _loc7_ = param1.getString(RoomObjectVariableEnum.const_769);
            if(_loc7_ != this.var_1703)
            {
               this.var_1703 = _loc7_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_666);
            if(_loc6_ != this._danceStyle)
            {
               this._danceStyle = _loc6_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_656);
            if(_loc6_ != this.var_922)
            {
               this.var_922 = _loc6_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_337);
            if(_loc6_ != this.var_923)
            {
               this.var_923 = _loc6_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_286);
            if(_loc6_ != this.var_742)
            {
               this.var_742 = _loc6_;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_207);
            if(_loc6_ != this.var_2177)
            {
               this.var_2177 = _loc6_;
               _loc4_ = true;
            }
            if(this.var_923 > 0 && param1.getNumber(RoomObjectVariableEnum.const_286) > 0)
            {
               if(this.var_742 != this.var_923)
               {
                  this.var_742 = this.var_923;
                  _loc4_ = true;
               }
            }
            else if(this.var_742 != 0)
            {
               this.var_742 = 0;
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_444);
            if(_loc6_ != this.var_1403)
            {
               this.var_1403 = _loc6_;
               _loc4_ = true;
               this.updateNumberBubble(param2);
            }
            this.validateActions(param2);
            _loc7_ = param1.getString(RoomObjectVariableEnum.AVATAR_GENDER);
            if(_loc7_ != this.var_1123)
            {
               this.var_1123 = _loc7_;
               _loc4_ = true;
            }
            _loc8_ = param1.getString(RoomObjectVariableEnum.const_226);
            if(this.updateFigure(_loc8_))
            {
               _loc4_ = true;
            }
            _loc6_ = param1.getNumber(RoomObjectVariableEnum.const_399);
            if(_loc6_ != this.var_2199)
            {
               _loc4_ = true;
            }
            var_147 = param1.getUpdateID();
            return _loc4_;
         }
         return false;
      }
      
      private function updateFigure(param1:String) : Boolean
      {
         if(this.var_727 != param1)
         {
            this.var_727 = param1;
            this.resetImages();
            return true;
         }
         return false;
      }
      
      private function resetImages() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in this.var_605)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         for each(_loc1_ in this.var_606)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         this.var_605.reset();
         this.var_606.reset();
         this.var_65 = null;
         _loc2_ = getSprite(this.const_1167);
         if(_loc2_ != null)
         {
            _loc2_.asset = null;
            _loc2_.alpha = 255;
         }
      }
      
      private function validateActions(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(param1 < 48)
         {
            this.var_1701 = false;
         }
         if(this.var_308 == "sit" || this.var_308 == "lay")
         {
            this.var_1702 = param1 / 2;
         }
         else
         {
            this.var_1702 = 0;
         }
         this.var_2192 = false;
         this.var_1404 = false;
         if(this.var_308 == "lay")
         {
            this.var_1404 = true;
            _loc2_ = int(this.var_1703);
            if(_loc2_ < 0)
            {
               this.var_2192 = true;
            }
         }
      }
      
      private function getAvatarImage(param1:Number, param2:int) : IAvatarImage
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:String = "avatarImage" + param1.toString();
         if(param2 == 0)
         {
            _loc3_ = this.var_605.getValue(_loc4_) as IAvatarImage;
         }
         else
         {
            _loc4_ += "-" + param2;
            _loc3_ = this.var_606.getValue(_loc4_) as IAvatarImage;
            if(_loc3_)
            {
               _loc3_.forceActionUpdate();
            }
         }
         if(_loc3_ == null)
         {
            _loc3_ = this.var_743.getAvatar(this.var_727,param1,this.var_1123,this);
            if(_loc3_ != null)
            {
               if(param2 == 0)
               {
                  this.var_605.add(_loc4_,_loc3_);
               }
               else
               {
                  if(this.var_606.length >= const_1758)
                  {
                     _loc5_ = this.var_606.remove(this.var_606.getKey(0));
                     if(_loc5_)
                     {
                        _loc5_.dispose();
                     }
                  }
                  this.var_606.add(_loc4_,_loc3_);
               }
            }
         }
         return _loc3_;
      }
      
      private function updateObject(param1:IRoomObject, param2:IRoomGeometry, param3:Boolean, param4:Boolean = false) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param4 || var_518 != param1.getUpdateID() || this.var_1749 != param2.updateId)
         {
            _loc5_ = param3;
            _loc6_ = param1.getDirection().x - param2.direction.x;
            _loc6_ = (_loc6_ % 360 + 360) % 360;
            _loc7_ = this.var_2177;
            if(this.var_308 == "float")
            {
               _loc7_ = _loc6_;
            }
            else
            {
               _loc7_ -= param2.direction.x;
            }
            _loc7_ = (_loc7_ % 360 + 360) % 360;
            if(_loc6_ != this.var_2196 || param4)
            {
               _loc5_ = true;
               this.var_2196 = _loc6_;
               _loc6_ -= 112.5;
               _loc6_ = (_loc6_ + 360) % 360;
               this.var_65.setDirectionAngle(AvatarSetType.const_42,_loc6_);
            }
            if(_loc7_ != this.var_2195 || param4)
            {
               _loc5_ = true;
               this.var_2195 = _loc7_;
               if(this.var_2195 != this.var_2196)
               {
                  _loc7_ -= 112.5;
                  _loc7_ = (_loc7_ + 360) % 360;
                  this.var_65.setDirectionAngle(AvatarSetType.const_56,_loc7_);
               }
            }
            var_518 = param1.getUpdateID();
            this.var_1749 = param2.updateId;
            return _loc5_;
         }
         return false;
      }
      
      private function updateShadow(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:IRoomObjectSprite = getSprite(this.const_2142);
         this.var_741 = null;
         if(this.var_308 == "mv" || this.var_308 == "std")
         {
            _loc2_.visible = true;
            if(this.var_741 == null || param1 != var_102)
            {
               _loc3_ = 0;
               _loc4_ = 0;
               if(param1 < 48)
               {
                  this.var_741 = this.var_65.getAsset("sh_std_sd_1_0_0");
                  _loc3_ = -8;
                  _loc4_ = -3;
               }
               else
               {
                  this.var_741 = this.var_65.getAsset("h_std_sd_1_0_0");
                  _loc3_ = -17;
                  _loc4_ = -7;
               }
               if(this.var_741 != null)
               {
                  _loc2_.asset = this.var_741.content as BitmapData;
                  _loc2_.offsetX = _loc3_;
                  _loc2_.offsetY = _loc4_;
                  _loc2_.alpha = 50;
                  _loc2_.relativeDepth = 1;
               }
               else
               {
                  _loc2_.visible = false;
               }
            }
         }
         else
         {
            this.var_741 = null;
            _loc2_.visible = false;
         }
      }
      
      private function updateTypingBubble(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this.var_1136 = null;
         var _loc2_:IRoomObjectSprite = getSprite(this.const_2152);
         if(this.var_715)
         {
            _loc2_.visible = true;
            _loc5_ = 64;
            if(param1 < 48)
            {
               this.var_1136 = this.var_743.getAvatarRendererAsset("user_typing_small_png") as BitmapDataAsset;
               _loc3_ = 3;
               _loc4_ = -42;
               _loc5_ = 32;
            }
            else
            {
               this.var_1136 = this.var_743.getAvatarRendererAsset("user_typing_png") as BitmapDataAsset;
               _loc3_ = 14;
               _loc4_ = -83;
            }
            if(this.var_308 == "sit")
            {
               _loc4_ += _loc5_ / 2;
            }
            else if(this.var_308 == "lay")
            {
               _loc4_ += _loc5_;
            }
            if(this.var_1136 != null)
            {
               _loc2_.asset = this.var_1136.content as BitmapData;
               _loc2_.offsetX = _loc3_;
               _loc2_.offsetY = _loc4_;
               _loc2_.relativeDepth = -0.02;
            }
         }
         else
         {
            _loc2_.visible = false;
         }
      }
      
      private function updateNumberBubble(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc3_:IRoomObjectSprite = getSprite(this.const_2151);
         if(this.var_1403 > 0)
         {
            _loc6_ = 64;
            if(param1 < 48)
            {
               _loc2_ = this.var_743.getAvatarRendererAsset("number_" + this.var_1403 + "_small_png") as BitmapDataAsset;
               _loc4_ = -6;
               _loc5_ = -52;
               _loc6_ = 32;
            }
            else
            {
               _loc2_ = this.var_743.getAvatarRendererAsset("number_" + this.var_1403 + "_png") as BitmapDataAsset;
               _loc4_ = -8;
               _loc5_ = -105;
            }
            if(this.var_308 == "sit")
            {
               _loc5_ += _loc6_ / 2;
            }
            else if(this.var_308 == "lay")
            {
               _loc5_ += _loc6_;
            }
            if(_loc2_ != null)
            {
               _loc3_.visible = true;
               _loc3_.asset = _loc2_.content as BitmapData;
               _loc3_.offsetX = _loc4_;
               _loc3_.offsetY = _loc5_;
               _loc3_.relativeDepth = -0.01;
               this.var_921 = 1;
               this.var_2194 = true;
               this.var_1402 = 0;
               _loc3_.alpha = 0;
            }
            else
            {
               _loc3_.visible = false;
            }
         }
         else if(_loc3_.visible)
         {
            this.var_921 = -1;
         }
      }
      
      private function animateNumberBubble(param1:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc2_:IRoomObjectSprite = getSprite(this.const_2151);
         var _loc3_:int = _loc2_.alpha;
         var _loc4_:Boolean = false;
         if(this.var_2194)
         {
            ++this.var_1402;
            if(this.var_1402 < 10)
            {
               return false;
            }
            if(this.var_921 < 0)
            {
               if(param1 < 48)
               {
                  _loc2_.offsetY -= 2;
               }
               else
               {
                  _loc2_.offsetY -= 4;
               }
            }
            else
            {
               _loc5_ = 4;
               if(param1 < 48)
               {
                  _loc5_ = 8;
               }
               if(this.var_1402 % _loc5_ == 0)
               {
                  --_loc2_.offsetY;
                  _loc4_ = true;
               }
            }
         }
         if(this.var_921 > 0)
         {
            if(_loc3_ < 255)
            {
               _loc3_ += 32;
            }
            if(_loc3_ >= 255)
            {
               _loc3_ = 255;
               this.var_921 = 0;
            }
            _loc2_.alpha = _loc3_;
            return true;
         }
         if(this.var_921 < 0)
         {
            if(_loc3_ >= 0)
            {
               _loc3_ -= 32;
            }
            if(_loc3_ <= 0)
            {
               this.var_921 = 0;
               this.var_2194 = false;
               _loc3_ = 0;
               _loc2_.visible = false;
            }
            _loc2_.alpha = _loc3_;
            return true;
         }
         return _loc4_;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:int = 0;
         var _loc20_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:* = null;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:* = null;
         var _loc32_:* = null;
         var _loc5_:IRoomObject = object;
         if(_loc5_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(this.var_743 == null)
         {
            return;
         }
         var _loc6_:IRoomObjectModel = _loc5_.getModel();
         var _loc7_:Number = param1.scale;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:int = this.var_922;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = this.updateModel(_loc6_,_loc7_,param3);
         if(this.animateNumberBubble(_loc7_))
         {
            increaseUpdateId();
         }
         if(_loc13_ || _loc7_ != var_102 || this.var_65 == null)
         {
            if(_loc7_ != var_102)
            {
               _loc9_ = true;
               this.validateActions(_loc7_);
            }
            if(_loc11_ != this.var_922)
            {
               _loc12_ = true;
            }
            if(_loc9_ || this.var_65 == null || _loc12_)
            {
               this.var_65 = this.getAvatarImage(_loc7_,this.var_922);
               if(this.var_65 == null)
               {
                  return;
               }
               _loc8_ = true;
               _loc16_ = getSprite(this.const_1167);
               if(_loc16_ && this.var_65 && this.var_65.isPlaceholder())
               {
                  _loc16_.alpha = 150;
               }
               else if(_loc16_)
               {
                  _loc16_.alpha = 255;
               }
            }
            if(this.var_65 == null)
            {
               return;
            }
            this.updateShadow(_loc7_);
            if(_loc9_)
            {
               this.updateTypingBubble(_loc7_);
               this.updateNumberBubble(_loc7_);
            }
            _loc10_ = this.updateObject(_loc5_,param1,param3,true);
            this.updateActions(this.var_65);
            var_102 = _loc7_;
         }
         else
         {
            _loc10_ = this.updateObject(_loc5_,param1,param3);
         }
         var _loc14_:Boolean = _loc10_ || _loc13_ || _loc9_;
         var _loc15_:Boolean = (this.var_1084 || this.var_1398 > 0) && param3;
         if(_loc14_)
         {
            this.var_1398 = const_1166;
         }
         if(_loc14_ || _loc15_)
         {
            increaseUpdateId();
            --this.var_1398;
            --this.var_1397;
            if(!(this.var_1397 <= 0 || _loc9_ || _loc13_ || _loc8_))
            {
               return;
            }
            this.var_65.updateAnimationByFrames(1);
            this.var_1397 = const_1166;
            _loc18_ = this.var_65.getCanvasOffsets();
            if(_loc18_ == null || _loc18_.length < 3)
            {
               _loc18_ = const_1747;
            }
            _loc17_ = getSprite(this.const_1167);
            if(_loc17_ != null)
            {
               _loc21_ = this.var_65.getImage(AvatarSetType.const_42,false);
               if(_loc21_ != null)
               {
                  _loc17_.asset = _loc21_;
               }
               if(_loc17_.asset)
               {
                  _loc17_.offsetX = -1 * _loc7_ / 2 + _loc18_[0];
                  _loc17_.offsetY = -_loc17_.asset.height + _loc7_ / 4 + _loc18_[1] + this.var_1702;
               }
               if(this.var_1404)
               {
                  if(this.var_2192)
                  {
                     _loc17_.relativeDepth = -0.5;
                  }
                  else
                  {
                     _loc17_.relativeDepth = const_730 + _loc18_[2];
                  }
               }
               else
               {
                  _loc17_.relativeDepth = const_731 + _loc18_[2];
               }
            }
            _loc17_ = getSprite(this.const_2152);
            if(_loc17_ != null && _loc17_.visible)
            {
               if(!this.var_1404)
               {
                  _loc17_.relativeDepth = const_731 - 0.01 + _loc18_[2];
               }
               else
               {
                  _loc17_.relativeDepth = const_730 - 0.01 + _loc18_[2];
               }
            }
            this.var_1084 = this.var_65.isAnimating();
            _loc19_ = this.const_1748;
            for each(_loc20_ in this.var_65.getSprites())
            {
               if(_loc20_.id == const_1165)
               {
                  _loc17_ = getSprite(this.const_1167);
                  _loc22_ = this.var_65.getLayerData(_loc20_);
                  _loc23_ = _loc20_.getDirectionOffsetX(this.var_65.getDirection());
                  _loc24_ = _loc20_.getDirectionOffsetY(this.var_65.getDirection());
                  if(_loc22_ != null)
                  {
                     _loc23_ += _loc22_.dx;
                     _loc24_ += _loc22_.dy;
                  }
                  if(_loc7_ < 48)
                  {
                     _loc23_ /= 2;
                     _loc24_ /= 2;
                  }
                  _loc17_.offsetX += _loc23_;
                  _loc17_.offsetY += _loc24_;
               }
               else
               {
                  _loc17_ = getSprite(_loc19_);
                  if(_loc17_ != null)
                  {
                     _loc17_.capturesMouse = false;
                     _loc17_.visible = true;
                     _loc25_ = this.var_65.getLayerData(_loc20_);
                     _loc26_ = 0;
                     _loc27_ = _loc20_.getDirectionOffsetX(this.var_65.getDirection());
                     _loc28_ = _loc20_.getDirectionOffsetY(this.var_65.getDirection());
                     _loc29_ = _loc20_.getDirectionOffsetZ(this.var_65.getDirection());
                     _loc30_ = 0;
                     if(_loc20_.hasDirections)
                     {
                        _loc30_ = this.var_65.getDirection();
                     }
                     if(_loc25_ != null)
                     {
                        _loc26_ = _loc25_.animationFrame;
                        _loc27_ += _loc25_.dx;
                        _loc28_ += _loc25_.dy;
                        _loc30_ += _loc25_.directionOffset;
                     }
                     if(_loc7_ < 48)
                     {
                        _loc27_ /= 2;
                        _loc28_ /= 2;
                     }
                     if(_loc30_ < 0)
                     {
                        _loc30_ += 8;
                     }
                     else if(_loc30_ > 7)
                     {
                        _loc30_ -= 8;
                     }
                     _loc31_ = this.var_65.getScale() + "_" + _loc20_.member + "_" + _loc30_ + "_" + _loc26_;
                     _loc32_ = this.var_65.getAsset(_loc31_);
                     if(_loc32_ == null)
                     {
                        continue;
                     }
                     _loc17_.asset = _loc32_.content as BitmapData;
                     _loc17_.offsetX = -_loc32_.offset.x - _loc7_ / 2 + _loc27_;
                     _loc17_.offsetY = -_loc32_.offset.y + _loc28_ + this.var_1702;
                     if(this.var_1404)
                     {
                        _loc17_.relativeDepth = const_730 - 0.001 * spriteCount * _loc29_;
                     }
                     else
                     {
                        _loc17_.relativeDepth = const_731 - 0.001 * spriteCount * _loc29_;
                     }
                     if(_loc20_.ink == 33)
                     {
                        _loc17_.blendMode = BlendMode.ADD;
                     }
                     else
                     {
                        _loc17_.blendMode = BlendMode.NORMAL;
                     }
                  }
                  _loc19_++;
               }
            }
         }
      }
      
      private function updateActions(param1:IAvatarImage) : void
      {
         var _loc3_:* = null;
         if(param1 == null)
         {
            return;
         }
         param1.initActionAppends();
         param1.appendAction(AvatarAction.const_408,this.var_308,this.var_1703);
         if(this.var_1694 > 0)
         {
            param1.appendAction(AvatarAction.const_380,AvatarAction.const_2056[this.var_1694]);
         }
         if(this._danceStyle > 0)
         {
            param1.appendAction(AvatarAction.const_143,this._danceStyle);
         }
         if(this.var_2199 > 0)
         {
            param1.appendAction(AvatarAction.const_995,this.var_2199);
         }
         if(this.var_923 > 0)
         {
            param1.appendAction(AvatarAction.const_999,this.var_923);
         }
         if(this.var_742 > 0)
         {
            param1.appendAction(AvatarAction.const_748,this.var_742);
         }
         if(this.var_2197)
         {
            param1.appendAction(AvatarAction.const_329);
         }
         if(this.var_2198 || this.var_1701)
         {
            param1.appendAction(AvatarAction.const_568);
         }
         if(this.var_2193)
         {
            param1.appendAction(AvatarAction.const_310);
         }
         if(this.var_922 > 0)
         {
            param1.appendAction(AvatarAction.const_357,this.var_922);
         }
         param1.endActionAppends();
         this.var_1084 = param1.isAnimating();
         var _loc2_:int = this.const_1748;
         for each(_loc3_ in this.var_65.getSprites())
         {
            if(_loc3_.id != const_1165)
            {
               _loc2_++;
            }
         }
         if(_loc2_ != spriteCount)
         {
            createSprites(_loc2_);
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         this.resetImages();
      }
   }
}
