package com.sulake.room.events
{
   public class RoomSpriteMouseEvent
   {
       
      
      private var _type:String = "";
      
      private var var_1872:String = "";
      
      private var var_2041:String = "";
      
      private var var_2636:String = "";
      
      private var var_2637:Number = 0;
      
      private var var_2638:Number = 0;
      
      private var var_2534:Number = 0;
      
      private var var_2533:Number = 0;
      
      private var var_2518:Boolean = false;
      
      private var var_2516:Boolean = false;
      
      private var var_2517:Boolean = false;
      
      private var var_2519:Boolean = false;
      
      public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:Number, param7:Number = 0, param8:Number = 0, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false)
      {
         super();
         this._type = param1;
         this.var_1872 = param2;
         this.var_2041 = param3;
         this.var_2636 = param4;
         this.var_2637 = param5;
         this.var_2638 = param6;
         this.var_2534 = param7;
         this.var_2533 = param8;
         this.var_2518 = param9;
         this.var_2516 = param10;
         this.var_2517 = param11;
         this.var_2519 = param12;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get eventId() : String
      {
         return this.var_1872;
      }
      
      public function get canvasId() : String
      {
         return this.var_2041;
      }
      
      public function get spriteTag() : String
      {
         return this.var_2636;
      }
      
      public function get screenX() : Number
      {
         return this.var_2637;
      }
      
      public function get screenY() : Number
      {
         return this.var_2638;
      }
      
      public function get localX() : Number
      {
         return this.var_2534;
      }
      
      public function get localY() : Number
      {
         return this.var_2533;
      }
      
      public function get ctrlKey() : Boolean
      {
         return this.var_2518;
      }
      
      public function get altKey() : Boolean
      {
         return this.var_2516;
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
