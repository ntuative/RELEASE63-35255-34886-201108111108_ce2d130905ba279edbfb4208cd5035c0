package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IBorderWindow;
   import com.sulake.core.window.components.IContainerButtonWindow;
   import com.sulake.core.window.components.ITextWindow;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class PlayListEditorItem
   {
      
      public static const const_544:String = "PLEI_ICON_STATE_NORMAL";
      
      public static const const_1203:String = "PLEI_ICON_STATE_PLAYING";
      
      private static const const_1498:uint = 14283002;
      
      private static const const_1497:uint = 15856113;
       
      
      private var _widget:PlayListEditorWidget;
      
      private var _window:IWindowContainer;
      
      private var var_2478:IContainerButtonWindow = null;
      
      private var var_904:ColorTransform;
      
      public function PlayListEditorItem(param1:PlayListEditorWidget, param2:String, param3:String, param4:ColorTransform)
      {
         super();
         this._widget = param1;
         this.var_904 = param4;
         this.createWindow();
         this.setIconState(const_544);
         this.deselect();
         this.trackName = param2;
         this.trackAuthor = param3;
         this.diskColor = param4;
      }
      
      public function get window() : IWindow
      {
         return this._window as IWindow;
      }
      
      public function get removeButton() : IContainerButtonWindow
      {
         return this.var_2478;
      }
      
      private function createWindow() : void
      {
         var _loc2_:* = null;
         if(this._widget == null)
         {
            return;
         }
         var _loc1_:XmlAsset = this._widget.assets.getAssetByName("playlisteditor_playlist_item") as XmlAsset;
         this._window = this._widget.windowManager.buildFromXML(_loc1_.content as XML) as IWindowContainer;
         if(this._window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _loc2_ = this._widget.assets.getAssetByName("icon_arrow_left") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            if(_loc2_.content != null)
            {
               this.buttonRemoveBitmap = _loc2_.content as BitmapData;
            }
         }
         this.assignAssetByNameToElement("jb_icon_disc",this._window.getChildByName("song_name_icon_bitmap") as IBitmapWrapperWindow);
         this.assignAssetByNameToElement("jb_icon_composer",this._window.getChildByName("author_name_icon_bitmap") as IBitmapWrapperWindow);
         var _loc3_:IWindowContainer = this._window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc3_ != null)
         {
            _loc3_ = _loc3_.getChildByName("button_border") as IWindowContainer;
            if(_loc3_ != null)
            {
               this.var_2478 = _loc3_.getChildByName("button_remove_from_playlist") as IContainerButtonWindow;
            }
         }
      }
      
      public function select() : void
      {
         var _loc1_:IBorderWindow = this._window.getChildByName("background") as IBorderWindow;
         if(_loc1_ != null)
         {
            _loc1_.color = const_1498;
         }
         var _loc2_:IWindowContainer = this._window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
         var _loc3_:IBorderWindow = this._window.getChildByName("selected") as IBorderWindow;
         if(_loc3_ != null)
         {
            _loc3_.visible = true;
         }
      }
      
      public function deselect() : void
      {
         var _loc1_:IBorderWindow = this._window.getChildByName("background") as IBorderWindow;
         if(_loc1_ != null)
         {
            _loc1_.color = const_1497;
         }
         var _loc2_:IWindowContainer = this._window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
         var _loc3_:IBorderWindow = this._window.getChildByName("selected") as IBorderWindow;
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
      }
      
      public function setIconState(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         switch(param1)
         {
            case const_544:
               this.diskColor = this.var_904;
               break;
            case const_1203:
               _loc2_ = this._widget.assets.getAssetByName("icon_notes_small") as BitmapDataAsset;
               if(_loc2_ == null)
               {
                  return;
               }
               if(_loc2_.content != null)
               {
                  _loc3_ = _loc2_.content as BitmapData;
                  this.diskIconBitmap = _loc3_.clone();
               }
               break;
         }
      }
      
      public function set diskColor(param1:ColorTransform) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:BitmapDataAsset = this._widget.assets.getAssetByName("icon_cd_small") as BitmapDataAsset;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.content != null)
         {
            _loc3_ = _loc2_.content as BitmapData;
            _loc4_ = _loc3_.clone();
            if(_loc4_ != null)
            {
               _loc4_.colorTransform(_loc3_.rect,param1);
               this.diskIconBitmap = _loc4_;
            }
         }
      }
      
      public function set trackName(param1:String) : void
      {
         var _loc2_:ITextWindow = this._window.getChildByName("song_title_text") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      public function set trackAuthor(param1:String) : void
      {
         var _loc2_:ITextWindow = this._window.getChildByName("song_author_text") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.text = param1;
         }
      }
      
      private function set diskIconBitmap(param1:BitmapData) : void
      {
         var _loc2_:IBitmapWrapperWindow = this._window.getChildByName("disk_image") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.bitmap = param1;
         }
      }
      
      private function set buttonRemoveBitmap(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = this._window.getChildByName("action_buttons") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_ = _loc2_.getChildByName("button_border") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_ = _loc2_.getChildByName("button_remove_from_playlist") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperWindow = _loc2_.getChildByName("button_remove_from_playlist_image") as IBitmapWrapperWindow;
         if(_loc3_ != null)
         {
            _loc3_.bitmap = param1.clone();
            _loc3_.width = param1.width;
            _loc3_.height = param1.height;
         }
      }
      
      private function assignAssetByNameToElement(param1:String, param2:IBitmapWrapperWindow) : void
      {
         var _loc4_:* = null;
         var _loc3_:BitmapDataAsset = this._widget.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc3_ != null)
         {
            if(param2 != null && _loc3_.content != null)
            {
               _loc4_ = _loc3_.content as BitmapData;
               param2.bitmap = _loc4_.clone();
            }
         }
      }
   }
}
