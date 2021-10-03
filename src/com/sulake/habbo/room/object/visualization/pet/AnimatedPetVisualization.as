package com.sulake.habbo.room.object.visualization.pet
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.visualization.data.AnimationData;
   import com.sulake.habbo.room.object.visualization.data.AnimationFrame;
   import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
   import com.sulake.habbo.room.object.visualization.data.DirectionData;
   import com.sulake.habbo.room.object.visualization.data.LayerData;
   import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   
   public class AnimatedPetVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1763:String = "head";
      
      private static const const_732:int = 1;
      
      private static const const_1168:int = 1000;
      
      private static const const_1761:String = "pet_experience_bubble_png";
      
      private static const const_1760:int = 0;
      
      private static const const_1762:int = 1;
      
      private static const ANIMATION_INDEX_COUNT:int = 2;
       
      
      private var var_308:String = "";
      
      private var var_1694:String = "";
      
      private var var_2198:Boolean = false;
      
      private var var_2205:int = 0;
      
      private var var_428:ExperienceData;
      
      private var var_1693:int = 0;
      
      private var var_2613:int = 0;
      
      private var _animationData:AnimatedPetVisualizationData = null;
      
      private var var_3038:String = "";
      
      private var var_2204:int = -1;
      
      private var var_144:Array;
      
      private var var_1706:Boolean = false;
      
      private var var_1139:Array;
      
      private var var_3039:int = -1;
      
      public function AnimatedPetVisualization()
      {
         this.var_144 = [];
         this.var_1139 = [];
         super();
         while(this.var_144.length < ANIMATION_INDEX_COUNT)
         {
            this.var_144.push(new AnimationStateData());
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         super.dispose();
         if(this.var_144 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.var_144.length)
            {
               _loc2_ = this.var_144[_loc1_] as AnimationStateData;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            this.var_144 = null;
         }
         if(this.var_428)
         {
            this.var_428.dispose();
            this.var_428 = null;
         }
      }
      
      override protected function getAnimationId(param1:AnimationStateData) : int
      {
         return param1.animationId;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         var _loc3_:* = null;
         if(!(param1 is AnimatedPetVisualizationData))
         {
            return false;
         }
         this._animationData = param1 as AnimatedPetVisualizationData;
         var _loc2_:* = null;
         if(this._animationData.commonAssets != null)
         {
            _loc3_ = this._animationData.commonAssets.getAssetByName(const_1761) as BitmapDataAsset;
            if(_loc3_ != null)
            {
               _loc2_ = (_loc3_.content as BitmapData).clone();
               this.var_428 = new ExperienceData(_loc2_);
            }
         }
         if(super.initialize(param1))
         {
            return true;
         }
         return false;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         super.update(param1,param2,param3,param4);
         this.updateExperienceBubble(param2);
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         var _loc3_:int = 0;
         var _loc2_:IRoomObject = object;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getDirection().x;
            if(_loc3_ != this.var_3039)
            {
               this.var_3039 = _loc3_;
               this.resetAllAnimationFrames();
            }
         }
         return super.updateAnimation(param1);
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:IRoomObjectModel = _loc2_.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         if(_loc3_.getUpdateID() != var_147)
         {
            _loc4_ = _loc3_.getString(RoomObjectVariableEnum.const_285);
            _loc5_ = _loc3_.getString(RoomObjectVariableEnum.const_168);
            _loc6_ = _loc3_.getNumber(RoomObjectVariableEnum.const_285);
            if(!isNaN(_loc6_))
            {
               _loc10_ = this._animationData.getPostureCount(var_102);
               if(_loc10_ > 0)
               {
                  _loc4_ = this._animationData.getPostureForAnimation(var_102,_loc6_ % _loc10_);
                  _loc5_ = null;
               }
            }
            _loc7_ = _loc3_.getNumber(RoomObjectVariableEnum.const_168);
            if(!isNaN(_loc7_))
            {
               _loc11_ = this._animationData.getGestureCount(var_102);
               if(_loc11_ > 0)
               {
                  _loc5_ = this._animationData.getGestureForAnimation(var_102,_loc7_ % _loc11_);
               }
            }
            this.validateActions(_loc4_,_loc5_);
            this.var_2198 = _loc3_.getNumber(RoomObjectVariableEnum.const_301) > 0;
            _loc8_ = _loc3_.getNumber(RoomObjectVariableEnum.const_207);
            if(!isNaN(_loc8_))
            {
               this.var_2205 = _loc8_;
            }
            else
            {
               this.var_2205 = direction;
            }
            this.var_1693 = _loc3_.getNumber(RoomObjectVariableEnum.AVATAR_EXPERIENCE_TIMESTAMP);
            this.var_2613 = _loc3_.getNumber(RoomObjectVariableEnum.const_402);
            _loc9_ = _loc3_.getNumber(RoomObjectVariableEnum.const_1011);
            if(_loc9_ != this.var_2204)
            {
               this.var_2204 = _loc9_;
               this.var_3038 = this.var_2204.toString();
            }
            var_147 = _loc3_.getUpdateID();
            return true;
         }
         return false;
      }
      
      private function updateExperienceBubble(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(this.var_428 != null)
         {
            this.var_428.alpha = 0;
            if(this.var_1693 > 0)
            {
               _loc2_ = param1 - this.var_1693;
               if(_loc2_ < const_1168)
               {
                  this.var_428.alpha = int(Math.sin(_loc2_ / const_1168 * 0) * 255);
                  this.var_428.setExperience(this.var_2613);
               }
               else
               {
                  this.var_1693 = 0;
               }
               _loc3_ = getSprite(spriteCount - 1);
               if(_loc3_ != null)
               {
                  if(this.var_428.alpha > 0)
                  {
                     _loc3_.asset = this.var_428.image;
                     _loc3_.offsetX = -20;
                     _loc3_.offsetY = -80;
                     _loc3_.alpha = this.var_428.alpha;
                     _loc3_.visible = true;
                  }
                  else
                  {
                     _loc3_.asset = null;
                     _loc3_.visible = false;
                  }
               }
            }
         }
      }
      
      private function validateActions(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         if(param1 != this.var_308)
         {
            this.var_308 = param1;
            _loc3_ = this._animationData.getAnimationForPosture(var_102,param1);
            this.setAnimationForIndex(const_1760,_loc3_);
         }
         if(param2 != this.var_1694)
         {
            this.var_1694 = param2;
            _loc3_ = this._animationData.getAnimationForGesture(var_102,param2);
            this.setAnimationForIndex(const_1762,_loc3_);
         }
      }
      
      override protected function updateLayerCount(param1:int) : void
      {
         super.updateLayerCount(param1);
         this.var_1139 = [];
      }
      
      override protected function getAdditionalSpriteCount() : int
      {
         return super.getAdditionalSpriteCount() + const_732;
      }
      
      override protected function setAnimation(param1:int) : void
      {
      }
      
      private function getAnimationStateData(param1:int) : AnimationStateData
      {
         var _loc2_:* = null;
         if(param1 >= 0 && param1 < this.var_144.length)
         {
            return this.var_144[param1];
         }
         return null;
      }
      
      private function setAnimationForIndex(param1:int, param2:int) : void
      {
         var _loc3_:AnimationStateData = this.getAnimationStateData(param1);
         if(_loc3_ != null)
         {
            if(setSubAnimation(_loc3_,param2))
            {
               this.var_1706 = false;
            }
         }
      }
      
      override protected function resetAllAnimationFrames() : void
      {
         var _loc2_:* = null;
         this.var_1706 = false;
         var _loc1_:int = this.var_144.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this.var_144[_loc1_];
            if(_loc2_ != null)
            {
               _loc2_.setLayerCount(layerCount);
            }
            _loc1_--;
         }
      }
      
      override protected function updateAnimations(param1:Number) : int
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(this.var_1706)
         {
            return 0;
         }
         var _loc2_:Boolean = true;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.var_144.length)
         {
            _loc5_ = this.var_144[_loc4_];
            if(_loc5_ != null)
            {
               if(!_loc5_.animationOver)
               {
                  _loc6_ = updateFramesForAnimation(_loc5_,param1);
                  _loc3_ |= _loc6_;
                  if(!_loc5_.animationOver)
                  {
                     _loc2_ = false;
                  }
                  else if(AnimationData.isTransitionFromAnimation(_loc5_.animationId) || AnimationData.isTransitionToAnimation(_loc5_.animationId))
                  {
                     this.setAnimationForIndex(_loc4_,_loc5_.animationAfterTransitionId);
                     _loc2_ = false;
                  }
               }
            }
            _loc4_++;
         }
         this.var_1706 = _loc2_;
         return _loc3_;
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:int = this.var_144.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = this.var_144[_loc3_];
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.getFrame(param2);
               if(_loc5_ != null)
               {
                  return _loc5_.id;
               }
            }
            _loc3_--;
         }
         return super.getFrameNumber(param1,param2);
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc4_:int = super.getSpriteXOffset(param1,param2,param3);
         var _loc5_:int = this.var_144.length - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = this.var_144[_loc5_];
            if(_loc6_ != null)
            {
               _loc7_ = _loc6_.getFrame(param3);
               if(_loc7_ != null)
               {
                  _loc4_ += _loc7_.x;
               }
            }
            _loc5_--;
         }
         return _loc4_;
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc4_:int = super.getSpriteYOffset(param1,param2,param3);
         var _loc5_:int = this.var_144.length - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = this.var_144[_loc5_];
            if(_loc6_ != null)
            {
               _loc7_ = _loc6_.getFrame(param3);
               if(_loc7_ != null)
               {
                  _loc4_ += _loc7_.y;
               }
            }
            _loc5_--;
         }
         return _loc4_;
      }
      
      override protected function getAsset(param1:String) : IGraphicAsset
      {
         var _loc2_:* = null;
         if(assetCollection != null)
         {
            return assetCollection.getAssetWithPalette(param1,this.var_3038);
         }
         return null;
      }
      
      override protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         if(this._animationData == null)
         {
            return LayerData.const_419;
         }
         return Number(this._animationData.getZOffset(param1,this.getDirection(param1,param3),param3));
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = spriteCount;
         if(param2 < _loc3_ - const_732)
         {
            _loc4_ = getSize(param1);
            if(param2 < _loc3_ - (1 + const_732))
            {
               if(param2 >= FurnitureVisualizationData.const_531.length)
               {
                  return null;
               }
               _loc5_ = FurnitureVisualizationData.const_531[param2];
               if(_loc4_ == 1)
               {
                  return type + "_icon_" + _loc5_;
               }
               return type + "_" + _loc4_ + "_" + _loc5_ + "_" + this.getDirection(param1,param2) + "_" + this.getFrameNumber(_loc4_,param2);
            }
            return type + "_" + _loc4_ + "_sd_" + this.getDirection(param1,param2) + "_0";
         }
         return null;
      }
      
      private function getDirection(param1:int, param2:int) : int
      {
         if(this.isHeadSprite(param2))
         {
            return this._animationData.getDirectionValue(param1,this.var_2205);
         }
         return direction;
      }
      
      private function isHeadSprite(param1:int) : Boolean
      {
         if(this.var_1139[param1] == null)
         {
            if(this._animationData.getTag(var_102,DirectionData.USE_DEFAULT_DIRECTION,param1) == const_1763)
            {
               this.var_1139[param1] = true;
            }
            else
            {
               this.var_1139[param1] = false;
            }
         }
         return this.var_1139[param1];
      }
   }
}
