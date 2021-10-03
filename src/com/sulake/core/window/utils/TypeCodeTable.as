package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowType;
   import flash.utils.Dictionary;
   
   public class TypeCodeTable extends WindowType
   {
       
      
      public function TypeCodeTable()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:* = null;
         param1["background"] = const_1031;
         param1["badge"] = const_895;
         param1["bitmap"] = const_438;
         param1["border"] = const_900;
         param1["border_notify"] = const_1857;
         param1["bubble"] = const_1035;
         param1["bubble_pointer_up"] = const_1422;
         param1["bubble_pointer_right"] = const_1193;
         param1["bubble_pointer_down"] = const_1291;
         param1["bubble_pointer_left"] = const_1255;
         param1["button"] = const_569;
         param1["button_thick"] = const_791;
         param1["button_icon"] = const_2061;
         param1["button_group_left"] = const_955;
         param1["button_group_center"] = const_812;
         param1["button_group_right"] = const_821;
         param1["canvas"] = const_1030;
         param1["checkbox"] = const_954;
         param1["closebutton"] = const_1274;
         param1["container"] = const_407;
         param1["container_button"] = const_942;
         param1["display_object_wrapper"] = const_837;
         param1["dropmenu"] = const_648;
         param1["dropmenu_item"] = const_632;
         param1["frame"] = const_439;
         param1["frame_notify"] = const_1795;
         param1["header"] = const_978;
         param1["html"] = const_1297;
         param1["icon"] = const_1233;
         param1["itemgrid"] = const_1365;
         param1["itemgrid_horizontal"] = const_628;
         param1["itemgrid_vertical"] = const_787;
         param1["itemlist"] = WINDOW_TYPE_ITEMLIST;
         param1["itemlist_horizontal"] = const_446;
         param1["itemlist_vertical"] = const_412;
         param1["label"] = const_952;
         param1["maximizebox"] = const_2021;
         param1["menu"] = const_2033;
         param1["menu_item"] = const_1942;
         param1["submenu"] = const_1374;
         param1["minimizebox"] = const_2042;
         param1["notify"] = const_1910;
         param1["null"] = const_827;
         param1["password"] = const_1025;
         param1["radiobutton"] = const_740;
         param1["region"] = const_374;
         param1["restorebox"] = const_1856;
         param1["scaler"] = const_508;
         param1["scaler_horizontal"] = const_1929;
         param1["scaler_vertical"] = const_1951;
         param1["scrollbar_horizontal"] = const_554;
         param1["scrollbar_vertical"] = const_742;
         param1["scrollbar_slider_button_up"] = const_1351;
         param1["scrollbar_slider_button_down"] = const_1328;
         param1["scrollbar_slider_button_left"] = const_1186;
         param1["scrollbar_slider_button_right"] = const_1411;
         param1["scrollbar_slider_bar_horizontal"] = const_1268;
         param1["scrollbar_slider_bar_vertical"] = const_1398;
         param1["scrollbar_slider_track_horizontal"] = const_1427;
         param1["scrollbar_slider_track_vertical"] = const_1272;
         param1["scrollable_itemlist"] = const_2063;
         param1["scrollable_itemlist_vertical"] = WINDOW_TYPE_SCROLLABLE_ITEMLIST_VERTICAL;
         param1["scrollable_itemlist_horizontal"] = const_1224;
         param1["selector"] = const_1029;
         param1["selector_list"] = const_1026;
         param1["submenu"] = const_1374;
         param1["tab_button"] = const_822;
         param1["tab_container_button"] = const_1239;
         param1["tab_context"] = const_445;
         param1["tab_content"] = const_1230;
         param1["tab_selector"] = const_774;
         param1["text"] = const_843;
         param1["input"] = const_918;
         param1["toolbar"] = const_1859;
         param1["tooltip"] = const_459;
         if(param2 != null)
         {
            for(param2[param1[_loc3_]] in param1)
            {
            }
         }
      }
   }
}
