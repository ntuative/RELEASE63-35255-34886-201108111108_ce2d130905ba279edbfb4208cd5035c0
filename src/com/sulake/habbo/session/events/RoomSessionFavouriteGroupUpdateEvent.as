package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionFavouriteGroupUpdateEvent extends RoomSessionEvent
   {
      
      public static const const_982:String = "rsfgue_favourite_group_update";
       
      
      private var var_2596:int;
      
      private var var_2597:int;
      
      private var var_438:int;
      
      public function RoomSessionFavouriteGroupUpdateEvent(param1:IRoomSession, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(const_982,param1,param5,param6);
         this.var_2596 = param2;
         this.var_2597 = param3;
         this.var_438 = param4;
      }
      
      public function get roomIndex() : int
      {
         return this.var_2596;
      }
      
      public function get habboGroupId() : int
      {
         return this.var_2597;
      }
      
      public function get status() : int
      {
         return this.var_438;
      }
   }
}
