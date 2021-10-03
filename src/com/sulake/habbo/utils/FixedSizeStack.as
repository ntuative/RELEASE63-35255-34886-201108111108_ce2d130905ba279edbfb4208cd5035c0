package com.sulake.habbo.utils
{
   public class FixedSizeStack
   {
       
      
      private var _data:Array;
      
      private var var_1302:int = 0;
      
      private var _index:int = 0;
      
      public function FixedSizeStack(param1:int)
      {
         this._data = [];
         super();
         this.var_1302 = param1;
      }
      
      public function reset() : void
      {
         this._data = [];
         this._index = 0;
      }
      
      public function addValue(param1:int) : void
      {
         if(this._data.length < this.var_1302)
         {
            this._data.push(param1);
         }
         else
         {
            this._data[this._index] = param1;
         }
         this._index = (this._index + 1) % this.var_1302;
      }
      
      public function getMax() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.var_1302)
         {
            if(this._data[_loc2_] > _loc1_)
            {
               _loc1_ = this._data[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getMin() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.var_1302)
         {
            if(this._data[_loc2_] < _loc1_)
            {
               _loc1_ = this._data[_loc2_];
            }
            _loc2_++;
         }
         return _loc1_;
      }
   }
}
