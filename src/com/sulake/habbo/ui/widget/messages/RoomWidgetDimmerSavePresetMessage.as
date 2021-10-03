package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetDimmerSavePresetMessage extends RoomWidgetMessage
   {
      
      public static const const_904:String = "RWSDPM_SAVE_PRESET";
       
      
      private var var_2851:int;
      
      private var var_2849:int;
      
      private var _color:uint;
      
      private var var_1364:int;
      
      private var var_2850:Boolean;
      
      public function RoomWidgetDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean)
      {
         super(const_904);
         this.var_2851 = param1;
         this.var_2849 = param2;
         this._color = param3;
         this.var_1364 = param4;
         this.var_2850 = param5;
      }
      
      public function get presetNumber() : int
      {
         return this.var_2851;
      }
      
      public function get effectTypeId() : int
      {
         return this.var_2849;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function get brightness() : int
      {
         return this.var_1364;
      }
      
      public function get apply() : Boolean
      {
         return this.var_2850;
      }
   }
}
