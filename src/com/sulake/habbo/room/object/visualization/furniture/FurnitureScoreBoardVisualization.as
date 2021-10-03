package com.sulake.habbo.room.object.visualization.furniture
{
   public class FurnitureScoreBoardVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const const_1543:String = "ones_sprite";
      
      private static const const_1546:String = "tens_sprite";
      
      private static const const_1544:String = "hundreds_sprite";
      
      private static const const_1545:String = "thousands_sprite";
       
      
      public function FurnitureScoreBoardVisualization()
      {
         super();
      }
      
      override public function get animationId() : int
      {
         return 0;
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         var _loc3_:String = getSpriteTag(param1,direction,param2);
         var _loc4_:int = super.animationId;
         switch(_loc3_)
         {
            case const_1543:
               return _loc4_ % 10;
            case const_1546:
               return _loc4_ / 10 % 10;
            case const_1544:
               return _loc4_ / 100 % 10;
            case const_1545:
               return _loc4_ / 1000 % 10;
            default:
               return super.getFrameNumber(param1,param2);
         }
      }
   }
}
