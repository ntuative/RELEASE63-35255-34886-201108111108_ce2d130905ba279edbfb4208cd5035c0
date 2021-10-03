package com.sulake.habbo.session
{
   import flash.display.BitmapData;
   
   public class BadgeInfo
   {
       
      
      private var var_49:BitmapData;
      
      private var var_3005:Boolean;
      
      public function BadgeInfo(param1:BitmapData, param2:Boolean)
      {
         super();
         this.var_49 = param1;
         this.var_3005 = param2;
      }
      
      public function get image() : BitmapData
      {
         return this.var_49;
      }
      
      public function get placeHolder() : Boolean
      {
         return this.var_3005;
      }
   }
}
