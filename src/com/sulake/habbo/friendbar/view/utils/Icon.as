package com.sulake.habbo.friendbar.view.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class Icon implements IDisposable
   {
      
      protected static const const_2383:int = 0;
      
      protected static const const_469:int = 1;
      
      protected static const const_2093:int = 2;
      
      protected static const const_2094:int = 3;
      
      protected static const const_124:int = 4;
      
      protected static const const_470:int = 8;
      
      protected static const const_291:int = 18;
      
      protected static const const_2092:int = 18;
       
      
      private var _disposed:Boolean = false;
      
      private var var_2054:Boolean = false;
      
      protected var var_49:BitmapDataAsset;
      
      protected var var_100:IBitmapWrapperWindow;
      
      private var var_1324:uint;
      
      protected var var_228:Timer;
      
      protected var _frame:int = 0;
      
      private var var_712:Point;
      
      protected var var_619:Boolean = false;
      
      protected var _hover:Boolean = false;
      
      public function Icon()
      {
         this.var_1324 = const_469 | const_470;
         this.var_712 = new Point();
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get disabled() : Boolean
      {
         return this.var_2054;
      }
      
      protected function set image(param1:BitmapDataAsset) : void
      {
         this.var_49 = param1;
         this.redraw();
      }
      
      protected function get image() : BitmapDataAsset
      {
         return this.var_49;
      }
      
      protected function set canvas(param1:IBitmapWrapperWindow) : void
      {
         this.var_100 = param1;
         this.redraw();
      }
      
      protected function get canvas() : IBitmapWrapperWindow
      {
         return this.var_100;
      }
      
      protected function set alignment(param1:uint) : void
      {
         this.var_1324 = param1;
         this.redraw();
      }
      
      protected function get alignment() : uint
      {
         return this.var_1324;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this.toggleTimer(false,0);
            this.image = null;
            this.canvas = null;
            this._disposed = true;
         }
      }
      
      public function notify(param1:Boolean) : void
      {
         this.var_619 = param1;
         if(this.var_619 && this.var_2054)
         {
            this.enable(true);
         }
      }
      
      public function hover(param1:Boolean) : void
      {
         this._hover = param1;
      }
      
      public function enable(param1:Boolean) : void
      {
         this.var_2054 = !param1;
      }
      
      protected function redraw() : void
      {
         var _loc1_:* = null;
         if(this.var_100 && !this.var_100.disposed)
         {
            if(!this.var_100.bitmap)
            {
               this.var_100.bitmap = new BitmapData(this.var_100.width,this.var_100.height,true,0);
            }
            else
            {
               this.var_100.bitmap.fillRect(this.var_100.bitmap.rect,0);
            }
            if(this.var_49 && !this.var_49.disposed)
            {
               this.var_712.x = this.var_712.y = 0;
               _loc1_ = this.var_49.content as BitmapData;
               switch(this.var_1324 & const_2094)
               {
                  case const_469:
                     this.var_712.x = this.var_100.bitmap.width / 2 - _loc1_.width / 2;
                     break;
                  case const_2093:
                     this.var_712.x = this.var_100.bitmap.width - _loc1_.width;
               }
               switch(this.var_1324 & const_2092)
               {
                  case const_470:
                     this.var_712.y = this.var_100.bitmap.height / 2 - _loc1_.height / 2;
                     break;
                  case const_291:
                     this.var_712.y = this.var_100.bitmap.height - _loc1_.height;
               }
               this.var_100.bitmap.copyPixels(_loc1_,_loc1_.rect,this.var_712);
               this.var_100.invalidate();
            }
         }
      }
      
      protected function toggleTimer(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            if(!this.var_228)
            {
               this.var_228 = new Timer(param2,0);
               this.var_228.addEventListener(TimerEvent.TIMER,this.onTimerEvent);
               this.var_228.start();
               this.onTimerEvent(null);
            }
            this.var_228.delay = param2;
         }
         else
         {
            this._frame = 0;
            if(this.var_228)
            {
               this.var_228.reset();
               this.var_228.removeEventListener(TimerEvent.TIMER,this.onTimerEvent);
               this.var_228 = null;
            }
         }
      }
      
      protected function onTimerEvent(param1:TimerEvent) : void
      {
      }
   }
}
