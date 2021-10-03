package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetOpenCatalogMessage extends RoomWidgetMessage
   {
      
      public static const const_846:String = "RWGOI_MESSAGE_OPEN_CATALOG";
      
      public static const const_1253:String = "RWOCM_CLUB_MAIN";
      
      public static const const_2168:String = "RWOCM_PIXELS";
      
      public static const const_2252:String = "RWOCM_CREDITS";
      
      public static const const_2363:String = "RWOCM_SHELLS";
       
      
      private var var_2940:String = "";
      
      public function RoomWidgetOpenCatalogMessage(param1:String)
      {
         super(const_846);
         this.var_2940 = param1;
      }
      
      public function get pageKey() : String
      {
         return this.var_2940;
      }
   }
}
