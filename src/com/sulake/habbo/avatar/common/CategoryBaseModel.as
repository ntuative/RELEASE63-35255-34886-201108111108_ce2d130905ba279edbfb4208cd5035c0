package com.sulake.habbo.avatar.common
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   
   public class CategoryBaseModel implements IAvatarEditorCategoryModel
   {
       
      
      protected var var_119:Map;
      
      protected var var_26:HabboAvatarEditor;
      
      protected var _isInitialized:Boolean = false;
      
      protected var _view:IAvatarEditorCategoryView;
      
      private var var_1173:Boolean;
      
      public function CategoryBaseModel(param1:HabboAvatarEditor)
      {
         super();
         this.var_26 = param1;
      }
      
      public function dispose() : void
      {
         if(this._view != null)
         {
            this._view.dispose();
         }
         this._view = null;
         this.var_119 = null;
         this.var_26 = null;
         this.var_1173 = true;
      }
      
      public function get disposed() : Boolean
      {
         return this.var_1173;
      }
      
      protected function init() : void
      {
         if(!this.var_119)
         {
            this.var_119 = new Map();
         }
      }
      
      public function reset() : void
      {
         var _loc1_:* = null;
         this._isInitialized = false;
         for each(_loc1_ in this.var_119)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         this.var_119 = new Map();
         if(this._view)
         {
            this._view.reset();
         }
      }
      
      protected function initCategory(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:CategoryData = this.var_119[param1];
         if(_loc2_ == null)
         {
            _loc3_ = this.var_26.generateDataContent(this,param1);
            if(_loc3_)
            {
               this.var_119[param1] = _loc3_;
               this.updateSelectionsFromFigure(param1);
            }
         }
      }
      
      public function switchCategory(param1:String) : void
      {
         if(!this._isInitialized)
         {
            this.init();
         }
         if(this._view)
         {
            this._view.switchCategory(param1);
         }
      }
      
      protected function updateSelectionsFromFigure(param1:String) : void
      {
         if(!this.var_119 || !this.var_26 || !this.var_26.figureData)
         {
            return;
         }
         var _loc2_:CategoryData = this.var_119[param1];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = this.var_26.figureData.getPartSetId(param1);
         var _loc4_:Array = this.var_26.figureData.getColourIds(param1);
         if(!_loc4_)
         {
            _loc4_ = new Array();
         }
         _loc2_.selectPartId(_loc3_);
         _loc2_.selectColorIds(_loc4_);
         if(this._view)
         {
            this._view.showPalettes(param1,_loc4_.length);
         }
      }
      
      public function hasClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:Boolean = false;
         if(!this.var_119)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         for each(_loc3_ in this.var_119)
         {
            if(_loc3_)
            {
               _loc4_ = _loc3_.hasClubSelectionsOverLevel(param1);
               if(_loc4_)
               {
                  _loc2_ = true;
               }
            }
         }
         return _loc2_;
      }
      
      public function stripClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:Boolean = false;
         var _loc8_:* = null;
         if(!this.var_119)
         {
            return false;
         }
         var _loc2_:Array = this.var_119.getKeys();
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = _loc2_[_loc4_];
            _loc6_ = this.var_119[_loc5_];
            _loc7_ = false;
            if(_loc6_.stripClubItemsOverLevel(param1))
            {
               _loc7_ = true;
            }
            if(_loc6_.stripClubColorsOverLevel(param1))
            {
               _loc7_ = true;
            }
            if(_loc7_)
            {
               _loc8_ = _loc6_.getCurrentPart();
               if(_loc8_ && this.var_26 && this.var_26.figureData && _loc6_)
               {
                  this.var_26.figureData.savePartData(_loc5_,_loc8_.id,_loc6_.getSelectedColorIds(),true);
               }
               _loc3_ = true;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function method_10(param1:String, param2:int) : void
      {
         var _loc3_:CategoryData = this.var_119[param1];
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.selectPartIndex(param2);
         var _loc4_:AvatarEditorGridPartItem = _loc3_.getCurrentPart();
         if(!_loc4_)
         {
            return;
         }
         if(this._view)
         {
            this._view.showPalettes(param1,_loc4_.colorLayerCount);
         }
         if(this.var_26 && this.var_26.figureData)
         {
            this.var_26.figureData.savePartData(param1,_loc4_.id,_loc3_.getSelectedColorIds(),true);
         }
      }
      
      public function selectColor(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:CategoryData = this.var_119[param1];
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.selectColorIndex(param2,param3);
         if(this.var_26 && this.var_26.figureData)
         {
            this.var_26.figureData.savePartSetColourId(param1,_loc4_.getSelectedColorIds(),true);
         }
      }
      
      public function get controller() : HabboAvatarEditor
      {
         return this.var_26;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(!this._isInitialized)
         {
            this.init();
         }
         if(!this._view)
         {
            return null;
         }
         return this._view.getWindowContainer();
      }
      
      public function getCategoryData(param1:String) : CategoryData
      {
         if(!this._isInitialized)
         {
            this.init();
         }
         if(!this.var_119)
         {
            return null;
         }
         return this.var_119[param1];
      }
   }
}
