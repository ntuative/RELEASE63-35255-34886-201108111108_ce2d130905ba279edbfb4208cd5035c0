package com.sulake.habbo.avatar
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.cache.AvatarImageCache;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import flash.display.BitmapData;
   
   public class PlaceholderAvatarImage extends AvatarImage
   {
      
      static var var_917:Map = new Map();
       
      
      public function PlaceholderAvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(!var_1173)
         {
            _structure = null;
            _assets = null;
            var_286 = null;
            var_316 = null;
            var_727 = null;
            var_620 = null;
            var_363 = null;
            if(!var_1450 && var_49)
            {
               var_49.dispose();
            }
            var_49 = null;
            _loc1_ = getCache();
            if(_loc1_)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            var_785 = null;
            var_1173 = true;
         }
      }
      
      override protected function getFullImage(param1:String) : BitmapData
      {
         return var_917[param1];
      }
      
      override protected function cacheFullImage(param1:String, param2:BitmapData) : void
      {
         var_917[param1] = param2;
      }
      
      override public function appendAction(param1:String, ... rest) : Boolean
      {
         var _loc3_:* = null;
         if(rest != null && rest.length > 0)
         {
            _loc3_ = rest[0];
         }
         switch(param1)
         {
            case AvatarAction.const_408:
               switch(_loc3_)
               {
                  case AvatarAction.const_929:
                  case AvatarAction.const_667:
                  case AvatarAction.const_449:
                  case AvatarAction.const_916:
                  case AvatarAction.const_460:
                  case AvatarAction.const_816:
                     super.appendAction.apply(null,[param1].concat(rest));
               }
               break;
            case AvatarAction.const_357:
            case AvatarAction.const_143:
            case AvatarAction.const_310:
            case AvatarAction.const_995:
            case AvatarAction.const_999:
            case AvatarAction.const_748:
               super.addActionData.apply(null,[param1].concat(rest));
         }
         return true;
      }
      
      override public function isPlaceholder() : Boolean
      {
         return true;
      }
   }
}
