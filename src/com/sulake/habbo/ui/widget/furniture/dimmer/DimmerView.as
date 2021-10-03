package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.ICheckBoxWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.enum.HabboWindowParam;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import com.sulake.habbo.window.enum.HabboWindowType;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DimmerView
   {
      
      private static const const_1472:Number = 100;
      
      private static const const_1471:Number = 100;
       
      
      private var _window:IWindowContainer;
      
      private var var_280:ITabContextWindow;
      
      private var var_1462:XML;
      
      private var _widget:DimmerFurniWidget;
      
      private var var_631:DimmerViewColorGrid;
      
      private var var_446:DimmerViewAlphaSlider;
      
      private var var_1463:int;
      
      private var var_550:int;
      
      private var var_2328:int;
      
      public function DimmerView(param1:DimmerFurniWidget)
      {
         super();
         this._widget = param1;
      }
      
      public function get selectedBrightness() : int
      {
         return this.var_1463;
      }
      
      public function get selectedColorIndex() : int
      {
         return this.var_550;
      }
      
      public function get selectedType() : int
      {
         return this.var_2328;
      }
      
      public function dispose() : void
      {
         this.hideInterface();
         this._widget = null;
      }
      
      public function showInterface() : void
      {
         if(this._window == null)
         {
            this.createWindow();
         }
         this.selectPreset(this._widget.selectedPresetIndex);
         this.update();
      }
      
      public function update() : void
      {
         var _loc3_:* = null;
         if(this._window == null || this._widget == null)
         {
            return;
         }
         var _loc1_:* = this._widget.dimmerState == 1;
         var _loc2_:IWindow = this._window.findChildByName("on_off_button");
         if(_loc2_ != null)
         {
            _loc3_ = !!_loc1_ ? "${widget.dimmer.button.off}" : "${widget.dimmer.button.on}";
            _loc2_.caption = _loc3_;
         }
         _loc2_ = this._window.findChildByName("tabbedview");
         if(_loc2_ != null)
         {
            _loc2_.visible = _loc1_;
         }
         _loc2_ = this._window.findChildByName("apply_button");
         if(_loc2_ != null)
         {
            if(_loc1_)
            {
               _loc2_.enable();
            }
            else
            {
               _loc2_.disable();
            }
         }
         _loc2_ = this._window.findChildByName("off_border");
         if(_loc2_)
         {
            _loc2_.visible = !_loc1_;
         }
      }
      
      public function hideInterface() : void
      {
         if(this._widget != null)
         {
            this._widget.removePreview();
         }
         if(this.var_631 != null)
         {
            this.var_631.dispose();
            this.var_631 = null;
         }
         if(this.var_446 != null)
         {
            this.var_446.dispose();
            this.var_446 = null;
         }
         this.var_280 = null;
         if(this._window != null)
         {
            this._window.dispose();
            this._window = null;
         }
      }
      
      private function createWindow() : void
      {
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         if(this._widget == null || this._widget.windowManager == null || this.windowXML == null)
         {
            return;
         }
         this._window = this._widget.windowManager.createWindow("dimmerui_container","",HabboWindowType.const_73,HabboWindowStyle.const_30,0 | 0,new Rectangle(const_1472,const_1471,2,2),null,0) as IWindowContainer;
         this._window.buildFromXML(this.windowXML);
         _loc1_ = this._window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.procedure = this.onWindowClose;
         }
         _loc1_ = this._window.findChildByName("color_grid_container");
         if(_loc1_ != null)
         {
            _loc5_ = (_loc1_ as IWindowContainer).findChildByName("color_grid");
            if(_loc5_ != null)
            {
               this.var_631 = new DimmerViewColorGrid(this,_loc5_ as IItemGridWindow,this._widget.windowManager,this._widget.assets);
            }
         }
         _loc1_ = this._window.findChildByName("brightness_container");
         if(_loc1_ != null)
         {
            this.var_446 = new DimmerViewAlphaSlider(this,_loc1_ as IWindowContainer,this._widget.assets);
         }
         this.var_280 = ITabContextWindow(this._window.findChildByName("tab_context"));
         this.selectTab(this._widget.selectedPresetIndex);
         var _loc2_:int = 0;
         while(_loc2_ < this.var_280.numTabItems)
         {
            _loc6_ = this.var_280.getTabItemAt(_loc2_);
            _loc6_.setParamFlag(HabboWindowParam.const_46,true);
            _loc6_.procedure = this.onTabClick;
            _loc2_++;
         }
         _loc1_ = this._window.findChildByName("type_checkbox");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseEvent);
         }
         _loc1_ = this._window.findChildByName("apply_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseEvent);
         }
         _loc1_ = this._window.findChildByName("on_off_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK,this.onMouseEvent);
         }
         var _loc3_:IBitmapWrapperWindow = this._window.findChildByName("off_image") as IBitmapWrapperWindow;
         var _loc4_:BitmapDataAsset = this._widget.assets.getAssetByName("dimmer_info") as BitmapDataAsset;
         if(_loc3_ != null && _loc4_ != null)
         {
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height);
            _loc7_ = _loc4_.content as BitmapData;
            if(_loc7_ != null)
            {
               _loc3_.bitmap.copyPixels(_loc7_,_loc7_.rect,new Point(0,0));
            }
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "type_checkbox":
               _loc4_ = param1.target as ICheckBoxWindow;
               if(_loc4_ == null)
               {
                  return;
               }
               if(_loc4_.isSelected)
               {
                  this.selectedType = 2;
               }
               else
               {
                  this.selectedType = 1;
               }
               this._widget.previewCurrentSetting();
               break;
            case "apply_button":
               this._widget.storeCurrentSetting(true);
               break;
            case "cancel":
            case "close":
               this.hideInterface();
               break;
            case "on_off_button":
               this._widget.changeRoomDimmerState();
         }
      }
      
      private function onTabClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowEvent.const_47)
         {
            return;
         }
         this._widget.storeCurrentSetting(false);
         var _loc3_:int = param2.id;
         this.selectPreset(_loc3_);
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            return;
         }
         this.hideInterface();
      }
      
      private function selectPreset(param1:int) : void
      {
         if(this._widget == null || this._widget.presets == null || param1 < 0 || param1 >= this._widget.presets.length)
         {
            return;
         }
         this._widget.selectedPresetIndex = param1;
         var _loc2_:DimmerFurniWidgetPresetItem = this._widget.presets[param1];
         if(_loc2_ == null)
         {
            return;
         }
         this.selectTab(param1);
         this.var_1463 = _loc2_.light;
         if(this.var_446 != null)
         {
            this.var_446.setValue(this.var_1463);
         }
         this.var_550 = this.colors.indexOf(_loc2_.color);
         if(this.var_631 != null)
         {
            this.var_631.setSelectedColorIndex(this.var_550);
         }
         this.selectedType = _loc2_.type;
         this._widget.previewCurrentSetting();
      }
      
      private function selectTab(param1:int) : void
      {
         if(this.var_280 == null)
         {
            return;
         }
         var _loc2_:IWindow = this.var_280.getTabItemAt(param1);
         if(_loc2_ != null)
         {
            this.var_280.selector.setSelected(_loc2_ as ISelectableWindow);
         }
      }
      
      private function getSelectedTabIndex() : int
      {
         if(this.var_280 == null)
         {
            return -1;
         }
         var _loc1_:ISelectableWindow = this.var_280.selector.getSelected();
         return this.var_280.selector.getSelectableIndex(_loc1_);
      }
      
      private function get windowXML() : XML
      {
         if(this.var_1462 != null)
         {
            return this.var_1462;
         }
         if(this._widget == null || this._widget.assets == null || this._widget.assets.getAssetByName("dimmer_ui") == null)
         {
            return null;
         }
         var _loc1_:XmlAsset = XmlAsset(this._widget.assets.getAssetByName("dimmer_ui"));
         this.var_1462 = XML(_loc1_.content);
         return this.var_1462;
      }
      
      public function get colors() : Array
      {
         if(this._widget == null)
         {
            return null;
         }
         return this._widget.colors;
      }
      
      public function set selectedType(param1:int) : void
      {
         if(param1 != 1 && param1 != 2)
         {
            return;
         }
         this.var_2328 = param1;
         var _loc2_:ICheckBoxWindow = this._window.findChildByName("type_checkbox") as ICheckBoxWindow;
         if(_loc2_ != null)
         {
            if(param1 == 2)
            {
               _loc2_.select();
            }
            else
            {
               _loc2_.unselect();
            }
         }
         if(this.var_446 != null)
         {
            this.var_446.min = this._widget.method_15[param1 - 1];
         }
      }
      
      public function set selectedColorIndex(param1:int) : void
      {
         this.var_550 = param1;
         if(this.var_631 != null)
         {
            this.var_631.setSelectedColorIndex(param1);
         }
         this._widget.previewCurrentSetting();
      }
      
      public function set selectedBrightness(param1:int) : void
      {
         this.var_1463 = param1;
         if(this.var_446 != null)
         {
            this.var_446.setValue(param1);
         }
         this._widget.previewCurrentSetting();
      }
   }
}
