package com.sulake.habbo.avatar.animation
{
   public class ShadowDataContainer
   {
       
      
      private var _id:String;
      
      public function ShadowDataContainer(param1:XML)
      {
         super();
         this._id = String(param1.@id);
      }
   }
}
