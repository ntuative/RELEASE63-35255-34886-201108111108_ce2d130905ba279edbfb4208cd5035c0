package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.room.object.visualization.data.AnimationData;
   import com.sulake.habbo.room.object.visualization.data.AnimationFrame;
   import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class AnimatedFurnitureVisualization extends FurnitureVisualization
   {
      
      public static const const_1402:int = 0;
       
      
      private var _animationData:AnimatedFurnitureVisualizationData = null;
      
      private var _state:int = -1;
      
      private var var_127:AnimationStateData;
      
      private var var_1786:int = 0;
      
      private var var_453:Number = 0;
      
      private var var_720:int = 0;
      
      private var var_978:Boolean = false;
      
      public function AnimatedFurnitureVisualization()
      {
         super();
         this.var_127 = new AnimationStateData();
      }
      
      protected function get layerCount() : int
      {
         return this.var_720;
      }
      
      override protected function set direction(param1:int) : void
      {
         if(this.direction != param1)
         {
            super.direction = param1;
            this.var_978 = true;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._animationData = null;
         if(this.var_127 != null)
         {
            this.var_127.dispose();
            this.var_127 = null;
         }
      }
      
      public function get animationId() : int
      {
         return this.var_127.animationId;
      }
      
      protected function getAnimationId(param1:AnimationStateData) : int
      {
         var _loc2_:int = this.animationId;
         if(_loc2_ != const_1402 && this._animationData.hasAnimation(this.var_453,_loc2_))
         {
            return _loc2_;
         }
         return const_1402;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         if(!(param1 is AnimatedFurnitureVisualizationData))
         {
            return false;
         }
         this._animationData = param1 as AnimatedFurnitureVisualizationData;
         return super.initialize(param1);
      }
      
      override protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         if(super.updateObject(param1,param2))
         {
            _loc3_ = object;
            if(_loc3_ == null)
            {
               return false;
            }
            _loc4_ = _loc3_.getState(0);
            if(_loc4_ != this._state)
            {
               this.setAnimation(_loc4_);
               this._state = _loc4_;
               _loc5_ = _loc3_.getModel();
               if(_loc5_ != null)
               {
                  _loc6_ = _loc5_.getNumber(RoomObjectVariableEnum.const_961);
                  this.var_1786 = _loc6_;
               }
            }
            return true;
         }
         return false;
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(super.updateModel(param1))
         {
            _loc2_ = object;
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.getModel();
               if(_loc3_ != null)
               {
                  if(this.usesAnimationResetting())
                  {
                     _loc5_ = _loc3_.getNumber(RoomObjectVariableEnum.const_961);
                     if(_loc5_ > this.var_1786)
                     {
                        this.var_1786 = _loc5_;
                        this.setAnimation(this._state);
                     }
                  }
                  _loc4_ = _loc3_.getNumber(RoomObjectVariableEnum.const_1000);
                  if(!isNaN(_loc4_))
                  {
                     _loc6_ = this._animationData.getAnimationId(this.var_453,_loc4_);
                     this.setAnimation(_loc6_);
                  }
               }
            }
            return true;
         }
         return false;
      }
      
      private function isPlayingTransition(param1:AnimationStateData, param2:int) : Boolean
      {
         var _loc3_:int = param1.animationId;
         if(AnimationData.isTransitionFromAnimation(_loc3_) || AnimationData.isTransitionToAnimation(_loc3_))
         {
            if(param2 == param1.animationAfterTransitionId)
            {
               if(!param1.animationOver)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getCurrentState(param1:AnimationStateData) : int
      {
         var _loc2_:int = param1.animationId;
         if(AnimationData.isTransitionFromAnimation(_loc2_) || AnimationData.isTransitionToAnimation(_loc2_))
         {
            return param1.animationAfterTransitionId;
         }
         return _loc2_;
      }
      
      protected function setAnimation(param1:int) : void
      {
         if(this._animationData != null)
         {
            this.setSubAnimation(this.var_127,param1,this._state >= 0);
         }
      }
      
      protected function setSubAnimation(param1:AnimationStateData, param2:int, param3:Boolean = true) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = param1.animationId;
         if(param3)
         {
            if(this.isPlayingTransition(param1,param2))
            {
               return false;
            }
            _loc5_ = this.getCurrentState(param1);
            if(param2 != _loc5_)
            {
               if(!this._animationData.isImmediateChange(this.var_453,param2,_loc5_))
               {
                  _loc6_ = AnimationData.method_2(_loc5_);
                  if(this._animationData.hasAnimation(this.var_453,_loc6_))
                  {
                     param1.animationAfterTransitionId = param2;
                     param2 = _loc6_;
                  }
                  else
                  {
                     _loc6_ = AnimationData.getTransitionToAnimationId(param2);
                     if(this._animationData.hasAnimation(this.var_453,_loc6_))
                     {
                        param1.animationAfterTransitionId = param2;
                        param2 = _loc6_;
                     }
                  }
               }
            }
            else if(AnimationData.isTransitionFromAnimation(_loc4_))
            {
               _loc6_ = AnimationData.getTransitionToAnimationId(param2);
               if(this._animationData.hasAnimation(this.var_453,_loc6_))
               {
                  param1.animationAfterTransitionId = param2;
                  param2 = _loc6_;
               }
            }
            else if(!AnimationData.isTransitionToAnimation(_loc4_))
            {
               if(this.usesAnimationResetting())
               {
                  _loc6_ = AnimationData.method_2(_loc5_);
                  if(this._animationData.hasAnimation(this.var_453,_loc6_))
                  {
                     param1.animationAfterTransitionId = param2;
                     param2 = _loc6_;
                  }
                  else
                  {
                     _loc6_ = AnimationData.getTransitionToAnimationId(param2);
                     if(this._animationData.hasAnimation(this.var_453,_loc6_))
                     {
                        param1.animationAfterTransitionId = param2;
                        param2 = _loc6_;
                     }
                  }
               }
            }
         }
         if(_loc4_ != param2)
         {
            param1.animationId = param2;
            return true;
         }
         return false;
      }
      
      protected function getLastFramePlayed(param1:int) : Boolean
      {
         return this.var_127.getLastFramePlayed(param1);
      }
      
      protected function resetAllAnimationFrames() : void
      {
         if(this.var_127 != null)
         {
            this.var_127.setLayerCount(this.var_720);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(this._animationData == null)
         {
            return 0;
         }
         if(param1 != this.var_453)
         {
            this.var_453 = param1;
            this.var_720 = this._animationData.getLayerCount(param1);
            this.resetAllAnimationFrames();
         }
         var _loc2_:int = this.updateAnimations(param1);
         this.var_978 = false;
         return _loc2_;
      }
      
      protected function updateAnimations(param1:Number) : int
      {
         var _loc2_:int = 0;
         if(!this.var_127.animationOver || this.var_978)
         {
            _loc2_ = this.updateFramesForAnimation(this.var_127,param1);
            if(this.var_127.animationOver)
            {
               if(AnimationData.isTransitionFromAnimation(this.var_127.animationId) || AnimationData.isTransitionToAnimation(this.var_127.animationId))
               {
                  this.setAnimation(this.var_127.animationAfterTransitionId);
                  this.var_127.animationOver = false;
               }
            }
         }
         return _loc2_;
      }
      
      protected function updateFramesForAnimation(param1:AnimationStateData, param2:Number) : int
      {
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         if(param1.animationOver && !this.var_978)
         {
            return 0;
         }
         var _loc3_:int = param1.frameCounter;
         var _loc4_:int = this.getAnimationId(param1);
         if(_loc3_ == 0)
         {
            _loc3_ = this._animationData.getStartFrame(param2,_loc4_,direction);
         }
         _loc3_ += 1;
         param1.frameCounter = _loc3_;
         var _loc6_:* = 0;
         param1.animationOver = true;
         var _loc7_:* = 1 << this.var_720 - 1;
         var _loc8_:int = this.var_720 - 1;
         while(_loc8_ >= 0)
         {
            _loc9_ = param1.getAnimationPlayed(_loc8_);
            if(!_loc9_ || this.var_978)
            {
               _loc10_ = param1.getLastFramePlayed(_loc8_);
               _loc11_ = param1.getFrame(_loc8_);
               if(_loc11_ != null)
               {
                  if(_loc11_.isLastFrame && _loc11_.remainingFrameRepeats <= 1)
                  {
                     _loc10_ = true;
                  }
               }
               if(this.var_978 || _loc11_ == null || _loc11_.remainingFrameRepeats >= 0 && _loc13_ <= 0)
               {
                  _loc12_ = 0;
                  if(_loc11_ != null)
                  {
                     _loc12_ = _loc11_.activeSequence;
                  }
                  if(_loc12_ == AnimationFrame.const_1257)
                  {
                     _loc11_ = this._animationData.getFrame(param2,_loc4_,direction,_loc8_,_loc3_);
                  }
                  else
                  {
                     _loc11_ = this._animationData.getFrameFromSequence(param2,_loc4_,direction,_loc8_,_loc12_,_loc11_.activeSequenceOffset + _loc11_.repeats,_loc3_);
                  }
                  param1.setFrame(_loc8_,_loc11_);
                  _loc6_ |= _loc7_;
               }
               if(_loc11_ == null || _loc11_.remainingFrameRepeats == AnimationFrame.const_640)
               {
                  _loc10_ = true;
                  _loc9_ = true;
               }
               else
               {
                  param1.animationOver = false;
               }
               param1.setLastFramePlayed(_loc8_,_loc10_);
               param1.setAnimationPlayed(_loc8_,_loc9_);
            }
            _loc7_ >>= 1;
            _loc8_--;
         }
         return _loc6_;
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         var _loc3_:AnimationFrame = this.var_127.getFrame(param2);
         if(_loc3_ != null)
         {
            return _loc3_.id;
         }
         return super.getFrameNumber(param1,param2);
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = super.getSpriteXOffset(param1,param2,param3);
         var _loc5_:AnimationFrame = this.var_127.getFrame(param3);
         if(_loc5_ != null)
         {
            _loc4_ += _loc5_.x;
         }
         return _loc4_;
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = super.getSpriteYOffset(param1,param2,param3);
         var _loc5_:AnimationFrame = this.var_127.getFrame(param3);
         if(_loc5_ != null)
         {
            _loc4_ += _loc5_.y;
         }
         return _loc4_;
      }
      
      protected function usesAnimationResetting() : Boolean
      {
         return false;
      }
   }
}
