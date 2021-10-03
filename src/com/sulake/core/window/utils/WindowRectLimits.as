package com.sulake.core.window.utils
{
   import com.sulake.core.window.IWindow;
   
   public class WindowRectLimits implements IRectLimiter
   {
       
      
      private var var_334:int = -2.147483648E9;
      
      private var var_333:int = 2.147483647E9;
      
      private var var_332:int = -2.147483648E9;
      
      private var var_331:int = 2.147483647E9;
      
      private var _target:IWindow;
      
      public function WindowRectLimits(param1:IWindow)
      {
         super();
         this._target = param1;
      }
      
      public function get minWidth() : int
      {
         return this.var_334;
      }
      
      public function get maxWidth() : int
      {
         return this.var_333;
      }
      
      public function get minHeight() : int
      {
         return this.var_332;
      }
      
      public function get maxHeight() : int
      {
         return this.var_331;
      }
      
      public function set minWidth(param1:int) : void
      {
         this.var_334 = param1;
         if(this.var_334 > int.MIN_VALUE && !this._target.disposed && this._target.width < this.var_334)
         {
            this._target.width = this.var_334;
         }
      }
      
      public function set maxWidth(param1:int) : void
      {
         this.var_333 = param1;
         if(this.var_333 < int.MAX_VALUE && !this._target.disposed && this._target.width > this.var_333)
         {
            this._target.width = this.var_333;
         }
      }
      
      public function set minHeight(param1:int) : void
      {
         this.var_332 = param1;
         if(this.var_332 > int.MIN_VALUE && !this._target.disposed && this._target.height < this.var_332)
         {
            this._target.height = this.var_332;
         }
      }
      
      public function set maxHeight(param1:int) : void
      {
         this.var_331 = param1;
         if(this.var_331 < int.MAX_VALUE && !this._target.disposed && this._target.height > this.var_331)
         {
            this._target.height = this.var_331;
         }
      }
      
      public function get isEmpty() : Boolean
      {
         return this.var_334 == int.MIN_VALUE && this.var_333 == int.MAX_VALUE && this.var_332 == int.MIN_VALUE && this.var_331 == int.MAX_VALUE;
      }
      
      public function setEmpty() : void
      {
         this.var_334 = int.MIN_VALUE;
         this.var_333 = int.MAX_VALUE;
         this.var_332 = int.MIN_VALUE;
         this.var_331 = int.MAX_VALUE;
      }
      
      public function limit() : void
      {
         if(!this.isEmpty && this._target)
         {
            if(this._target.width < this.var_334)
            {
               this._target.width = this.var_334;
            }
            else if(this._target.width > this.var_333)
            {
               this._target.width = this.var_333;
            }
            if(this._target.height < this.var_332)
            {
               this._target.height = this.var_332;
            }
            else if(this._target.height > this.var_331)
            {
               this._target.height = this.var_331;
            }
         }
      }
      
      public function assign(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.var_334 = param1;
         this.var_333 = param2;
         this.var_332 = param3;
         this.var_331 = param4;
         this.limit();
      }
      
      public function clone(param1:IWindow) : WindowRectLimits
      {
         var _loc2_:WindowRectLimits = new WindowRectLimits(param1);
         _loc2_.var_334 = this.var_334;
         _loc2_.var_333 = this.var_333;
         _loc2_.var_332 = this.var_332;
         _loc2_.var_331 = this.var_331;
         return _loc2_;
      }
   }
}
