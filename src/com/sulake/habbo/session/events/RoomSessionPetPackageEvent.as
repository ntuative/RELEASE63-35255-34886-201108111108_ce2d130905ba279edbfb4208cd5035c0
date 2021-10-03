package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetPackageEvent extends RoomSessionEvent
   {
      
      public static const const_653:String = "RSOPPE_OPEN_PET_PACKAGE_REQUESTED";
      
      public static const const_600:String = "RSOPPE_OPEN_PET_PACKAGE_RESULT";
       
      
      private var var_236:int = -1;
      
      private var var_1307:int = -1;
      
      private var var_2027:int = -1;
      
      private var _color:String = "";
      
      private var var_2032:int = 0;
      
      private var var_2033:String = null;
      
      public function RoomSessionPetPackageEvent(param1:String, param2:IRoomSession, param3:int, param4:int, param5:int, param6:String, param7:int, param8:String, param9:Boolean = false, param10:Boolean = false)
      {
         super(param1,param2,param9,param10);
         this.var_236 = param3;
         this.var_1307 = param4;
         this.var_2027 = param5;
         this._color = param6;
         this.var_2032 = param7;
         this.var_2033 = param8;
      }
      
      public function get objectId() : int
      {
         return this.var_236;
      }
      
      public function get petType() : int
      {
         return this.var_1307;
      }
      
      public function get breed() : int
      {
         return this.var_2027;
      }
      
      public function get color() : String
      {
         return this._color;
      }
      
      public function get nameValidationStatus() : int
      {
         return this.var_2032;
      }
      
      public function get nameValidationInfo() : String
      {
         return this.var_2033;
      }
   }
}
