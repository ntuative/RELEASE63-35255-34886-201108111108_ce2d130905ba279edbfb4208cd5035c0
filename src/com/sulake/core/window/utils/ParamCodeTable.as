package com.sulake.core.window.utils
{
   import com.sulake.core.window.enum.WindowParam;
   import flash.utils.Dictionary;
   
   public class ParamCodeTable extends WindowParam
   {
       
      
      public function ParamCodeTable()
      {
         super();
      }
      
      public static function fillTables(param1:Dictionary, param2:Dictionary = null) : void
      {
         var _loc3_:* = null;
         param1["null"] = const_191;
         param1["bound_to_parent_rect"] = const_105;
         param1["child_window"] = const_1321;
         param1["embedded_controller"] = const_1410;
         param1["expand_to_accommodate_children"] = WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN;
         param1["input_event_processor"] = const_29;
         param1["internal_event_handling"] = const_920;
         param1["mouse_dragging_target"] = const_277;
         param1["mouse_dragging_trigger"] = const_421;
         param1["mouse_scaling_target"] = const_338;
         param1["mouse_scaling_trigger"] = const_599;
         param1["horizontal_mouse_scaling_trigger"] = const_265;
         param1["vertical_mouse_scaling_trigger"] = const_255;
         param1["observe_parent_input_events"] = const_1267;
         param1["parent_window"] = const_1395;
         param1["resize_to_accommodate_children"] = const_186;
         param1["relative_horizontal_scale_center"] = const_223;
         param1["relative_horizontal_scale_fixed"] = const_162;
         param1["relative_horizontal_scale_move"] = const_324;
         param1["relative_horizontal_scale_strech"] = const_447;
         param1["relative_scale_center"] = const_1356;
         param1["relative_scale_fixed"] = const_870;
         param1["relative_scale_move"] = const_1344;
         param1["relative_scale_strech"] = const_1389;
         param1["relative_vertical_scale_center"] = const_213;
         param1["relative_vertical_scale_fixed"] = const_167;
         param1["relative_vertical_scale_move"] = const_311;
         param1["relative_vertical_scale_strech"] = const_308;
         param1["on_resize_align_left"] = const_762;
         param1["on_resize_align_right"] = const_499;
         param1["on_resize_align_center"] = const_621;
         param1["on_resize_align_top"] = const_1021;
         param1["on_resize_align_bottom"] = const_593;
         param1["on_resize_align_middle"] = const_590;
         param1["on_accommodate_align_left"] = const_1429;
         param1["on_accommodate_align_right"] = const_644;
         param1["on_accommodate_align_center"] = const_987;
         param1["on_accommodate_align_top"] = const_1256;
         param1["on_accommodate_align_bottom"] = const_526;
         param1["on_accommodate_align_middle"] = const_947;
         param1["route_input_events_to_parent"] = const_629;
         param1["use_parent_graphic_context"] = const_32;
         param1["draggable_with_mouse"] = const_1245;
         param1["scalable_with_mouse"] = const_1366;
         param1["reflect_horizontal_resize_to_parent"] = const_604;
         param1["reflect_vertical_resize_to_parent"] = const_575;
         param1["reflect_resize_to_parent"] = const_346;
         param1["force_clipping"] = WINDOW_PARAM_FORCE_CLIPPING;
         param1["inherit_caption"] = const_1368;
         if(param2 != null)
         {
            for(param2[param1[_loc3_]] in param1)
            {
            }
         }
      }
   }
}
