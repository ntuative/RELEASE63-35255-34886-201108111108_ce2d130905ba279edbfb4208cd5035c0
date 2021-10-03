package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class FurnitureRoomBillboardLogic extends FurnitureRoomBrandingLogic
   {
       
      
      public function FurnitureRoomBillboardLogic()
      {
         super();
         var_1730 = true;
      }
      
      override protected function getAdClickUrl(param1:IRoomObjectModelController) : String
      {
         return param1.getString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL);
      }
      
      override protected function handleAdClick(param1:int, param2:String, param3:String) : void
      {
         HabboWebTools.openWebPage(param3);
      }
   }
}
