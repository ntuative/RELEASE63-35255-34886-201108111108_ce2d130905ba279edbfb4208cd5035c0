package com.sulake.core.window
{
   import com.sulake.core.window.components.ActivatorController;
   import com.sulake.core.window.components.BackgroundController;
   import com.sulake.core.window.components.BadgeController;
   import com.sulake.core.window.components.BitmapWrapperController;
   import com.sulake.core.window.components.BorderController;
   import com.sulake.core.window.components.BubbleController;
   import com.sulake.core.window.components.ButtonController;
   import com.sulake.core.window.components.CanvasController;
   import com.sulake.core.window.components.CheckBoxController;
   import com.sulake.core.window.components.CloseButtonController;
   import com.sulake.core.window.components.ContainerButtonController;
   import com.sulake.core.window.components.ContainerController;
   import com.sulake.core.window.components.DisplayObjectWrapperController;
   import com.sulake.core.window.components.DropMenuController;
   import com.sulake.core.window.components.DropMenuItemController;
   import com.sulake.core.window.components.FrameController;
   import com.sulake.core.window.components.HTMLTextController;
   import com.sulake.core.window.components.HeaderController;
   import com.sulake.core.window.components.IconController;
   import com.sulake.core.window.components.ItemGridController;
   import com.sulake.core.window.components.ItemListController;
   import com.sulake.core.window.components.PasswordFieldController;
   import com.sulake.core.window.components.RadioButtonController;
   import com.sulake.core.window.components.RegionController;
   import com.sulake.core.window.components.ScalerController;
   import com.sulake.core.window.components.ScrollableItemListWindow;
   import com.sulake.core.window.components.ScrollbarController;
   import com.sulake.core.window.components.ScrollbarLiftController;
   import com.sulake.core.window.components.SelectableButtonController;
   import com.sulake.core.window.components.SelectorController;
   import com.sulake.core.window.components.TabButtonController;
   import com.sulake.core.window.components.TabContainerButtonController;
   import com.sulake.core.window.components.TabContextController;
   import com.sulake.core.window.components.TabSelectorController;
   import com.sulake.core.window.components.TextController;
   import com.sulake.core.window.components.TextFieldController;
   import com.sulake.core.window.components.TextLabelController;
   import com.sulake.core.window.components.ToolTipController;
   import com.sulake.core.window.enum.WindowType;
   import flash.utils.Dictionary;
   
   public class Classes
   {
      
      protected static var var_13:Dictionary;
       
      
      public function Classes()
      {
         super();
      }
      
      public static function init() : void
      {
         if(!var_13)
         {
            var_13 = new Dictionary();
            var_13["null"] = WindowController;
            var_13["null"] = ActivatorController;
            var_13["null"] = BackgroundController;
            var_13["null"] = BadgeController;
            var_13["null"] = BorderController;
            var_13["null"] = BubbleController;
            var_13["null"] = WindowController;
            var_13["null"] = WindowController;
            var_13["null"] = WindowController;
            var_13["null"] = WindowController;
            var_13["null"] = ButtonController;
            var_13["null"] = ButtonController;
            var_13["null"] = SelectableButtonController;
            var_13["null"] = SelectableButtonController;
            var_13["null"] = SelectableButtonController;
            var_13["null"] = BitmapWrapperController;
            var_13["null"] = CanvasController;
            var_13["null"] = CheckBoxController;
            var_13["null"] = ContainerController;
            var_13["null"] = ContainerButtonController;
            var_13["null"] = CloseButtonController;
            var_13["null"] = DisplayObjectWrapperController;
            var_13["null"] = ScrollbarLiftController;
            var_13["null"] = DropMenuController;
            var_13["null"] = DropMenuItemController;
            var_13["null"] = FrameController;
            var_13["null"] = HeaderController;
            var_13["null"] = HTMLTextController;
            var_13["null"] = IconController;
            var_13["null"] = ItemListController;
            var_13["null"] = ItemListController;
            var_13["null"] = ItemListController;
            var_13["null"] = ItemGridController;
            var_13["null"] = ItemGridController;
            var_13["null"] = ItemGridController;
            var_13["null"] = TextLabelController;
            var_13["null"] = PasswordFieldController;
            var_13["null"] = RadioButtonController;
            var_13["null"] = RegionController;
            var_13["null"] = ScalerController;
            var_13["null"] = ScrollbarController;
            var_13["null"] = ScrollbarController;
            var_13["null"] = ButtonController;
            var_13["null"] = ButtonController;
            var_13["null"] = ButtonController;
            var_13["null"] = ButtonController;
            var_13["null"] = ScrollbarLiftController;
            var_13["null"] = ScrollbarLiftController;
            var_13["null"] = WindowController;
            var_13["null"] = WindowController;
            var_13["null"] = ScrollableItemListWindow;
            var_13["null"] = SelectorController;
            var_13["null"] = TabSelectorController;
            var_13["null"] = TabButtonController;
            var_13["null"] = TabContainerButtonController;
            var_13["null"] = ContainerController;
            var_13["null"] = TabContextController;
            var_13["null"] = TabSelectorController;
            var_13["null"] = TextController;
            var_13["null"] = TextFieldController;
            var_13["null"] = ToolTipController;
         }
      }
      
      public static function getWindowClassByType(param1:uint) : Class
      {
         return var_13[param1];
      }
   }
}
