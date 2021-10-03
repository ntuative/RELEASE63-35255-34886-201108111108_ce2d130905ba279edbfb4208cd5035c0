package com.sulake.room.events
{
   public class RoomObjectMouseEvent extends RoomObjectEvent
   {
      
      public static const const_165:String = "ROE_MOUSE_CLICK";
      
      public static const const_195:String = "ROE_MOUSE_ENTER";
      
      public static const const_671:String = "ROE_MOUSE_MOVE";
      
      public static const const_185:String = "ROE_MOUSE_LEAVE";
      
      public static const const_2338:String = "ROE_MOUSE_DOUBLE_CLICK";
      
      public static const const_677:String = "ROE_MOUSE_DOWN";
       
      
      private var var_1872:String = "";
      
      private var var_2516:Boolean;
      
      private var var_2518:Boolean;
      
      private var var_2517:Boolean;
      
      private var var_2519:Boolean;
      
      public function RoomObjectMouseEvent(param1:String, param2:String, param3:int, param4:String, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false)
      {
         super(param1,param3,param4,param9,param10);
         this.var_1872 = param2;
         this.var_2516 = param5;
         this.var_2518 = param6;
         this.var_2517 = param7;
         this.var_2519 = param8;
      }
      
      public function get eventId() : String
      {
         return this.var_1872;
      }
      
      public function get altKey() : Boolean
      {
         return this.var_2516;
      }
      
      public function get ctrlKey() : Boolean
      {
         return this.var_2518;
      }
      
      public function get shiftKey() : Boolean
      {
         return this.var_2517;
      }
      
      public function get buttonDown() : Boolean
      {
         return this.var_2519;
      }
   }
}
