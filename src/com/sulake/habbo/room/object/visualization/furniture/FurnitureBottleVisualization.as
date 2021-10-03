package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureBottleVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1074:int = 20;
      
      private static const const_695:int = 9;
      
      private static const const_1549:int = -1;
       
      
      private var var_324:Array;
      
      private var var_772:Boolean = false;
      
      public function FurnitureBottleVisualization()
      {
         this.var_324 = new Array();
         super();
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == -1)
         {
            if(!this.var_772)
            {
               this.var_772 = true;
               this.var_324 = new Array();
               this.var_324.push(const_1549);
               return;
            }
         }
         if(param1 >= 0 && param1 <= 7)
         {
            if(this.var_772)
            {
               this.var_772 = false;
               this.var_324 = new Array();
               this.var_324.push(const_1074);
               this.var_324.push(const_695 + param1);
               this.var_324.push(param1);
               return;
            }
            super.setAnimation(param1);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(0))
         {
            if(this.var_324.length > 0)
            {
               super.setAnimation(this.var_324.shift());
            }
         }
         return super.updateAnimation(param1);
      }
   }
}
