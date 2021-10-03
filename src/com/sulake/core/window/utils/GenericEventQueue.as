package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class GenericEventQueue implements IEventQueue, IDisposable
   {
       
      
      protected var _disposed:Boolean = false;
      
      protected var _eventDispatcher:IEventDispatcher;
      
      protected var var_515:Array;
      
      protected var _index:uint = 0;
      
      public function GenericEventQueue(param1:IEventDispatcher)
      {
         super();
         this.var_515 = new Array();
         this._eventDispatcher = param1;
      }
      
      public function get length() : uint
      {
         return this.var_515.length;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            this._eventDispatcher = null;
            this.var_515 = [];
            this._disposed = true;
         }
      }
      
      public function begin() : void
      {
         this._index = 0;
      }
      
      public function next() : Event
      {
         var _loc1_:* = null;
         if(this._index < this.var_515.length)
         {
            _loc1_ = this.var_515[this._index];
            ++this._index;
         }
         return _loc1_;
      }
      
      public function remove() : void
      {
         this.var_515.splice(this._index - 1,1);
         if(this._index > 0)
         {
            --this._index;
         }
      }
      
      public function end() : void
      {
         this._index = 0;
      }
      
      public function flush() : void
      {
         this.var_515.splice(0,this.var_515.length);
         this._index = 0;
      }
      
      protected function eventListener(param1:Event) : void
      {
         this.var_515.push(param1);
      }
   }
}
