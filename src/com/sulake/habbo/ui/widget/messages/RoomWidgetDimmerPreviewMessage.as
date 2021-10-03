package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetDimmerPreviewMessage extends RoomWidgetMessage
   {
      
      public static const const_814:String = "RWDPM_PREVIEW_DIMMER_PRESET";
       
      
      private var _color:uint;
      
      private var var_1364:int;
      
      private var var_2415:Boolean;
      
      public function RoomWidgetDimmerPreviewMessage(param1:uint, param2:int, param3:Boolean)
      {
         super(const_814);
         this._color = param1;
         this.var_1364 = param2;
         this.var_2415 = param3;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function get brightness() : int
      {
         return this.var_1364;
      }
      
      public function get bgOnly() : Boolean
      {
         return this.var_2415;
      }
   }
}
