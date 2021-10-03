package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1074:int = 20;
      
      private static const const_695:int = 10;
      
      private static const const_1550:int = 31;
      
      private static const const_1549:int = 32;
      
      private static const const_694:int = 30;
       
      
      private var var_324:Array;
      
      private var var_772:Boolean = false;
      
      public function FurnitureValRandomizerVisualization()
      {
         this.var_324 = new Array();
         super();
         super.setAnimation(const_694);
      }
      
      override protected function setAnimation(param1:int) : void
      {
         if(param1 == 0)
         {
            if(!this.var_772)
            {
               this.var_772 = true;
               this.var_324 = new Array();
               this.var_324.push(const_1550);
               this.var_324.push(const_1549);
               return;
            }
         }
         if(param1 > 0 && param1 <= const_695)
         {
            if(this.var_772)
            {
               this.var_772 = false;
               this.var_324 = new Array();
               if(direction == 2)
               {
                  this.var_324.push(const_1074 + 5 - param1);
                  this.var_324.push(const_695 + 5 - param1);
               }
               else
               {
                  this.var_324.push(const_1074 + param1);
                  this.var_324.push(const_695 + param1);
               }
               this.var_324.push(const_694);
               return;
            }
            super.setAnimation(const_694);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(super.getLastFramePlayed(11))
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
