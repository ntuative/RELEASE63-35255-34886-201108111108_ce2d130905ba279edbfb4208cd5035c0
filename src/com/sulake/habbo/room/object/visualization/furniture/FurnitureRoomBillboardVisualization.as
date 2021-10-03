package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.IRoomObjectModel;
   
   public class FurnitureRoomBillboardVisualization extends FurnitureRoomBrandingVisualization
   {
       
      
      public function FurnitureRoomBillboardVisualization()
      {
         super();
      }
      
      override protected function getAdClickUrl(param1:IRoomObjectModel) : String
      {
         return param1.getString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL);
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         return super.getSpriteXOffset(param1,param2,param3) + var_1741;
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         return super.getSpriteYOffset(param1,param2,param3) + var_1740;
      }
      
      override protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         return super.getSpriteZOffset(param1,param2,param3) + _paramOffsetZ * -1;
      }
   }
}
