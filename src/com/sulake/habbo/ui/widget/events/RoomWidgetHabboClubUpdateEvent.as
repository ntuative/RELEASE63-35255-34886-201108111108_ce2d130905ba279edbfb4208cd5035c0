package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_260:String = "RWBIUE_HABBO_CLUB";
       
      
      private var var_2515:int = 0;
      
      private var var_2514:int = 0;
      
      private var var_2512:int = 0;
      
      private var var_2513:Boolean = false;
      
      private var _clubLevel:int;
      
      public function RoomWidgetHabboClubUpdateEvent(param1:int, param2:int, param3:int, param4:Boolean, param5:int, param6:Boolean = false, param7:Boolean = false)
      {
         super(const_260,param6,param7);
         this.var_2515 = param1;
         this.var_2514 = param2;
         this.var_2512 = param3;
         this.var_2513 = param4;
         this._clubLevel = param5;
      }
      
      public function get daysLeft() : int
      {
         return this.var_2515;
      }
      
      public function get periodsLeft() : int
      {
         return this.var_2514;
      }
      
      public function get pastPeriods() : int
      {
         return this.var_2512;
      }
      
      public function get allowClubDances() : Boolean
      {
         return this.var_2513;
      }
      
      public function get clubLevel() : int
      {
         return this._clubLevel;
      }
   }
}
