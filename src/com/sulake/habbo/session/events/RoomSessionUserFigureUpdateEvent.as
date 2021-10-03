package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionUserFigureUpdateEvent extends RoomSessionEvent
   {
      
      public static const const_182:String = "RSUBE_FIGURE";
       
      
      private var _userId:int = 0;
      
      private var var_727:String = "";
      
      private var var_1123:String = "";
      
      private var var_2035:String = "";
      
      private var var_2341:int;
      
      public function RoomSessionUserFigureUpdateEvent(param1:IRoomSession, param2:int, param3:String, param4:String, param5:String, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super(const_182,param1,param7,param8);
         this._userId = param2;
         this.var_727 = param3;
         this.var_1123 = param4;
         this.var_2035 = param5;
         this.var_2341 = param6;
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function get figure() : String
      {
         return this.var_727;
      }
      
      public function get gender() : String
      {
         return this.var_1123;
      }
      
      public function get customInfo() : String
      {
         return this.var_2035;
      }
      
      public function get achievementScore() : int
      {
         return this.var_2341;
      }
   }
}
