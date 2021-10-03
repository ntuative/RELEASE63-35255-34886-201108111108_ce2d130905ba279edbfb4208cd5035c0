package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   
   public class EffectListProxy implements IThumbListDataProvider
   {
       
      
      private var var_78:EffectsModel;
      
      private var var_160:int;
      
      public function EffectListProxy(param1:EffectsModel, param2:int)
      {
         super();
         this.var_78 = param1;
         this.var_160 = param2;
      }
      
      public function dispose() : void
      {
         this.var_78 = null;
      }
      
      public function getDrawableList() : Array
      {
         return this.var_78.getEffects(this.var_160);
      }
   }
}
