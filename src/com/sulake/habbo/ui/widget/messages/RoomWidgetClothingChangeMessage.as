package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetClothingChangeMessage extends RoomWidgetMessage
   {
      
      public static const const_813:String = "RWCCM_REQUEST_EDITOR";
       
      
      private var var_236:int = 0;
      
      private var var_2357:int = 0;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1123:String = "";
      
      public function RoomWidgetClothingChangeMessage(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int)
      {
         super(param1);
         this.var_1123 = param2;
         this.var_236 = param3;
         this.var_2357 = param4;
         this._roomId = param5;
         this._roomCategory = param6;
      }
      
      public function get objectId() : int
      {
         return this.var_236;
      }
      
      public function get objectCategory() : int
      {
         return this.var_2357;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
      
      public function get gender() : String
      {
         return this.var_1123;
      }
   }
}
