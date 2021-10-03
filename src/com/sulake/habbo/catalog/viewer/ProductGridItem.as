package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.enum.MouseCursorType;
   import com.sulake.core.window.enum.WindowState;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.enum.HabboWindowStyle;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ProductGridItem implements IGridItem
   {
      
      private static const const_1056:String = "bg";
       
      
      protected var _view:IWindowContainer;
      
      private var var_224:IItemGrid;
      
      protected var _icon:IBitmapWrapperWindow;
      
      private var _disposed:Boolean = false;
      
      private var var_566:Object;
      
      public function ProductGridItem()
      {
         super();
      }
      
      public function get view() : IWindowContainer
      {
         return this._view;
      }
      
      public function set grid(param1:IItemGrid) : void
      {
         this.var_224 = param1;
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
         this.var_224 = null;
         this._icon = null;
         if(this._view != null)
         {
            this._view.dispose();
            this._view = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function activate() : void
      {
         this._view.getChildByName(const_1056).style = HabboWindowStyle.const_30;
      }
      
      public function deActivate() : void
      {
         this._view.getChildByName(const_1056).style = 3;
      }
      
      public function set view(param1:IWindowContainer) : void
      {
         if(!param1)
         {
            return;
         }
         this._view = param1;
         this._view.procedure = this.eventProc;
         this._icon = this._view.findChildByName("image") as IBitmapWrapperWindow;
         var _loc2_:IWindow = this._view.findChildByName("multiContainer");
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
      }
      
      public function setDraggable(param1:Boolean) : void
      {
         if(this._view && param1)
         {
            (this._view as IInteractiveWindow).setMouseCursorForState(WindowState.const_88,MouseCursorType.const_807);
            (this._view as IInteractiveWindow).setMouseCursorForState(0 | 0,MouseCursorType.const_807);
         }
      }
      
      private function eventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Boolean = false;
         if(param1.type == WindowMouseEvent.const_54)
         {
            this.var_566 = null;
         }
         else if(param1.type == WindowMouseEvent.const_43)
         {
            Logger.log(this._view.state);
            if(param2 == null)
            {
               return;
            }
            this.var_224.select(this);
            this.var_566 = param2;
         }
         else if(param1.type == WindowMouseEvent.const_25 && this.var_566 != null && this.var_566 == param2)
         {
            _loc3_ = this.var_224.startDragAndDrop(this);
            if(_loc3_)
            {
               this.var_566 = null;
            }
         }
         else if(param1.type == WindowMouseEvent.const_54)
         {
            this.var_566 = null;
         }
         else if(param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
         {
            this.var_566 = null;
         }
         else if(param1.type == WindowMouseEvent.const_173)
         {
            this.var_566 = null;
         }
      }
      
      protected function setIconImage(param1:BitmapData, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(this._icon != null && !this._icon.disposed)
         {
            _loc3_ = (this._icon.width - param1.width) / 2;
            _loc4_ = (this._icon.height - param1.height) / 2;
            if(this._icon.bitmap == null)
            {
               this._icon.bitmap = new BitmapData(this._icon.width,this._icon.height,true,16777215);
            }
            this._icon.bitmap.fillRect(this._icon.bitmap.rect,16777215);
            this._icon.bitmap.copyPixels(param1,param1.rect,new Point(_loc3_,_loc4_),null,null,false);
            this._icon.invalidate();
         }
         if(param2)
         {
            param1.dispose();
         }
      }
   }
}
