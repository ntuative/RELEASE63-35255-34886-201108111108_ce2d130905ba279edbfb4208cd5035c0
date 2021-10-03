package com.sulake.habbo.avatar.generic
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.avatar.figuredata.FigureData;
   
   public class BodyModel extends CategoryBaseModel implements IAvatarEditorCategoryModel, IAvatarImageListener
   {
       
      
      private var var_2821:Boolean;
      
      public function BodyModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory(FigureData.const_87);
         _isInitialized = true;
         if(!_view)
         {
            _view = new BodyView(this,controller.manager.windowManager,controller.manager.assets);
            if(_view)
            {
               _view.init();
            }
         }
      }
      
      override public function switchCategory(param1:String) : void
      {
      }
      
      override public function selectColor(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:CategoryData = var_119[param1];
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.selectColorIndex(param2,param3);
         var_26.figureData.savePartSetColourId(param1,_loc4_.getSelectedColorIds(),true);
         this.updateSelectionsFromFigure(FigureData.const_87);
      }
      
      override protected function updateSelectionsFromFigure(param1:String) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(!var_119)
         {
            return;
         }
         var _loc2_:int = var_26.figureData.getPartSetId(FigureData.const_87);
         var _loc3_:Array = var_26.figureData.getColourIds(FigureData.const_87);
         var _loc4_:CategoryData = var_119[param1];
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.selectPartId(_loc2_);
         _loc4_.selectColorIds(_loc3_);
         for each(_loc5_ in _loc4_.parts)
         {
            _loc6_ = var_26.figureData.getFigureStringWithFace(_loc5_.id);
            _loc7_ = var_26.manager.avatarRenderManager.createAvatarImage(_loc6_,AvatarScaleType.const_61,null,this);
            _loc5_.iconImage = _loc7_.getCroppedImage(AvatarSetType.const_56);
            _loc7_.dispose();
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(!this.var_2821)
         {
            this.var_2821 = true;
            this.updateSelectionsFromFigure(FigureData.const_87);
         }
      }
   }
}
