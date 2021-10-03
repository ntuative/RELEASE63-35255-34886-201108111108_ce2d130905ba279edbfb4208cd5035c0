package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.inventory.common.IThumbListDrawableItem;
   import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
   import flash.display.BitmapData;
   
   public class Effect implements IWidgetAvatarEffect, IThumbListDrawableItem
   {
       
      
      private var _type:int;
      
      private var var_1753:int;
      
      private var var_1020:int = 1;
      
      private var var_1527:int;
      
      private var var_538:Boolean = false;
      
      private var _isSelected:Boolean = false;
      
      private var var_1899:Boolean = false;
      
      private var var_768:BitmapData;
      
      private var var_2606:Date;
      
      public function Effect()
      {
         super();
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get duration() : int
      {
         return this.var_1753;
      }
      
      public function get effectsInInventory() : int
      {
         return this.var_1020;
      }
      
      public function get isActive() : Boolean
      {
         return this.var_538;
      }
      
      public function get isInUse() : Boolean
      {
         return this.var_1899;
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function get icon() : BitmapData
      {
         return this.var_768;
      }
      
      public function get iconImage() : BitmapData
      {
         return this.var_768;
      }
      
      public function get secondsLeft() : int
      {
         var _loc1_:int = 0;
         if(this.var_538)
         {
            _loc1_ = this.var_1527 - (new Date().valueOf() - this.var_2606.valueOf()) / 1000;
            _loc1_ = Math.floor(_loc1_);
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            return _loc1_;
         }
         return this.var_1527;
      }
      
      public function set type(param1:int) : void
      {
         this._type = param1;
      }
      
      public function set duration(param1:int) : void
      {
         this.var_1753 = param1;
      }
      
      public function set secondsLeft(param1:int) : void
      {
         this.var_1527 = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         this._isSelected = param1;
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         this.var_1899 = param1;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         this.var_768 = param1;
      }
      
      public function set effectsInInventory(param1:int) : void
      {
         this.var_1020 = param1;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(param1 && !this.var_538)
         {
            this.var_2606 = new Date();
         }
         this.var_538 = param1;
      }
      
      public function setOneEffectExpired() : void
      {
         --this.var_1020;
         if(this.var_1020 < 0)
         {
            this.var_1020 = 0;
         }
         this.var_1527 = this.var_1753;
         this.var_538 = false;
         this.var_1899 = false;
      }
   }
}
