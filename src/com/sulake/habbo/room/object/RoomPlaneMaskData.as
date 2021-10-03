package com.sulake.habbo.room.object
{
   public class RoomPlaneMaskData
   {
       
      
      private var var_2327:Number = 0.0;
      
      private var var_2326:Number = 0.0;
      
      private var var_2325:Number = 0.0;
      
      private var var_2324:Number = 0.0;
      
      public function RoomPlaneMaskData(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super();
         this.var_2327 = param1;
         this.var_2326 = param2;
         this.var_2325 = param3;
         this.var_2324 = param4;
      }
      
      public function get leftSideLoc() : Number
      {
         return this.var_2327;
      }
      
      public function get rightSideLoc() : Number
      {
         return this.var_2326;
      }
      
      public function get leftSideLength() : Number
      {
         return this.var_2325;
      }
      
      public function get rightSideLength() : Number
      {
         return this.var_2324;
      }
   }
}
