package com.sulake.habbo.avatar.structure.animation
{
   import flash.utils.Dictionary;
   
   public class AnimationAction
   {
       
      
      private var _id:String;
      
      private var var_1508:Dictionary;
      
      public function AnimationAction(param1:XML)
      {
         var _loc2_:* = null;
         super();
         this._id = String(param1.@id);
         this.var_1508 = new Dictionary();
         for each(_loc2_ in param1.part)
         {
            this.var_1508[String(_loc2_["set-type"])] = new ActionPart(_loc2_);
         }
      }
      
      public function getPart(param1:String) : ActionPart
      {
         return this.var_1508[param1] as ActionPart;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get parts() : Dictionary
      {
         return this.var_1508;
      }
   }
}
